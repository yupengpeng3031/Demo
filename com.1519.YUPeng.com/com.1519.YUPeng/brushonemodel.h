//
//  brushonemodel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"
#import "brushtwomodel.h"
@interface brushonemodel : JSONModel
@property (nonatomic, copy) NSString *BannerLink;

@property (nonatomic, copy) NSString *SubTitle;

@property (nonatomic, copy) NSString *BannerName;

@property (nonatomic, copy) NSString *TagId;

@property (nonatomic, copy) NSString *TagDes;

@property (nonatomic, copy) NSString *Height;

@property (nonatomic, copy) NSString *Width;

@property (nonatomic, copy) NSString *ProductNumber;

@property (nonatomic, copy) NSString *BannerUrl;

@property (nonatomic, copy) NSString *TagName;

@property (nonatomic, copy) NSString *mounth;

@property (nonatomic, copy) NSString *TagColor;

@property (nonatomic, strong)brushtwomodel *Category;
@end
