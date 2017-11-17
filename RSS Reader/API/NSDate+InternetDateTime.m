//
//  NSDate+NSDate__InternetDateTime.m
//  RSS Reader
//
//  Created by Adriano Rezena on 15/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "NSDate+InternetDateTime.h"

@implementation NSDate (InternetDateTime)

+(NSDate *)dateFromInternetDateTimeString:(NSString *)dateString {
    // Setup Date & Formatter
    NSDate *date = nil;
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:en_US_POSIX];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    /*
     *  RFC3339
     */
    
    NSString *RFC3339String = [[NSString stringWithString:dateString] uppercaseString];
    RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@"Z" withString:@"-0000"];
    
    // Remove colon in timezone as iOS 4+ NSDateFormatter breaks
    // See https://devforums.apple.com/thread/45837
    if (RFC3339String.length > 20) {
        RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@":"
                                                                 withString:@""
                                                                    options:0
                                                                      range:NSMakeRange(20, RFC3339String.length-20)];
    }
    
    if (!date) { // 1996-12-19T16:39:57-0800
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
        date = [formatter dateFromString:RFC3339String];
    }
    if (!date) { // 1937-01-01T12:00:27.87+0020
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ"];
        date = [formatter dateFromString:RFC3339String];
    }
    if (!date) { // 1937-01-01T12:00:27
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
        date = [formatter dateFromString:RFC3339String];
    }
    if (date) return date;
    
    /*
     *  RFC822
     */
    
    NSString *RFC822String = [[NSString stringWithString:dateString] uppercaseString];
    if (!date) { // Sun, 19 May 02 15:21:36 GMT
        [formatter setDateFormat:@"EEE, d MMM yy HH:mm:ss zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) { // Sun, 19 May 2002 15:21:36 GMT
        [formatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // Sun, 19 May 2002 15:21 GMT
        [formatter setDateFormat:@"EEE, d MMM yyyy HH:mm zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) { // Sun, 19 May 2002 15:21:36
        [formatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21:36 GMT
        [formatter setDateFormat:@"d MMM yyyy HH:mm:ss zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21 GMT
        [formatter setDateFormat:@"d MMM yyyy HH:mm zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21:36
        [formatter setDateFormat:@"d MMM yyyy HH:mm:ss"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21
        [formatter setDateFormat:@"d MMM yyyy HH:mm"];
        date = [formatter dateFromString:RFC822String];
    }
    if (date) return date;
    
    // Failed
    return nil;
}

@end
