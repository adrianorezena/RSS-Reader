//
//  XmlParser.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"

@interface XmlParser : NSObject <NSXMLParserDelegate>

-(NSArray *)parseXML:(NSString *)urlString xmlData:(NSData *)xmlData;

@end
