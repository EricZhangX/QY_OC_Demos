//
//  CountTool.m
//  QYRuntimeDemo
//
//  Created by 张庆玉 on 2017/3/7.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "CountTool.h"

@implementation CountTool

static NSInteger clickCount = 0;
+ (void)addClickCount {
    clickCount ++;
}

+ (NSInteger)getClickCount {
    return clickCount;
}

+ (void)resetClickCount {
    clickCount = 0;
}

@end
