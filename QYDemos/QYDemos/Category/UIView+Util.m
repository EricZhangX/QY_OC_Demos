//
//  UIView+Util.m
//  SleepPillow
//
//  Created by 张庆玉 on 25/05/2017.
//  Copyright © 2017 MWellness. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

+ (instancetype)getXIBView {
    NSString *xibName = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] firstObject];
}

/**
 *  设置边框宽度
 *
 *  @param borderWidth 可视化视图传入的值
 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

/**
 *  设置边框颜色
 *
 *  @param borderColor 可视化视图传入的值
 */
- (void)setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    UIColor *color = [UIColor colorWithCGColor:self.layer.borderColor];;
    return color;
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 可视化视图传入的值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}


- (void)setBorderCornerWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius {
    borderColor = borderColor == nil ? [UIColor clearColor] : borderColor;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    [self clipsToBounds];
}


// 圆形
- (void)setCircleCorner {
    CGFloat radius = CGRectGetWidth(self.frame) / 2;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    [self clipsToBounds];
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)setX_qy:(CGFloat)x_qy {
    CGRect frame = self.frame;
    frame.origin.x = x_qy;
    self.frame = frame;
}

- (void)setY_qy:(CGFloat)y_qy {
    CGRect frame = self.frame;
    frame.origin.y = y_qy;
    self.frame = frame;
}

- (void)setW_qy:(CGFloat)w_qy {
    CGRect frame = self.frame;
    frame.size.width = w_qy;
    self.frame = frame;
}

- (void)setH_qy:(CGFloat)h_qy {
    CGRect frame = self.frame;
    frame.size.height = h_qy;
    self.frame = frame;
}

- (void)setSize_qy:(CGSize)size_qy {
    CGRect frame = self.frame;
    frame.size = size_qy;
    self.frame = frame;
}

- (void)setOrigin_qy:(CGPoint)origin_qy {
    CGRect frame = self.frame;
    frame.origin = origin_qy;
    self.frame = frame;
}

- (CGFloat)x_qy {
    return self.frame.origin.x;
}

- (CGFloat)y_qy {
    return self.frame.origin.y;
}

- (CGFloat)w_qy {
    return self.frame.size.width;
}

- (CGFloat)h_qy {
    return self.frame.size.height;
}

- (CGSize)size_qy {
    return self.frame.size;
}

- (CGPoint)origin_qy {
    return self.frame.origin;
}


@end















