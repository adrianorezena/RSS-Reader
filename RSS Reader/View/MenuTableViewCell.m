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
    self.backgroundColor = [UIColor greenColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)initUIElements {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.tituloLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.tituloLabel.textColor = [UIColor blackColor];
    self.tituloLabel.backgroundColor = [UIColor clearColor];
    self.tituloLabel.numberOfLines = 0;
    [self addSubview:self.tituloLabel];
}


-(void)layoutSubviews {
    self.tituloLabel.frame = CGRectMake(20, 5, self.frame.size.width, 20);
}

/*
-(void)configureWithMenuItem:(MenuItem *)dados {
    self.iconeLabel.text = dados.icone;
    self.tituloLabel.text = dados.title;
}*/

@end
