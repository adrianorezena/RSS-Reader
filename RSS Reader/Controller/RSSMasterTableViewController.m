//
//  RSSMasterTableViewController.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "RSSMasterTableViewController.h"

@interface RSSMasterTableViewController () {
    NSArray *feedsArray;
}

@end

@implementation RSSMasterTableViewController

static NSString *kCellIdentifier = @"masterCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUIElements];
    [self initDefaults];
    [self setupNotifications];
    [self.tableView registerClass:[RSSMasterTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self loadItems];
}

-(void)initDefaults {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.rss.title;
}

-(void)initUIElements {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor darkGrayColor];
    
    NSString *titulo = kStrRefreshControlTitle;
    NSDictionary *attDictionary = [NSDictionary dictionaryWithObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
    NSAttributedString *atrString = [[NSAttributedString alloc] initWithString:titulo attributes:attDictionary];
    self.refreshControl.attributedTitle = atrString;
    [self.refreshControl addTarget:self action:@selector(refreshItems) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeRSS)];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadItems) name:kStrNotificationRSSFinished object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadItems {
    feedsArray = [[RSSAPI sharedInstance] getRSSFeeds:self.rss.id];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(void)refreshItems {
    [[RSSAPI sharedInstance] addRSS:self.rss.id];
}

-(void)removeRSS {
    NSString *rssId = self.rss.id;
    self.rss = nil;
    [[RSSAPI sharedInstance] deleteRSS:rssId];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [feedsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSMasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    RSSFeeds *feed = feedsArray[indexPath.row];
    [cell configureWithFeed:feed];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSFeeds *feed = feedsArray[indexPath.row];
    RSSDetailViewController *controller = [[RSSDetailViewController alloc] initWithRSSFeeds:feed];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
