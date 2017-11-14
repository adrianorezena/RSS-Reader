//
//  MenuViewController.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate;

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;

@end

@protocol MenuViewControllerDelegate <NSObject>

-(void)menuController:(MenuViewController *)menuController didSelectItem:(UIViewController *)selectedItem /*withMenu:(MenuItem *) menuItem*/;

@end
