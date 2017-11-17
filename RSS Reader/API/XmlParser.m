//
//  XmlParser.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "XmlParser.h"

@implementation XmlParser {
    NSXMLParser *xmlParser;
    NSMutableArray *xmlMutableArray;
    NSMutableDictionary *xmlMutableDictionary;
    NSMutableDictionary *xmlHeaderMutableDictionary;
    NSMutableString *elementMutableString;
    BOOL iniciouItens;
    NSString *url;
    NSDictionary *attributeDictionary;
}

-(NSArray *)parseXML:(NSString *)urlString xmlData:(NSData *)xmlData {
    url = urlString;
    xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    xmlParser.delegate = self;
    [xmlParser parse];
    
    return [xmlMutableArray copy];
}

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    iniciouItens = NO;
    xmlHeaderMutableDictionary = [NSMutableDictionary new];
    attributeDictionary = [NSDictionary new];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"rss"] || [elementName isEqualToString:@"feed"] || [elementName isEqualToString:@"xml"]) {
        xmlMutableArray = [NSMutableArray new];
    }
    
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        iniciouItens = YES;
        xmlMutableDictionary = [NSMutableDictionary new];
    }
    
    attributeDictionary = nil;
    if (([elementName isEqualToString:@"link"]) || ([elementName isEqualToString:@"media:thumbnail"])|| ([elementName isEqualToString:@"media:content"]) || ([elementName isEqualToString:@"enclosure"])) {
        
        if ([attributeDict count] > 0) {
            attributeDictionary = attributeDict;
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!elementMutableString) {
        elementMutableString = [[NSMutableString alloc] initWithString:string];
    } else {
        if (string) {
            [elementMutableString appendString:string];
        } else {
            [elementMutableString appendString:@""];
        }
        
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    NSString *itemKey = elementName;
    
    if (!elementMutableString) {
        elementMutableString = [[NSMutableString alloc] initWithString:@""];
    } else {
        [elementMutableString setString:[elementMutableString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    
    if ([elementName isEqualToString:@"link"]) {
        if ([elementMutableString length] == 0) {
            NSString *href = [attributeDictionary objectForKey:@"href"];
            if (href) {
                [elementMutableString setString:href];
                NSLog(@"<link href=%@>", href);
                itemKey = @"thumbnail";
            }
        }
    } else if ([elementName isEqualToString:@"media:thumbnail"]) {
        if (([elementMutableString length] == 0) && (attributeDictionary)) {
            NSString *href = [attributeDictionary objectForKey:@"url"];
            if (href) {
                [elementMutableString setString:href];
                itemKey = @"thumbnail";
            }
        }
    } else if (([elementName isEqualToString:@"media:content"]) || ([elementName isEqualToString:@"enclosure"])) {
        if (([elementMutableString length] == 0) && (attributeDictionary)) {
            
            NSString *type = [attributeDictionary objectForKey:@"type"];
            
            if ([type containsString:@"image/"]) {
                NSString *href = [attributeDictionary objectForKey:@"url"];
                
                if (href) {
                    [elementMutableString setString:href];
                    itemKey = @"thumbnail";
                }
            }
        }
    } else if ([elementName isEqualToString:@"content:encoded"]) {
        if ([elementMutableString length] > 0) {
            NSArray *dadosContent = [elementMutableString componentsSeparatedByString:@" "];
            NSString *dadoString = @"";
            
            for (NSString *linha in dadosContent) {
                if ([linha containsString:@"src=\""]) {
                    dadoString = linha;
                    dadoString = [dadoString stringByReplacingOccurrencesOfString:@"src=" withString:@""];
                    dadoString = [dadoString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                    break;
                }
            }
                
            if (dadoString) {
                [elementMutableString setString:dadoString];
                itemKey = @"thumbnail";
            }
        }
    }
    
    
    /*
     
      else {
     dadoString = dadosRSSFeed[@"media:thumbnail"];
     
     if (dadoString) {
     NSArray *dadosContent = [dadoString componentsSeparatedByString:@" "];
     
     for (NSString *linha in dadosContent) {
     if ([linha containsString:@"url=\""]) {
     dadoString = linha;
     dadoString = [dadoString stringByReplacingOccurrencesOfString:@"url=" withString:@""];
     dadoString = [dadoString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
     dadoString = [dadoString stringByReplacingOccurrencesOfString:@"/>" withString:@""];
     break;
     }
     }
     }
     }
     }

     
     */
    
    
    
    
    if (!iniciouItens) {
        NSString *string = [elementMutableString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        [xmlHeaderMutableDictionary setObject:[string stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:itemKey];
    } else {
        if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
            [xmlMutableArray addObject:xmlMutableDictionary];
        } else {
            [xmlMutableDictionary setObject:[elementMutableString stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:itemKey];
        }
    }
    
    elementMutableString = nil;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [[DatabaseManager sharedInstance] createRSS:url dadosRSS:xmlHeaderMutableDictionary];
    
    for (NSDictionary *dictionary in xmlMutableArray) {
        [[DatabaseManager sharedInstance] createRSSFeeds:url dadosRSSFeed:dictionary];
    }
}

@end
