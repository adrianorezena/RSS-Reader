//
//  AddRSSViewController.m
//  RSS Reader
//
//  Created by Adriano Rezena on 15/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "AddRSSViewController.h"

@interface AddRSSViewController ()

@end

@implementation AddRSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUIElements];
    [self initDefaults];
    [self setupNotifications];
}

-(void)initDefaults {
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initUIElements {
    self.urlTextField = [UITextField new];
    self.urlTextField.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    self.urlTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.urlTextField.placeholder = kStrRSSURLTextFieldPlaceHolder;
    [self.view addSubview:self.urlTextField];
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.addButton.backgroundColor = [UIColor lightGrayColor];
    [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.addButton setTitle:@"Adicionar" forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(didPressButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
}

-(void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyNewRSS) name:kStrNotificationRSSFinished object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyRSSError) name:kStrNotificationRSSError object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLayoutSubviews {
    self.urlTextField.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, 30);
    
    self.addButton.frame = CGRectMake((self.view.frame.size.width / 2) - (self.addButton.frame.size.width / 2), self.urlTextField.frame.origin.y + self.urlTextField.frame.size.height + 20, self.addButton.frame.size.width, self.addButton.frame.size.height);
}

-(void)didPressButton {
    if ([self.urlTextField.text length] > 0) {
        self.urlTextField.enabled = NO;
        [self.addButton setTitle:@"Aguarde" forState:UIControlStateNormal];
        [[RSSAPI sharedInstance] addRSS:self.urlTextField.text];
    }
 }

-(void)notifyNewRSS {
    self.urlTextField.text = @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Novo RSS" message:@"Novo feed foi cadastrado com sucesso!" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [self.addButton setTitle:@"Adicionar" forState:UIControlStateNormal];
    self.urlTextField.enabled = YES;
}

-(void)notifyRSSError {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Houve um problema para adicionar o feed!" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [self.addButton setTitle:@"Adicionar" forState:UIControlStateNormal];
    self.urlTextField.enabled = YES;
}

@end
