//
//  UIButton+hook.m
//  QYRuntimeDemo
//
//  Created by 张庆玉 on 2017/3/7.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "UIButton+hook.h"
#import "Aspects.h"
#import "CountTool.h"
#import <objc/runtime.h>

@implementation UIButton (hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(sendAction:to:forEvent:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL swiSEL = @selector(mySendAction:to:forEvent:);
        Method swiMethod = class_getInstanceMethod(selfClass, swiSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, swiSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, swiMethod);
        }
    });
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [CountTool addClickCount];
    [self mySendAction:action to:target forEvent:event];
}


@end
