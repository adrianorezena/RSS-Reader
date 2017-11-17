//
//  RSSAPI.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "ServiceRSS.h"

@interface RSSAPI : NSObject

+(RSSAPI *) sharedInstance;

-(void)addRSS:(NSString *)urlString;
-(void)deleteRSS:(NSString *)urlString;
-(NSArray *)getRSS;
-(RSS *)getRSSWithId:(NSString *)Id;

-(NSArray *)getRSSFeeds:(NSString *)urlString;
-(RSSFeeds *)getRSSFeedWithId:(NSString *)rssId;





@end
