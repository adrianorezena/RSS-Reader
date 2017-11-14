//
//  PrincipalViewController.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "PrincipalViewController.h"

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
    CGFloat spaceFromRightMargin = 60;
    self.menuWidth = self.view.frame.size.width - spaceFromRightMargin;
    
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(-self.menuWidth, 64, self.menuWidth, self.view.frame.size.height)];
    self.menuView.hidden = YES;
    self.menuView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.menuView];
    
    self.menuController = [MenuViewController new];
    self.menuController.delegate = self;
    
    self.imagemFundo = [UIImageView new];
    self.imagemFundo.image = [UIImage imageNamed:@"rss.jpeg"];
    self.imagemFundo.contentMode = UIViewContentModeCenter;
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
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuTapped)];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self addChildViewController:self.menuController];
    //self.menuController.view.frame = self.menuView.frame;
    self.menuController.view.frame = CGRectMake(0, 0, self.menuView.frame.size.width, self.menuView.frame.size.height);
    [self.menuView addSubview:self.menuController.view];
    [self.menuController viewWillAppear:YES];
    
    NSLog(@"viewWillLayoutSubviews - self.menuView.frame: %@", NSStringFromCGRect(self.menuView.frame));
    NSLog(@"viewWillLayoutSubviews - self.menuController.frame: %@", NSStringFromCGRect(self.menuController.view.frame));
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
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:self.optionController animated:YES];
    }
}

@end
