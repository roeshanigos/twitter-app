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

@end
