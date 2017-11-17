//
//  RSSMasterTableViewCell.m
//  RSS Reader
//
//  Created by Adriano Rezena on 16/11/2017.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "RSSMasterTableViewCell.h"

@implementation RSSMasterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUIElements];
        [self initDefaults];
    }
    
    return self;
}

-(void)initDefaults {
    self.backgroundColor = [UIColor whiteColor];
}

-(void)initUIElements {
    self.thumbnailImageView = [UIImageView new];
    self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.thumbnailImageView];
    
    self.tituloLabel = [UILabel new];
    self.tituloLabel.font = [UIFont boldSystemFontOfSize:12];
    self.tituloLabel.numberOfLines = 0;
    self.tituloLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.tituloLabel];
    
    self.descricaoLabel = [UILabel new];
    self.descricaoLabel.font = [UIFont systemFontOfSize:10];
    self.descricaoLabel.numberOfLines = 0;
    self.descricaoLabel.textAlignment = NSTextAlignmentLeft;
    self.descricaoLabel.textColor = [UIColor grayColor];
    [self addSubview:self.descricaoLabel];
    
    self.dataLabel = [UILabel new];
    self.dataLabel.textAlignment = NSTextAlignmentLeft;
    self.dataLabel.font = [UIFont boldSystemFontOfSize:9];
    self.dataLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:self.dataLabel];
}

-(void)layoutSubviews {
    self.thumbnailImageView.frame = CGRectMake(5, 5, self.frame.size.width / 3, self.frame.size.height - 10);
    
    CGFloat posicaoXInicial;
    
    if (self.thumbnailImageView.tag == 1) {
        posicaoXInicial = self.thumbnailImageView.frame.origin.x + self.thumbnailImageView.frame.size.width + 10;
    } else {
        posicaoXInicial = 10;
    }
    
    self.tituloLabel.frame = CGRectMake(posicaoXInicial, 10, self.frame.size.width - posicaoXInicial - 10, 10);
    [self.tituloLabel sizeToFit];
    
    CGFloat posicaoYInicial = self.tituloLabel.frame.origin.y + self.tituloLabel.frame.size.height;
    self.dataLabel.frame = CGRectMake(posicaoXInicial, self.frame.size.height - 20, 100, 15);
    
    CGFloat posicaoYDescricao = self.dataLabel.frame.origin.y - posicaoYInicial;
    
    if (posicaoYDescricao > 15) {
        self.descricaoLabel.frame = CGRectMake(posicaoXInicial, posicaoYInicial, self.frame.size.width - posicaoXInicial - 10, posicaoYDescricao);
    } else {
        self.descricaoLabel.frame = CGRectMake(0, 0, 0, 0);
    }
}

-(NSString *)formatDate:(NSDate *)data {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:kFormatDateExibition];
    return [formatter stringFromDate:data];
}

-(NSString *)stringByStrippingHTML:(NSString *)fromString {
    NSRange r;
    NSString *s = fromString;
    
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    return s;
}

-(void)configureWithFeed:(RSSFeeds *)dados {
    self.thumbnailImageView.tag = 0;
    
    if (dados.thumbnail) {
        self.thumbnailImageView.tag = 1;
        [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString: dados.thumbnail]];
    }
    
    self.tituloLabel.text = dados.title;
    [self.tituloLabel sizeToFit];
    
    if (dados.description) {
        self.descricaoLabel.text = [self stringByStrippingHTML:dados.description];
    }
    
    self.dataLabel.text = [self formatDate:dados.pubDate];
}

@end
