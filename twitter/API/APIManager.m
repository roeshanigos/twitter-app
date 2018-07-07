//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "Tweet.h"


static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"wEWyJsBDy2AHFT1h5zWkBCmN5";
static NSString * const consumerSecret = @"xRMNXzo12Sx1NiLOIAmiZvJh4LGYdwrdr2mgFW9xN7A55HK7mZ";

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion {
    
    [self GET:@"1.1/statuses/home_timeline.json"
   parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
       NSMutableArray *tweets = [Tweet tweetsWithArray:tweetDictionaries];
       // Manually cache the tweets. If the request fails, restore from cache if possible.
       //storing the tweet as tweet dictionary  (an array of tweets sepcified in method)
       //saving the tweet ductionaries and ASK
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweetDictionaries];
       //ASK
       [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"hometimeline_tweets"];

       completion(tweets, nil);
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       //when network call fails and set it to nil so it knows there is nothing in the array
       NSMutableArray *tweets = nil;
       
       // Fetch tweets from cache if possible (stored tweets)
       NSData *storedData = [[NSUserDefaults standardUserDefaults] valueForKey:@"hometimeline_tweets"];
       if (storedData != nil) {
           //array of tweets
           tweets = [Tweet tweetsWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:storedData]];
       }
     
       completion(tweets, error);
   }];
}
    

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}



- (void)getHomeWithTimeline:(NSNumber *)number completion:(void (^)(NSArray *, NSError *))completion{
//how many tweets fetch (default was 20)
    
    //giving the number argument
    NSDictionary *parameters = @{@"count": number};
    [self GET:@"1.1/statuses/home_timeline.json"
   parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
       NSMutableArray *tweets = [Tweet tweetsWithArray:tweetDictionaries];
       completion(tweets, nil);
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       //when network call fails and set it to nil so it knows there is nothing in the array
       NSMutableArray *tweets = nil;
       // Fetch tweets from cache if possible (stored tweets)
       NSData *storedData = [[NSUserDefaults standardUserDefaults] valueForKey:@"hometimeline_tweets"];
       if (storedData != nil) {
           //array of tweets
           tweets = [Tweet tweetsWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:storedData]];
       }
       completion(tweets, error);
   }];
}



//sends the info to twitter and sumbitting data to a database
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    //u can access url and add stuff to twitters API
    NSString *urlString = @"1.1/favorites/create.json";
    //this is the tweet >> favoriting retweet and getting its ID to atually fave it
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //then updates the fave count
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        //once it runs and updates .. gives me back the updated object
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}



//ASK ABOUT BLOCK NOTATION
- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    //u can access url and add stuff to twitters API
    NSString *urlString = @"1.1/favorites/destroy.json";
    //this is the tweet >> favoriting retweet and getting its ID to atually fave it
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //then updates the fave count
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        //once it runs and updates .. gives me back the updated object
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}



- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    //u can access url and add stuff to twitters API
    NSString *urlString = @"1.1/statuses/retweet.json";
    //this is the tweet >> retweeting retweet and getting its ID to atually fave it
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //then updates the retweet count
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        //once it runs and updates .. gives me back the updated object
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}



- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    //u can access url and add stuff to twitters API
    NSString *urlString =@"1.1/statuses/unretweet.json";
    //this is the tweet >> unretweeting retweet and getting its ID to atually fave it
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //then updates the fave count
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        //once it runs and updates .. gives me back the updated object
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

@end
