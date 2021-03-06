//
//  MenuViewController.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"
#import "MenuItem.h"
#import "RSSMasterTableViewController.h"
#import "AddRSSViewController.h"
#import "RSSAPI.h"

@protocol MenuViewControllerDelegate;

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;

@end

@protocol MenuViewControllerDelegate <NSObject>

-(void)menuController:(MenuViewController *)menuController didSelectItem:(UIViewController *)selectedItem withMenuItem:(MenuItem *)menuItem;

@end

