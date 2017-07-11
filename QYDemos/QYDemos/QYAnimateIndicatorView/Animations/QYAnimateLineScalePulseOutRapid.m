//
//  QYAnimateLineScalePulseOutRapid.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/11.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYAnimateLineScalePulseOutRapid.h"

@implementation QYAnimateLineScalePulseOutRapid

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 0.9f;
    NSArray *beginTimes = @[@0.5f, @0.4f, @0.3f, @0.2f, @0.1f, @0.0f, @0.1f, @0.2f, @0.3f, @0.4f, @0.5f];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.11f :0.49f :0.38f :0.78f];
    CGFloat lineSize = size.width / (beginTimes.count * 2);
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    
    animation.keyTimes = @[@0.0f, @0.8f, @0.9f];
    animation.values = @[@1.0f, @0.3f, @1.0f];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.repeatCount = HUGE_VALF;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    for (int i = 0; i < beginTimes.count; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, lineSize, size.height) cornerRadius:lineSize / 2];
        
        animation.beginTime = [beginTimes[i] floatValue];
        line.fillColor = tintColor.CGColor;
        line.path = linePath.CGPath;
        [line addAnimation:animation forKey:@"animation"];
        line.frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, size.height);
        [layer addSublayer:line];
    }
}

@end
