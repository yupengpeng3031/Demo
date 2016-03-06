//
//  CacheManger.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "CacheManger.h"

#import "NSString+Hashing.h"

@implementation CacheManger

//制定一个存取数据路径 方便存取

+(NSString*)cacheDirectory {
    
    //创建一个路径
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    cacheDir = [cacheDir stringByAppendingPathComponent:@"mycache"];
    
    NSLog(@"%@",cacheDir);
    
    NSError *error;
    
    BOOL bret = [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (!bret) {
        
        return nil;
    }
    
    return cacheDir;
}

//返回 指定URL 数据保存的全部路径
+(NSString*)fullPathWithUrl:(NSString*)urlStr {
    
    //先去得到缓存的路径
    NSString *cacheDir = [self cacheDirectory];
    //得到URL加密以后的字符串
    NSString *md5Str = [urlStr MD5Hash];
    //拼成完整路径
    NSString *fullPath = [cacheDir stringByAppendingPathComponent:md5Str];
    
    return fullPath;
    
}
//存数据
+(void)savedData:(id)object withUrl:(NSString *)urlStr {
    
    //首先拿到 文件的地址
    NSString *path = [self fullPathWithUrl:urlStr];
    //把对象转化为二进制
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    [data writeToFile:path atomically:YES];
}

//读数据
+(id)readDataWithUrl:(NSString *)urlStr {
    //先把URL 转换为地址路径
    NSString *path = [self fullPathWithUrl:urlStr];
    
    //读取数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    //最后返回的时候 需要把二进制数据转化为对象(解归当)
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}

@end
