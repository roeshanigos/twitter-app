//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *refreshIndicator;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 150;
    
    //we have to initialize a mutable array
    self.tweets = [[NSMutableArray alloc] init];
    
    //gets the function
    [self fetchTweets];
    
    //ASK ABOUT THIS LOGIC
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self. refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    
    
}

- (void)fetchTweets {
    [self.refreshIndicator startAnimating];

    // this is the twitter timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        [self.tweets removeAllObjects];
        // runs this block to request the tweets
        if (tweets) {
            
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
                //actually adding the tweets to the timeline below
                [self.tweets addObject:tweet];
            }
            //telling tableView to reload since data is already fed
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            [self.tableView reloadData];
        }
        [self.refreshIndicator stopAnimating];

    }];
    [self.refreshControl endRefreshing];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //recycling and showing cells
    TweetCell *tweetCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    tweetCell.tweet = self.tweets[indexPath.row];

    
    return tweetCell;

}


- (void)didTweet:(Tweet *)tweet{
    [self.tweets addObject:tweet];
    [self.tableView reloadData];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //EXPLAIN THIS (ASK FOR HELP)
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}



@end
