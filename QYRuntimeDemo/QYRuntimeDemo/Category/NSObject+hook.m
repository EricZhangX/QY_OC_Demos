//
//  NSObject+hook.m
//  QYRuntimeDemo
//
//  Created by 张庆玉 on 2017/3/8.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "NSObject+hook.h"

#import <objc/message.h>

@implementation NSObject (hook)

- (void)setHookTitle:(NSString *)hookTitle {
    // 动态添加属性的本质是:让对象的某个属性与值产生关联
    objc_setAssociatedObject(self, "hookTitle", hookTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)hookTitle {
    return objc_getAssociatedObject(self, "hookTitle");
}

/*
 解析:
 // 关联值的方法
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 
 object:保存到哪个对象中
 key:用什么属性保存传入的值
 value:需保存值
 policy:策略,strong,weak等
 
 // 获取值的方法:
 objc_getAssociatedObject(id object, const void *key);
 
 object:从哪个对象中获取值
 key: 用什么属性获取值
 */
@end
