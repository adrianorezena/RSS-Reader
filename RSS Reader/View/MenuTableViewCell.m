//
//  MenuTableViewCell.m
//  RSS Reader
//
//  Created by Adriano Rezena on 14/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUIElements];
        [self initDefaults];
    }
    
    return self;
}

-(void)initDefaults {
    self.backgroundColor = [UIColor grayColor];
}

-(void)initUIElements {
    self.tituloLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.tituloLabel.font = [UIFont boldSystemFontOfSize:12];
    self.tituloLabel.textAlignment = NSTextAlignmentLeft;
    self.tituloLabel.textColor = [UIColor whiteColor];
    self.tituloLabel.backgroundColor = [UIColor clearColor];
    self.tituloLabel.numberOfLines = 0;
    [self addSubview:self.tituloLabel];
}

-(void)layoutSubviews {
    self.tituloLabel.frame = CGRectMake(10, (self.frame.size.height / 2) - 20, self.frame.size.width, 40);
}

-(void)configureWithMenuItem:(MenuItem *)dados {
    self.tituloLabel.text = dados.titulo;
}

@end
