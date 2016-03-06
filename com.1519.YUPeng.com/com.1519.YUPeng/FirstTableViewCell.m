//
//  FirstTableViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(PromotionProductsModel *)pmodel {
    
    [_ImgStc sd_setImageWithURL:[NSURL URLWithString:pmodel.ImgSrc]];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@起",pmodel.Price];
    _desLabel.text = pmodel.Title;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@|%@",pmodel.ProductTypeName,pmodel.Destination];
    _nameLabel.backgroundColor = [UIColor grayColor];
    _nameLabel.layer.cornerRadius = 5.0;
    _nameLabel.layer.masksToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
