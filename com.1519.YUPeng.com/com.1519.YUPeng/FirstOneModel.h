//
//  FirstOneModel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"
#import "BannersModel.h"
#import "TopicBannersModel.h"
#import "PromotionProductsModel.h"
#import "VacationProductsModel.h"
#import "TourProductsModel.h"

@protocol  BannersModel<NSObject>

@end
@protocol  TopicBannersModel<NSObject>

@end
@protocol  PromotionProductsModel<NSObject>

@end
@protocol  VacationProductsModel<NSObject>

@end
@protocol  TourProductsModel<NSObject>

@end
@interface FirstOneModel : JSONModel
@property (nonatomic,strong)NSArray <BannersModel>*Banners;
@property (nonatomic,strong)NSArray <TopicBannersModel>*TopicBanners;
@property (nonatomic,strong)NSArray <PromotionProductsModel>*PromotionProducts;
@property (nonatomic,strong)NSArray <VacationProductsModel>*VacationProducts;
@property (nonatomic,strong)NSArray <TourProductsModel>*TourProducts;

@end
