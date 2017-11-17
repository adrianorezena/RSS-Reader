//
//  RSSDetailViewController.m
//  RSS Reader
//
//  Created by Adriano Rezena on 15/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "RSSDetailViewController.h"

@interface RSSDetailViewController () {
    RSSFeeds *rssFeed;
}

@end

@implementation RSSDetailViewController

-(instancetype)initWithRSSFeeds:(RSSFeeds *)selectedRSSFeed {
    self = [super init];
    
    if (self) {
        rssFeed = selectedRSSFeed;
    }
    
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIElements];
    [self initDefaults];

    NSURL *url = [NSURL URLWithString:rssFeed.link];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

-(void)initDefaults {
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initUIElements {
    self.webView = [UIWebView new];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.webView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.activityIndicatorView startAnimating];
    [self.view addSubview:self.activityIndicatorView];
}

-(void)viewDidLayoutSubviews {
    self.activityIndicatorView.center = self.view.center;
    CGFloat navigationControlHeight = kIntegerHeightNavigationControl;
    self.webView.frame = CGRectMake(0, navigationControlHeight, self.view.frame.size.width, self.view.frame.size.height - navigationControlHeight);
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicatorView stopAnimating];
}

@end
