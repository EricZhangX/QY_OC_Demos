//
//  QYNativeNetWorking.m
//  NativeNetWorking
//
//  Created by 张庆玉 on 2017/3/22.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "QYNativeNetWorking.h"

@implementation QYNativeNetWorking

// 处理字典参数
+ (NSString *)dealWithParam:(NSDictionary *)param {
    NSArray *allkeys = [param allKeys];
    
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *key in allkeys) {
        
        NSString *str = [NSString stringWithFormat:@"%@=%@&",key,param[key]];
        
        [result appendString:str];
    }
    return [result substringWithRange:NSMakeRange(0, result.length-1)];
}

//处理请求头
+ (NSDictionary *)dealRequestHeaderWithParams:(NSDictionary *)params {
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    [header setValue:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    return header;
}

// 自带原生post请求
+ (void)postRequestByServiceUrl:(NSString *)service
                         andApi:(NSString *)api
                      andParams:(NSDictionary *)params
                    andCallBack:(void (^)(id obj))callback {
    //NSString *basePath = [service stringByAppendingString:api];
    
    NSURL *url = [NSURL URLWithString:service];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *body = [self dealWithParam:params];
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置请求体
    [request setHTTPBody:bodyData];
    // 设置请求头
    [request setAllHTTPHeaderFields:[self dealRequestHeaderWithParams:params]];
    
    // 设置本次请求的最长时间
    request.timeoutInterval = 20;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic) {
            callback(dic);
        } else {
            callback(error);
        }
    }];
    
    [task resume];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    //    NSLog(@"didReceiveChallenge");
    //    NSLog(@"%@", challenge.protectionSpace.authenticationMethod);
    
    // 1.从服务器返回的受保护空间中拿到证书的类型
    // 2.判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        /*
         NSURLSessionAuthChallengeUseCredential 使用证书
         NSURLSessionAuthChallengePerformDefaultHandling  忽略证书 默认的做法
         NSURLSessionAuthChallengeCancelAuthenticationChallenge 取消请求,忽略证书
         NSURLSessionAuthChallengeRejectProtectionSpace 拒绝,忽略证书
         */
        NSLog(@"是服务器信任的证书");
        // 3.根据服务器返回的受保护空间创建一个证书
        //         void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *)
        //         代理方法的completionHandler block接收两个参数:
        //         第一个参数: 代表如何处理证书
        //         第二个参数: 代表需要处理哪个证书
        //创建证书
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        // 4.安装证书
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }
}

// 自带原生的get请求方式
+ (void)getRequestByServiceUrl:(NSString *)service
                        andApi:(NSString *)api
                     andParams:(NSDictionary *)params
                   andCallBack:(void (^)(id obj))callback {
    NSString *basePath = [service stringByAppendingString:api];
    NSString *urlString = [NSString string];
    // 因为参数是以字典的形式传进来的，所以用了一个 dealWithParam 方法拼接参数。
    if (params) {
        NSString *paramStr =  [self dealWithParam:params];
        urlString = [basePath stringByAppendingString:paramStr];
    } else {
        urlString = basePath;
    }
    
    NSString *pathStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:pathStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic) {
                callback(dic);
            }else
            {
                
                callback(error.description);
            }
            
            
        });
        
        
    }];
    
    
    [task resume];
    
}

// 原生上传图片

+ (void) postImageWithBaseApi:(NSString *)baseApi AndPragram:(NSDictionary *)pragram updatImage:(UIImage *)image Completion:(void (^) (id obj))completion {
    
    if (!image) {
        return;
    }
    
    NSString *sep = @"ABFC134";
    
    //    1:创建ULR
    NSURL *url = [NSURL URLWithString:baseApi];
    
    //    2:创建Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //    3:设置相关属性
    
    //        3.1设置请求方式
    [request setHTTPMethod:@"POST"];
    
    
    //          3.2处理基本参数(不含图片)
    
    NSArray *allKeys = [pragram allKeys];
    
    NSMutableString *bodyString = [NSMutableString string];
    
    for (NSString *key in allKeys)
    {
        [bodyString appendFormat:@"--%@\r\n",sep];
        
        NSString *temStr = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",key,pragram[key]];
        [bodyString appendString:temStr];
        //        NSLog(@"%@",bodyString);
        
    }
    
    //          3.3拼上图片
    [bodyString appendFormat:@"--%@\r\n",sep];
    
    NSString *imageDes = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n"];
    [bodyString appendString:imageDes];
    
    
    NSString *imageType = [NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"];
    [bodyString appendString:imageType];
    
    //    3.4将图片转换成二进制
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    //    3.5往bodyString中加入图片
    //        3.5.1先将bodyString转成二进制
    NSMutableData *bodyData = [NSMutableData dataWithData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [bodyData appendData:imageData];
    
    //    4追加结束标示
    NSString *end = [NSString stringWithFormat:@"\r\n--%@--",sep];
    [bodyData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //    5:设置请求体
    [request setHTTPBody:bodyData];
    
    //6:设置request的value中content－type
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",sep] forHTTPHeaderField:@"Content-Type"];
    
    //    7:设置请求体的长度
    [request setValue:[NSString stringWithFormat:@"%ld",bodyData.length] forHTTPHeaderField:@"Content-Length"];
    
    //    8:设置超时
    [request setTimeoutInterval:30.0f];
    
    
    //    9：发出请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dic) {
            completion(dic);
        }else
        {
            
            completion(connectionError.description);
            
        }
    }];   
}


@end
