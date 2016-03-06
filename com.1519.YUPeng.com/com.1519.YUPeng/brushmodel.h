//
//  brushmodel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"
#import "brushonemodel.h"

@protocol brushonemodel <NSObject>
@end
@interface brushmodel : JSONModel



@property (nonatomic, copy)NSString *Month;

@property (nonatomic,strong)NSArray <brushonemodel>*ProductItemList;
@end
