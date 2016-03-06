//
//  abcTableViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "abcTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation abcTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(guoneiweonemodel *)model {
    
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.ImgSrc]];
    
    _namelabel.text = [NSString stringWithFormat:@"%@|%@",model.ProductTypeName,model.ProductName];
    
    _pricelabel.text = [NSString stringWithFormat:@"¥%@起",model.Price];
    
    _pricelabel.textColor = [UIColor redColor];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
