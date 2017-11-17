//
//  RSS.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Realm/Realm.h>

@interface RSS : RLMObject

@property NSString *title;
@property NSString *id;
@property NSString *url;

@end
