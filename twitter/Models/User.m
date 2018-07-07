//
//  User.m
//  twitter
//
//  Created by Roesha Nigos on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.followerCount = [dictionary[@"follower_count"] intValue];
        self.friendsCount = [dictionary[@"friends_count"] intValue];
        self.proPicURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        
    }
    return self;
}


@end
