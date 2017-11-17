//
//  RSSFeeds.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Realm/Realm.h>

@interface RSSFeeds : RLMObject

@property NSString *rssId;
@property NSString *id;
@property NSString *title;
@property NSString *link;
@property NSString *description;
@property NSDate *pubDate;
@property NSString *thumbnail;

@end
