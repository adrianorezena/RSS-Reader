//
//  RSSMasterTableViewCell.h
//  RSS Reader
//
//  Created by Adriano Rezena on 16/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSFeeds.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RSSMasterTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UILabel *tituloLabel;
@property (nonatomic, strong) UILabel *descricaoLabel;
@property (nonatomic, strong) UILabel *dataLabel;

-(void)configureWithFeed:(RSSFeeds *)dados;

@end
