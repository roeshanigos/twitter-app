//
//  ProfileViewController.m
//  twitter
//
//  Created by Roesha Nigos on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *proPicView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameLabel.text =  self.tweet.user.name;
    self.screenNameLabel.text =  [NSString stringWithFormat:@"@%@",  self.tweet.user.screenName];
    self.proPicView.image = nil;
    [self.proPicView setImageWithURL:self.tweet.user.proPicURL];
    self.proPicView.layer.cornerRadius = self.proPicView.frame.size.height/2;
    self.followerCountLabel.text =  [NSString stringWithFormat:@"%d",  self.tweet.user.followerCount];
    self.followingCountLabel.text =  [NSString stringWithFormat:@"%d",  self.tweet.user.friendsCount];

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
