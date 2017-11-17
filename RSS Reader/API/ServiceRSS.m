//
//  ServiceRSS.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "ServiceRSS.h"

@implementation ServiceRSS

- (void)parseXML:(NSString *)urlString xmlData:(NSData *)xmlData {
    XmlParser *parser = [XmlParser new];
    [parser parseXML:urlString xmlData:xmlData];
}

- (BOOL)xmlIsValid:(NSString *)xmlString {
    return [xmlString containsString:@"<entry>"] || [xmlString containsString:@"<item>"];
}

@end
