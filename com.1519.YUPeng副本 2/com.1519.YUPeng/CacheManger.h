//
//  CacheManger.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//sdwebiamge 缓存原理(图片) 就是把请求回来的数据存在本地沙盒里，把这个请求的url用MD5 加密一下，当做文件名称。

@interface CacheManger : NSObject

//存数据
+(void)savedData:(id)object withUrl:(NSString*)urlStr;

//读数据
+(id)readDataWithUrl:(NSString*)urlStr;

@end
