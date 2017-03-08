//
//  UIViewController+hook.m
//  QYRuntimeDemo
//
//  Created by 张庆玉 on 2017/3/7.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "UIViewController+hook.h"
#import "Aspects.h"
#import <objc/runtime.h>

@implementation UIViewController (hook)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //case1: 替换实例方法
        Class selfClass = [self class];
        //case2: 替换类方法
        //Class selfClass = object_getClass([self class]);
        
        //源方法的SEL和Method
        SEL oriSEL = @selector(viewWillAppear:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        //交换方法的SEL和Method
        SEL swiSEL = @selector(swizzled_viewWillAppear:);
        Method swiMethod = class_getInstanceMethod(selfClass, swiSEL);
        
        //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        if (addSucc) {
            //添加成功：将源方法的实现替换到交换方法的实现
            class_replaceMethod(selfClass, swiSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
            method_exchangeImplementations(oriMethod, swiMethod);
        }
    });
    
    //使用Aspects
    [self aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo> info) {
        NSLog(@"%@ -- viewDidLoad", NSStringFromClass([self class]));
    } error:nil];
}

- (void)swizzled_viewWillAppear:(BOOL)animation {
    [self swizzled_viewWillAppear:animation];
    NSLog(@"%@ -- viewWillAppear", NSStringFromClass([self class]));
}

@end
