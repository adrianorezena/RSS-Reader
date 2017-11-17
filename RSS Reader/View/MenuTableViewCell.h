//
//  MenuTableViewCell.h
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@interface MenuTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *tituloLabel;

-(void)configureWithMenuItem:(MenuItem *)dados;

@end
