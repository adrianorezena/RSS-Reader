//
//  RSSAPI.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "RSSAPI.h"

@implementation RSSAPI

+(RSSAPI *)sharedInstance {
    static RSSAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[RSSAPI alloc] init];
    });
    
    return _sharedInstance;
}

-(void)addRSS:(NSString *)urlString {
    ServiceRSS *service = [[ServiceRSS alloc] init];
    
    [service retrieveDataWithSuccessHandler:urlString sucessBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationRSSFinished object:self userInfo:nil];
    } andDidFailHandler:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationRSSError object:self userInfo:nil];
    }];
}

-(void)deleteRSS:(NSString *)urlString {
    [[DatabaseManager sharedInstance] deleteRSS:urlString];
    [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationRSSFinished object:self userInfo:nil];
}

-(NSArray *)getRSS {
    return [[DatabaseManager sharedInstance] getRSS];
}

-(RSS *)getRSSWithId:(NSString *)Id {
    return [[DatabaseManager sharedInstance] getRSSWithId:Id];
}

#pragma mark - RSSFeeds
-(NSArray *)getRSSFeeds:(NSString *)urlString {
    return [[DatabaseManager sharedInstance] getRSSFeeds:urlString];
}

-(RSSFeeds *)getRSSFeedWithId:(NSString *)rssId {
    return [[DatabaseManager sharedInstance] getRSSFeedWithId:rssId];
}

@end
