//
//  HTTPEngine.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "HTTPEngine.h"
#import "AFNetworking.h"
@interface HTTPEngine ()
@property (nonatomic,strong)AFHTTPRequestOperationManager *manger;

@end
@implementation HTTPEngine
//声明一个单例
+(instancetype)shareEngine {
    static HTTPEngine *engine = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken,^{
        
        NSLog(@"只执行一次");
        
        engine = [[HTTPEngine alloc]init];
        
    });
    return engine;
}
-(instancetype)init {
    if (self = [super init]) {
        _manger = [AFHTTPRequestOperationManager manager];
        
        _manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        //增加新的类型text/html
        NSSet *currentAcceptSet = self.manger.responseSerializer.acceptableContentTypes;
        NSMutableSet *mset = [NSMutableSet setWithSet:currentAcceptSet];
        [mset addObject:@"text/html"];
        [mset addObject:@"application/json"];
        
        self.manger.responseSerializer.acceptableContentTypes = mset;
    }
    return self;
}
-(void)GET:(NSString *)URLString success:(SucessBlockType)success failure:(FailedBlockType)failure {
    
    [_manger GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
