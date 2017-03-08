//
//  CountTool.h
//  QYRuntimeDemo
//
//  Created by 张庆玉 on 2017/3/7.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountTool : NSObject

+ (void)addClickCount;
+ (NSInteger)getClickCount;
+ (void)resetClickCount;

@end
