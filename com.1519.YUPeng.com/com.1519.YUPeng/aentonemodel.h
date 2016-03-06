//
//  aentonemodel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"
#import "aenttwomodel.h"
@interface aentonemodel : JSONModel
@property (nonatomic,copy)NSString *CategoryKey;
@property (nonatomic,strong)aenttwomodel *CategoryValue;
@end
