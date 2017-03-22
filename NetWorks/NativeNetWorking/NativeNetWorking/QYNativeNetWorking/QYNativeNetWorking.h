//
//  QYNativeNetWorking.h
//  NativeNetWorking
//
//  Created by 张庆玉 on 2017/3/22.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QYNativeNetWorking : NSObject<NSURLSessionDelegate>
/**
 * 原生post请求（NSURLSession）JSON解析
 */

+ (void)postRequestByServiceUrl:(NSString *)service
                         andApi:(NSString *)api
                      andParams:(NSDictionary *)params
                    andCallBack:(void (^)(id obj))callback;

/**
 * 原生get请求（NSURLSession）JSON解析
 */
+ (void)getRequestByServiceUrl:(NSString *)service
                        andApi:(NSString *)api
                     andParams:(NSDictionary *)params
                   andCallBack:(void (^)(id obj))callback;

/**
 * 原生上传图片
 */
+ (void) postImageWithBaseApi:(NSString *)baseApi
                   AndPragram:(NSDictionary *)pragram
                   updatImage:(UIImage *)image
                   Completion:(void (^) (id obj))completion;

/**
 * 原生下载
 */
+ (void) postImageWithBaseApi:(NSString *)baseApi
                   AndPragram:(NSDictionary *)pragram
                   updatImage:(UIImage *)image
                   Completion:(void (^) (id obj))completion;

@end
