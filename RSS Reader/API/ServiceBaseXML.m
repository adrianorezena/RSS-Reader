//
//  ServiceBaseXML.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "ServiceBaseXML.h"

@implementation ServiceBaseXML

- (void)retrieveDataWithSuccessHandler:(NSString *)urlString sucessBlock:(void(^)(void))successBlock andDidFailHandler:(void(^)(void))failBlock {

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:nil error:nil];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSData *xmlData = (NSData *)responseObject;
            NSString *fetchedXML = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            if ([self xmlIsValid:fetchedXML]) {
                [self parseXML:urlString xmlData:xmlData];
                successBlock();
            } else {
                NSLog(@"Retorno do XML é inválido (%@)", fetchedXML);
                failBlock();
            }
        } else {
            failBlock();
        }
    }];
    [task resume];
}

- (void)parseXML:(NSString *)urlString xmlData:(NSData *)xmlData {
    
}

- (BOOL)xmlIsValid:(NSString *)xmlString {
    return NO;
}

@end

