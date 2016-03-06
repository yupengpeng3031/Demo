//
//  TopicModel.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "JSONModel.h"
#import "TopicValueModel.h"
@interface TopicModel : JSONModel
@property (nonatomic,copy)NSString *CategoryKey;
@property(nonatomic,strong)TopicValueModel *CategoryValue;
@end
