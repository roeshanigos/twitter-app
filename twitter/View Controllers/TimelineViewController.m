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
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "AppDelegate.h"
#import "InfiniteScrollActivityView.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>


@property (strong, nonatomic) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *refreshIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *composeButton;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) InfiniteScrollActivityView* loadingMoreView;



@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //we have to initialize a mutable array
    self.tweets = [[NSMutableArray alloc] init];
    
    //gets the function
    [self fetchTweets];
    
    //ASK ABOUT THIS LOGIC
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self. refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    
    bool isMoreDataLoading = false;
    InfiniteScrollActivityView* loadingMoreView;
    
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    loadingMoreView.hidden = true;
    [self.tableView addSubview:loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;

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
    if ([segue.identifier isEqual:@"tweetCompose" ]) {
        UINavigationController *navigationController = [segue destinationViewController];
        //making a delegate
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    else if ([segue.identifier isEqual:@"detailTweet" ]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweets[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.tweet = tweet;
    }
    else {
        UIButton *tappedButton = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedButton];
        Tweet *tweet = self.tweets[indexPath.row];
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.tweet = tweet;
        
    }
    
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
    
}


-(void)getMoreData{
    [[APIManager shared] getHomeWithTimeline:@200 completion:^(NSArray *tweets, NSError *error) {
        if (tweets){
            self.tweets = [NSMutableArray arrayWithArray: tweets];
            [self.tableView reloadData];
        }
        else {
            NSLog(@"oopsies");
        }
    }];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            
            // Update position of loadingMoreView, and start loading indicator
            //CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            //self.loadingMoreView.frame = frame;
            //[self.loadingMoreView startAnimating];
            
            // Code to load more results
            [self getMoreData];
        }
    }
}


@end
