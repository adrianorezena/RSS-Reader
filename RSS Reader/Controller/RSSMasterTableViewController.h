//
//  RSSMasterTableViewController.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSFeeds.h"
#import "RSSAPI.h"
#import "RSSDetailViewController.h"
#import "RSSMasterTableViewCell.h"

@interface RSSMasterTableViewController : UITableViewController

@property (strong, nonatomic) RSS *rss;

@end
