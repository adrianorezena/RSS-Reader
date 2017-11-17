//
//  RSSDetailViewController.h
//  RSS Reader
//
//  Created by Adriano Rezena on 15/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSFeeds.h"

@interface RSSDetailViewController : UIViewController <UIWebViewDelegate>

-(instancetype)initWithRSSFeeds:(RSSFeeds *)selectedRSSFeed;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UIWebView *webView;

@end
