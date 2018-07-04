//
//  TweetCell.m
//  twitter
//
//  Created by Roesha Nigos on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.nameLabel.text =  tweet.user.name;
    self.screenNameLabel.text =  [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAtLabel.text =  tweet.createdAtString;
    self.tweetTextLabel.text =  tweet.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.replyCountLabel.text = [NSString stringWithFormat:@"%d", tweet.replyCount];
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:tweet.user.proPicURL];
}

- (IBAction)didTapFavor:(id)sender {
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) { 
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

-(void)refreshData {
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.replyCount];

}



@end
