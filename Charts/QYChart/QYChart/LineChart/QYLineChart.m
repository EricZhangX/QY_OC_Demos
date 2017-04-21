//
//  QYLineChart.m
//  QYChart
//
//  Created by 张庆玉 on 2017/4/19.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "QYLineChart.h"

#define StartPointKey   @"StartPointKey"
#define EndPointKey     @"EndPointKey"

@interface QYLineChart ()
/** 渐变背景视图 */
@property (nonatomic, strong) UIView *gradientBackgroundView;
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;
/** 折线/曲线图层 */
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

@end

@implementation QYLineChart

- (void)setChartData:(NSMutableArray<QYLineChartData *> *)chartData {
    _chartData = [chartData mutableCopy];
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.chartData.count) {
        if (self.isGradientRamp) {
            [self drawGradientBackgroundView];
            [self drawGradientLine];
        } else {
            if (self.gradientBackgroundView) {
                [self.gradientBackgroundView removeFromSuperview];
            }
            [self drawLineChart];
        }
    }
    
    
    
}

// 绘制正常曲线
- (void)drawLineChart {
    for (NSInteger i = 0; i < self.chartData.count; i++) {
        QYLineChartData *lineData = self.chartData[i];
        NSInteger totalCount = lineData.values.count;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        for (NSInteger j = 0; j < totalCount; j++) {
            if (j > 0) {
                
                NSNumber *num = lineData.values[j];
                NSNumber *lastNum = lineData.values[j-1];
                
                CGPoint startPoint = [self caculateNormalPointWithXindex:j-1 Yvalue:lastNum TotalCount:totalCount];
                CGPoint endPoint = [self caculateNormalPointWithXindex:j Yvalue:num TotalCount:totalCount];
                
                if (self.isCurveLine) {//曲线
                    CGPoint midPoint = [self midPointBetweenPoint1:startPoint andPoint2:endPoint];
                    
                    [path addQuadCurveToPoint:midPoint
                                 controlPoint:[self controlPointBetweenPoint1:midPoint andPoint2:startPoint]];
                    [path addQuadCurveToPoint:endPoint
                                 controlPoint:[self controlPointBetweenPoint1:midPoint andPoint2:endPoint]];
                } else {//折线
                    [path addLineToPoint:endPoint];
                }
            } else {
                NSNumber *num = lineData.values[0];
                CGPoint startPoint = [self caculateNormalPointWithXindex:0 Yvalue:num TotalCount:totalCount];
                [path moveToPoint:startPoint];
            }
        }
        path.lineWidth = lineData.lineWidth;
        [lineData.color setStroke];
        [path stroke];
    }
    
}

// 绘制渐变曲线
- (void)drawGradientLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < self.chartData.count; i++) {
        QYLineChartData *lineData = self.chartData[i];
        NSInteger totalCount = lineData.values.count;
        
        
        for (NSInteger j = 0; j < totalCount; j++) {
            if (j > 0) {
                NSNumber *num = lineData.values[j];
                NSNumber *lastNum = lineData.values[j-1];
                
                CGPoint startPoint = [self caculatePointWithXindex:j-1 Yvalue:lastNum TotalCount:totalCount];
                CGPoint endPoint = [self caculatePointWithXindex:j Yvalue:num TotalCount:totalCount];
                
                if (self.isCurveLine) {//曲线
                    CGPoint midPoint = [self midPointBetweenPoint1:startPoint andPoint2:endPoint];
                    
                    [path addQuadCurveToPoint:midPoint
                                 controlPoint:[self controlPointBetweenPoint1:midPoint andPoint2:startPoint]];
                    [path addQuadCurveToPoint:endPoint
                                 controlPoint:[self controlPointBetweenPoint1:midPoint andPoint2:endPoint]];
                } else {//折线
                    [path addLineToPoint:endPoint];
                }
            } else {
                NSNumber *num = lineData.values[0];
                CGPoint startPoint = [self caculatePointWithXindex:0 Yvalue:num TotalCount:totalCount];
                [path moveToPoint:startPoint];
            }
        }
    }
    
    if (self.yAxisValues.count) {
        //绘制网格
        for (NSInteger i=0; i<self.yAxisValues.count; i++) {
            NSNumber *value = self.yAxisValues[i];
            CGFloat num = [value floatValue];
            CGFloat yPosition = chartHeight * (1.f -(num - self.yAxisRange.location) / self.yAxisRange.length);
            
            [path moveToPoint:CGPointMake(0, yPosition)];
            [path addLineToPoint:CGPointMake(chartWidth, yPosition)];
        }
    }
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.lineWidth = 1;
    self.gradientBackgroundView.layer.mask = _lineChartLayer;
}

// 绘制渐变背景视图（不包含坐标轴）
- (void)drawGradientBackgroundView {
    if (self.gradientBackgroundView) {
        [self.gradientBackgroundView removeFromSuperview];
    }
    self.gradientBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(offSetY + BAR_CHART_LEFT_PADDING + .5, BAR_CHART_TOP_PADDING, chartWidth-.5, chartHeight-.5)];
    [self addSubview:self.gradientBackgroundView];
    /** 创建并设置渐变背景图层 */
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientBackgroundView.bounds;
    //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
    self.gradientLayer.startPoint = CGPointMake(0, 1.0);
    self.gradientLayer.endPoint = CGPointMake(0.0, 0.0);
    //设置颜色的渐变过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:175 / 255.0 green:105 / 255.0 blue:205 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:75 / 255.0 green:55 / 255.0 blue:175 / 255.0 alpha:1.0].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.gradientBackgroundView.layer addSublayer:self.gradientLayer];
}

//正常情况下获取定位
- (CGPoint)caculateNormalPointWithXindex:(NSInteger)xindex Yvalue:(NSNumber *)yvalue TotalCount:(NSInteger)totalCount {
    CGFloat num = [yvalue floatValue];
    CGFloat xPosition = offSetY + BAR_CHART_LEFT_PADDING + (chartWidth * (xindex+1)/(totalCount + 1));
    CGFloat yPosition = self.bounds.size.height - offSetX - (chartHeight * ((num - self.yAxisRange.location) / self.yAxisRange.length));
    return CGPointMake(xPosition, yPosition);
}

//在渐变情况下获取点定位
- (CGPoint)caculatePointWithXindex:(NSInteger)xindex Yvalue:(NSNumber *)yvalue TotalCount:(NSInteger)totalCount {
    CGFloat num = [yvalue floatValue];
    CGFloat xPosition = (chartWidth * (xindex+1)/(totalCount + 1));
    CGFloat yPosition = chartHeight - (chartHeight * ((num - self.yAxisRange.location) / self.yAxisRange.length));
    return CGPointMake(xPosition, yPosition);
}

- (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2);
}

- (CGPoint)controlPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    CGPoint controlPoint = [self midPointBetweenPoint1:point1 andPoint2:point2];
    CGFloat diffY = abs((int) (point2.y - controlPoint.y));
    if (point1.y < point2.y)
        controlPoint.y += diffY;
    else if (point1.y > point2.y)
        controlPoint.y -= diffY;
    return controlPoint;
}

@end












