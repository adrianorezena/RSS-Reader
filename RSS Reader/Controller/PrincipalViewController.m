//
//  PrincipalViewController.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "PrincipalViewController.h"

#import "RSSAPI.h"

@interface PrincipalViewController ()

@property (nonatomic, strong) MenuViewController *menuController;
@property (nonatomic, strong) UIViewController *optionController;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, assign) CGFloat menuWidth;

@end

@implementation PrincipalViewController

- (void)initDefaults {
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initUIElements {
    CGFloat rightMargin = kIntegerMenuRightMargin;
    CGFloat navigationControlHeight = kIntegerHeightNavigationControl;
    
    self.menuWidth = self.view.frame.size.width - rightMargin;
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(-self.menuWidth, navigationControlHeight, self.menuWidth, self.view.frame.size.height - navigationControlHeight)];
    self.menuView.hidden = YES;
    self.menuView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.menuView];
    
    self.menuController = [MenuViewController new];
    self.menuController.delegate = self;
    
    self.imagemFundo = [UIImageView new];
    NSString *imageNamed = kFileRSSImage;
    self.imagemFundo.image = [UIImage imageNamed:imageNamed];
    self.imagemFundo.contentMode = UIViewContentModeCenter;
    self.imagemFundo.alpha = 0.1;
    [self.view addSubview:self.imagemFundo];
}

-(void)viewDidLayoutSubviews {
    self.imagemFundo.frame = self.view.bounds;
    self.imagemFundo.center = self.view.center;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIElements];
    [self initDefaults];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuTapped)];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self addChildViewController:self.menuController];
    self.menuController.view.frame = CGRectMake(0, 0, self.menuView.frame.size.width, self.menuView.frame.size.height);
    [self.menuView addSubview:self.menuController.view];
    [self.menuController viewWillAppear:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self isMenuOpen]) {
        [self closeMenu];
    }
}

#pragma mark - MenuViewController Methods

- (void)menuTapped {
    if ([self isMenuOpen]) {
        [self closeMenu];
    } else {
        [self openMenu];
    }
}

- (BOOL)isMenuOpen {
    return self.menuView.frame.origin.x == 0.f;
}

- (void)openMenu {
    self.optionController = nil;
    self.menuView.hidden = NO;
    
    [self.view bringSubviewToFront:self.menuView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.menuView.frame = CGRectMake(0, self.menuView.frame.origin.y, self.menuWidth, self.view.frame.size.height);
    }];
}

- (void)closeMenu {
    [UIView animateWithDuration:0.3 animations:^{
        self.menuView.frame = CGRectMake(-self.menuWidth, self.menuView.frame.origin.y, self.menuWidth, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        self.menuView.hidden = YES;
    }];
}

#pragma mark - MenuViewControllerDelegate Methods

-(void)menuController:(MenuViewController *)menuController didSelectItem:(UIViewController *)selectedItem withMenuItem:(MenuItem *)menuItem {
    self.optionController = selectedItem;
    
    [self closeMenu];
    
    if (self.optionController) {
        if ([self.optionController class] == [RSSMasterTableViewController class]) {
            RSSMasterTableViewController *rssMasterTableViewController = (RSSMasterTableViewController *)self.optionController;
            rssMasterTableViewController.rss = [[RSSAPI sharedInstance] getRSSWithId:menuItem.url];
        }
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:self.optionController animated:YES];
    }
}

@end
