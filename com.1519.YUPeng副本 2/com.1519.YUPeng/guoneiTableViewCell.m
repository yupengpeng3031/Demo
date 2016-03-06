//
//  guoneiTableViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "guoneiTableViewCell.h"

#import "UIImageView+WebCache.h"


@implementation guoneiTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 150, 100)];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame), 5, self.frame.size.width-80, 70)];
        
        _adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame), 80, 120, 20)];
        _adressLabel.font = [UIFont systemFontOfSize:13];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_adressLabel.frame)+60, 70, 100, 30)];
        
        
        
        [self.contentView addSubview:_imageview];
        
        [self.contentView addSubview:_nameLabel];
        
        [self.contentView addSubview:_adressLabel];
        
        [self.contentView addSubview:_priceLabel];
        
        
    }
    return self;
}

-(void)config:(vacationmodel *)model {
    
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.ImgSrc]];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@||%@",model.ProductTypeName,model.ProductName];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    
    _adressLabel.text = [NSString stringWithFormat:@"%@",model.Destination];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@起",model.Price];
    _priceLabel.textColor = [UIColor redColor];
    
}
-(void)confg:(touismodel *)model {
    
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.ImgSrc]];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@||%@",model.ProductTypeName,model.ProductName];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    
    _adressLabel.text = [NSString stringWithFormat:@"%@",model.Destination];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@起",model.Price];
     _priceLabel.textColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
