//
//  TopicBannersModel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"
#import "TopicModel.h"
@interface TopicBannersModel : JSONModel
@property (nonatomic,copy)NSString *ImgSrc;
@property (nonatomic,copy)NSString *Link;
@property (nonatomic,copy)NSString *BannerName;
@property (nonatomic,copy)NSString *BannerSubName;
@property (nonatomic,strong)TopicModel *Category;
@end