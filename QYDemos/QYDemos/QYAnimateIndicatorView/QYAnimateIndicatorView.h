//
//  QYAnimateIndicatorView.h
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/11.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QYAnimateIndicatorType) {
    QYAnimateIndicatorTypeLineScalePulseOut,
    QYAnimateIndicatorTypeLineScalePulseOutRapid
};


@interface QYAnimateIndicatorView : UIView

- (id)initWithType:(QYAnimateIndicatorType)type;
- (id)initWithType:(QYAnimateIndicatorType)type tintColor:(UIColor *)tintColor;
- (id)initWithType:(QYAnimateIndicatorType)type tintColor:(UIColor *)tintColor size:(CGSize)size;

@property (nonatomic) QYAnimateIndicatorType type;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGSize size;

@property (nonatomic, readonly) BOOL animating;

- (void)startAnimating;
- (void)stopAnimating;

@end
