//
//  ServiceBaseXML.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "DatabaseManager.h"
#import "XmlParser.h"

#define kStrNotificationRSSFinished @"NotificationRSSFinished"
#define kStrNotificationRSSError @"NotificationRSSError"

@interface ServiceBaseXML : NSObject

- (void)retrieveDataWithSuccessHandler:(NSString *)urlString sucessBlock:(void(^)(void))successBlock andDidFailHandler:(void(^)(void))failBlock;
- (void)parseXML:(NSString *)urlString xmlData:(NSData *)xmlData;
- (BOOL)xmlIsValid:(NSString *)xmlString;

@end
