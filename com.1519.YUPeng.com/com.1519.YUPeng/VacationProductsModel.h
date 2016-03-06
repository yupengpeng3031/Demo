//
//  VacationProductsModel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"

@interface VacationProductsModel : JSONModel
@property (nonatomic,copy)NSString *ProductName;
@property (nonatomic,copy)NSString *ProductId;
@property (nonatomic,copy)NSString *Price;
@property (nonatomic,copy)NSString *SystemType;
@property (nonatomic,copy)NSString *ImgSrc;
@property (nonatomic,copy)NSString *ProductTypeName;
@property (nonatomic,copy)NSString *ProductTypeId;
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *Destination;
@property (nonatomic,copy)NSString *DiscountType;
@property (nonatomic,copy)NSString *LabelType;
@end
