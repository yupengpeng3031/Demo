//
//  guoneioneCollectionViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/2.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "guoneioneCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation guoneioneCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width-10/3, 100)];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(2, 80,self.frame.size.width-10/3 , 20)];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor whiteColor];
        [_imageView addSubview:_label];
        
        [self.contentView addSubview:_imageView];
        
    }
    return self;
}
-(void)config:(brushonemodel *)str {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str.BannerUrl]];
    
    _label.text = [NSString stringWithFormat:@"%@|%@",str.BannerName,str.SubTitle];
}

@end
