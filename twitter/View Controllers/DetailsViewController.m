//
//  DetailsViewController.m
//  twitter
//
//  Created by Roesha Nigos on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *proPicView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favCountLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameLabel.text =  self.tweet.user.name;
    self.screenNameLabel.text =  [NSString stringWithFormat:@"@%@",  self.tweet.user.screenName];
    self.createdAtLabel.text =  self.tweet.createdAtString;
    self.tweetTextLabel.text =  self.tweet.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.replyCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.replyCount];
    self.proPicView.image = nil;
    [self.proPicView setImageWithURL:self.tweet.user.proPicURL];
    self.proPicView.layer.cornerRadius = self.proPicView.frame.size.height/2;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
