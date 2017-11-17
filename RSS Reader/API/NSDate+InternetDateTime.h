//
//  NSDate+NSDate__InternetDateTime.h
//  RSS Reader
//
//  Created by Adriano Rezena on 15/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (InternetDateTime)

+ (NSDate *)dateFromInternetDateTimeString:(NSString *)dateString;

@end
