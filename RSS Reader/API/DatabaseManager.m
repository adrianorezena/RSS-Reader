//
//  DatabaseManager.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "DatabaseManager.h"
#import "NSDate+InternetDateTime.h"

@implementation DatabaseManager

+(DatabaseManager *)sharedInstance {
    static DatabaseManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DatabaseManager alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - RSS
-(void)createRSS:(NSString *)urlString dadosRSS:(NSDictionary *)dadosRSS {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    RSS *rss = [RSS objectForPrimaryKey:urlString];
    
    if (!rss) {
        rss = [RSS new];
        rss.id = urlString;
    }
    
    rss.url = dadosRSS[@"link"];
    rss.title = dadosRSS[@"title"];
    [realm addOrUpdateObject:rss];
    [realm commitWriteTransaction];
}

-(void)deleteRSS:(NSString *)urlString {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RSS *rss = [RSS objectForPrimaryKey:urlString];
    
    if (rss) {
        [realm beginWriteTransaction];
        [realm deleteObject:rss];
        [realm commitWriteTransaction];
    }
}

-(NSArray *)getRSS {
    [[RLMRealm defaultRealm] refresh];
    NSMutableArray *rssMutableArray = [NSMutableArray new];
    
    RLMResults<RSS *> *rssResults = [[RSS allObjects] sortedResultsUsingKeyPath:@"title" ascending:YES];
    
    for (RSS *rss in rssResults) {
        [rssMutableArray addObject:rss];
    }
    
    return [rssMutableArray copy];
}

-(RSS *)getRSSWithId:(NSString *)Id {
    RSS *rss = [RSS objectForPrimaryKey:Id];
    return rss;
}

#pragma mark - RSSFeeds

-(void)createRSSFeeds:(NSString *)urlString dadosRSSFeed:(NSDictionary *)dadosRSSFeed {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    RSSFeeds *rss = [RSSFeeds objectForPrimaryKey:dadosRSSFeed[@"link"]];
    
    if (!rss) {
        rss = [RSSFeeds new];
        rss.id = dadosRSSFeed[@"link"];
    }
    
    rss.rssId = urlString;
    rss.title = dadosRSSFeed[@"title"];
    
    NSString *dadoString;
    
    dadoString = dadosRSSFeed[@"description"];
    if (!dadoString) {
         dadoString = dadosRSSFeed[@"summary"];
    }
    rss.description = dadoString;
    
    dadoString = dadosRSSFeed[@"published"];
    
    if (!dadoString) {
        dadoString = dadosRSSFeed[@"pubDate"];
    }
    
    if (!dadoString) {
        dadoString = dadosRSSFeed[@"updated"];
    }
    
    if (dadoString) {
        rss.pubDate = [NSDate dateFromInternetDateTimeString:dadoString];
    }
    
    
    dadoString = dadosRSSFeed[@"thumbnail"];
    
    rss.thumbnail = dadoString;
    rss.link = dadosRSSFeed[@"link"];
    
    [realm addOrUpdateObject:rss];
    [realm commitWriteTransaction];
}

-(NSArray *)getRSSFeeds:(NSString *)urlString {
    [[RLMRealm defaultRealm] refresh];
    NSMutableArray *rssMutableArray = [NSMutableArray new];
    
    RLMResults<RSSFeeds *> *rssResults = [[RSSFeeds objectsWhere:@"rssId = %@", urlString] sortedResultsUsingKeyPath:@"pubDate" ascending:NO];
    
    for (RSSFeeds *rss in rssResults) {
        [rssMutableArray addObject:rss];
    }
    
    return [rssMutableArray copy];
}

-(RSSFeeds *)getRSSFeedWithId:(NSString *)rssId {
    RSSFeeds *feed = [RSSFeeds objectForPrimaryKey:rssId];
    return feed;
}

@end
