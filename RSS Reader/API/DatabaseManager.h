//
//  DatabaseManager.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "RSS.h"
#import "RSSFeeds.h"

@interface DatabaseManager : NSObject

+(DatabaseManager *) sharedInstance;

-(void)createRSS:(NSString *)urlString dadosRSS:(NSDictionary *)dadosRSS;
-(void)deleteRSS:(NSString *)urlString;
-(NSArray *)getRSS;
-(RSS *)getRSSWithId:(NSString *)Id;

-(void)createRSSFeeds:(NSString *)urlString dadosRSSFeed:(NSDictionary *)dadosRSSFeed;
-(NSArray *)getRSSFeeds:(NSString *)urlString;
-(RSSFeeds *)getRSSFeedWithId:(NSString *)rssId;


@end
