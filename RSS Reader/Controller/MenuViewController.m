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

static NSInteger const kCellHeight = 40;
static NSString *kCellIdentifier = @"menuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefaults];
    [self initUIElements];
    [self setupNotifications];
    [self.tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self reloadMenu];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initDefaults {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = kStrRSSReader;
}

- (void)initUIElements {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.tableView];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMenu) name:kStrNotificationRSSFinished object:nil];
}

-(void)reloadMenu {
    MenuItem *addNewRSSItem = [MenuItem new];
    addNewRSSItem.titulo = kStrMenuItemAdicionarRSS;
    addNewRSSItem.className = [AddRSSViewController class];
    
    NSArray *rssArray = [[RSSAPI sharedInstance] getRSS];
    
    NSMutableArray *rssMutableArray = [NSMutableArray new];
    [rssMutableArray addObject:addNewRSSItem];
    
    for (RSS *rss in rssArray) {
        MenuItem *rssItem = [MenuItem new];
        rssItem.titulo = rss.title;
        rssItem.url = rss.id;
        rssItem.className = [RSSMasterTableViewController class];
        [rssMutableArray addObject:rssItem];
    }
    
    self.items = [rssMutableArray copy];
    
    [self.tableView reloadData];
    self.tableView.scrollEnabled = [self.items count] * kCellHeight > self.view.frame.size.height;
}

-(void)viewDidLayoutSubviews {
    CGFloat navigationControlHeight = kIntegerHeightNavigationControl;
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationControlHeight);
}

-(void)viewWillAppear:(BOOL)animated {
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItem *item = self.items[indexPath.row];
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell configureWithMenuItem:item];
    
    if (item.className == [AddRSSViewController class]) {
        cell.backgroundColor = [UIColor darkGrayColor];
    } else {
        cell.backgroundColor = [UIColor grayColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItem *item = self.items[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(menuController:didSelectItem:withMenuItem:)]) {
        UIViewController *controller = [[item.className alloc] init];
        [self.delegate menuController:self didSelectItem:controller withMenuItem:item];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

@end


