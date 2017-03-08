//
//  HeartRateCurveView.h
//  HeartRateCoreGraphicDemo
//
//  Created by 张庆玉 on 2017/2/17.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeartRateCurveView : UIView

- (void)fireDrawingWithPoints:(CGPoint *)points pointsCount:(NSInteger)count;

@end
