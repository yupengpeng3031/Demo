//
//  HTTPEngine.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
//成功的回调block
typedef void(^SucessBlockType) (id response);
//失败的回调block
typedef void(^FailedBlockType) (NSError *error);

@interface HTTPEngine : NSObject
+(instancetype)shareEngine;
-(void)GET:(NSString*)URLString success:(SucessBlockType)success failure:(FailedBlockType)failure;
@end
