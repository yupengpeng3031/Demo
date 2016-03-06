//
//  chujingTableViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "chujingTableViewCell.h"

#import "UIImageView+WebCache.h"

@implementation chujingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)config:(bigsemodel *)model {
    
    [_image sd_setImageWithURL:[NSURL URLWithString:model.ImgSrc]];
    
    _namelabel.text = [NSString stringWithFormat:@"%@|%@",model.ProductTypeName,model.ProductName];
    
    _adresslabel.text = model.Destination;
    
    _pricelabel.text = [NSString stringWithFormat:@"¥%@起",model.Price];
    
}

-(void)confg:(couplemodel *)mol {
    
    [_image sd_setImageWithURL:[NSURL URLWithString:mol.ImgSrc]];
    
    _namelabel.text = [NSString stringWithFormat:@"%@|%@",mol.ProductTypeName,mol.ProductName];
    
    _adresslabel.text = mol.Destination;
    
    _pricelabel.text = [NSString stringWithFormat:@"¥%@起",mol.Price];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
