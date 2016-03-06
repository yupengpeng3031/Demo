//
//  aentModel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"
#import "aentonemodel.h"
@interface aentModel : JSONModel
@property (nonatomic,copy)NSString *ImgSrc;
@property (nonatomic,copy)NSString *Link;
@property (nonatomic,copy)NSString *BannerName;
@property (nonatomic,copy)NSString *BannerSubName;
@property (nonatomic,strong)aentonemodel *Category;
@end
