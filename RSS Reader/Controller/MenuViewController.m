//
//  MenuViewController.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation MenuViewController

static NSString *cellIdentifier = @"menuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefaults];
    [self initUIElements];
    [self.tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)initDefaults {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"RSS Reader";
    
    MenuItem *addNewRSSItem = [MenuItem new];
    addNewRSSItem.titulo = @"Adicionar RSS";
    addNewRSSItem.className = [RSSMasterTableViewController class];

    self.items = @[addNewRSSItem];    
}


- (void)initUIElements {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:self.tableView];
}

-(void)viewDidLayoutSubviews {
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItem *item = self.items[indexPath.row];

    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tituloLabel.text = item.titulo;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItem *item = self.items[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(menuController:didSelectItem:withMenuItem:)]) {
        UIViewController *controller = [[UIViewController alloc] init];
        [self.delegate menuController:self didSelectItem:controller withMenuItem:item];
    }
}


@end


