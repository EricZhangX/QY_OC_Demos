//
//  QYAnimateLineScalePulseOut.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/11.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYAnimateLineScalePulseOut.h"

@implementation QYAnimateLineScalePulseOut

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 1.0f;
    //NSArray *beginTimes = @[@0.4f, @0.2f, @0.0f, @0.2f, @0.4f];
    //NSArray *beginTimes = @[@0.0f, @0.1f, @0.2f, @0.3f, @0.4f, @0.5f, @0.4f, @0.3f, @0.2f, @0.1f, @0.0f, @0.1f, @0.2f, @0.3f, @0.4f, @0.5f, @0.4f, @0.3f, @0.2f, @0.1f, @0.0f];
    
    NSArray *times = @[@0.0f, @0.1f, @0.2f, @0.3f, @0.4f, @0.5f];
    NSMutableArray *timeMutArr = [NSMutableArray new];
    
    for (NSInteger i = 0; i < 8; i++) {
        if (i % 2 == 0) {
            [timeMutArr addObjectsFromArray:times];
        } else {
            for (NSInteger j = times.count - 1; j >= 0; j--) {
               [timeMutArr addObject:[times objectAtIndex:j]];
            }
        }
    }
    NSArray *beginTimes = [NSArray arrayWithArray:timeMutArr];
    
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.85f :0.25f :0.37f :0.85f];
    CGFloat lineSize = size.width / (beginTimes.count * 2);
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    
    animation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    animation.values = @[@1.0f, @0.4f, @1.0f];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.repeatCount = HUGE_VALF;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    NSInteger waveCount = 14;
    
    for (NSInteger i = 0; i < beginTimes.count; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        
        //计算高度
        CGFloat percent = (float)(i + 1) * waveCount / beginTimes.count;
        CGFloat mark = waveCount * 0.5;
        CGFloat offSet = (mark - percent) / mark;
        if (offSet < 0) {
            offSet = -offSet;
        }
        offSet = 1 - offSet;
        CGFloat offPercent = 2.f * offSet;
        
        for (NSInteger j = 0; j < waveCount; j++) {
            if (percent > j && percent <= (j + 1)) {
                if (j % 2 == 0) {
                    percent = percent - j + offPercent;
                } else {
                    percent = j + 1 - percent + offPercent;
                }
            }
        }
        
        CGFloat lineHeight = size.height * percent * percent;
        
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, (size.height - lineHeight) * 0.5, lineSize, lineHeight) cornerRadius:lineSize / 2];
        
        animation.beginTime = [beginTimes[i] floatValue];
        line.fillColor = tintColor.CGColor;
        line.path = linePath.CGPath;
        [line addAnimation:animation forKey:@"animation"];
        line.frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, size.height);
        [layer addSublayer:line];
    }
}

@end
