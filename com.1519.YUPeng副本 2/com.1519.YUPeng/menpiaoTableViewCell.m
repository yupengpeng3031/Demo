//
//  menpiaoTableViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/4.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "menpiaoTableViewCell.h"

#import "UIImageView+WebCache.h"

@implementation menpiaoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(menpiaopromodel *)model {
    
    [_image sd_setImageWithURL:[NSURL URLWithString:model.ImgSrc]];
    
    _namelabel.text = [NSString stringWithFormat:@"%@|%@",model.ProductTypeName,model.ProductName];
    
    _adresslabel.text = model.Destination;
    
    _pricelabel.text = [NSString stringWithFormat:@"¥%@起",model.Price];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
