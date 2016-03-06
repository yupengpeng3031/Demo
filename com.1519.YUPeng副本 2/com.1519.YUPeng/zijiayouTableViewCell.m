//
//  zijiayouTableViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/4.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "zijiayouTableViewCell.h"

#import "UIImageView+WebCache.h"

@implementation zijiayouTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)config:(zijiayouthreemodel *)model {
    
    [_imager sd_setImageWithURL:[NSURL URLWithString:model.ImgSrc]];
    
    _namelabel.text = [NSString stringWithFormat:@"%@|%@",model.ProductTypeName,model.ProductName];
    
    _adresslabel.text = model.Destination;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
