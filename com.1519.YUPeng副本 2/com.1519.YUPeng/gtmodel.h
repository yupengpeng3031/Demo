//
//  gtmodel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"

@interface gtmodel : JSONModel

@property(nonatomic,copy)NSString *ImgSrc;
@property (nonatomic,copy)NSString *Link;
@property (nonatomic,strong)NSDictionary *Category;
@property (nonatomic,copy)NSString *CategoryKey;
@property (nonatomic,strong)NSDictionary *CategoryValue;
@property (nonatomic,copy)NSString *SearchKeyword;

@end
