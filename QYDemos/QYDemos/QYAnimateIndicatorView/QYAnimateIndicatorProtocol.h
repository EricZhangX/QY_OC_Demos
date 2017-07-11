//
//  QYAnimateIndicatorProtocol.h
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/11.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol QYAnimateIndicatorProtocol <NSObject>


- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor;

@end
