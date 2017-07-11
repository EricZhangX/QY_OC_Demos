//
//  QYAnimateIndicatorView.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/11.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYAnimateIndicatorView.h"

#import "QYAnimateLineScalePulseOut.h"
#import "QYAnimateLineScalePulseOutRapid.h"

static const CGFloat QYAnimateIndicatorDefaultWidth  = 40.0f;
static const CGFloat QYAnimateIndicatorDefaultHeight = 20.0f;


@implementation QYAnimateIndicatorView

#pragma mark -
#pragma mark Constructors

- (id)initWithType:(QYAnimateIndicatorType)type {
    return [self initWithType:type tintColor:[UIColor whiteColor] size:CGSizeMake(QYAnimateIndicatorDefaultWidth, QYAnimateIndicatorDefaultHeight)];
}

- (id)initWithType:(QYAnimateIndicatorType)type tintColor:(UIColor *)tintColor {
    return [self initWithType:type tintColor:tintColor size:CGSizeMake(QYAnimateIndicatorDefaultWidth, QYAnimateIndicatorDefaultHeight)];
}

- (id)initWithType:(QYAnimateIndicatorType)type tintColor:(UIColor *)tintColor size:(CGSize)size {
    self = [super init];
    if (self) {
        _type = type;
        _size = size;
        _tintColor = tintColor;
    }
    return self;
}

#pragma mark -
#pragma mark Methods

- (void)setupAnimation {
    self.layer.sublayers = nil;
    
    id<QYAnimateIndicatorProtocol
    > animation = [QYAnimateIndicatorView activityIndicatorAnimationForAnimationType:_type];
    
    if ([animation respondsToSelector:@selector(setupAnimationInLayer:withSize:tintColor:)]) {
        [animation setupAnimationInLayer:self.layer withSize:_size tintColor:_tintColor];
        self.layer.speed = 0.0f;
    }
}

- (void)startAnimating {
    if (!self.layer.sublayers) {
        [self setupAnimation];
    }
    self.layer.speed = 1.0f;
    _animating = YES;
}

- (void)stopAnimating {
    self.layer.speed = 0.0f;
    _animating = NO;
}

#pragma mark -
#pragma mark Setters

- (void)setType:(QYAnimateIndicatorType)type {
    if (_type != type) {
        _type = type;
        
        [self setupAnimation];
    }
}

- (void)setSize:(CGSize)size {
    if (_size.width != size.width || _size.height != size.height) {
        _size = size;
        
        [self setupAnimation];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (![_tintColor isEqual:tintColor]) {
        _tintColor = tintColor;
        
        for (CALayer *sublayer in self.layer.sublayers) {
            sublayer.backgroundColor = tintColor.CGColor;
        }
    }
}

#pragma mark -
#pragma mark Getters

+ (id<QYAnimateIndicatorProtocol>)activityIndicatorAnimationForAnimationType:(QYAnimateIndicatorType)type {
    switch (type) {
        case QYAnimateIndicatorTypeLineScalePulseOut:
            return [[QYAnimateLineScalePulseOut alloc] init];
        case QYAnimateIndicatorTypeLineScalePulseOutRapid:
            return [[QYAnimateLineScalePulseOutRapid alloc] init];
    }
    return nil;
}


@end


















