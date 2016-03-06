//
//  abcCollectionViewCell.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "abcCollectionViewCell.h"

#import "UIImageView+WebCache.h"

@implementation abcCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)config:(cruisemodel *)model {
   
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.Logo]];
    
    _namelabel.text = [NSString stringWithFormat:@"%@",model.Name];
    
}


@end
