//
//  QYBarChart.m
//  QYChart
//
//  Created by 张庆玉 on 2017/4/19.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "QYBarChart.h"

#define BAR_CHART_TOP_PADDING 30
#define BAR_CHART_LEFT_PADDING 20
#define BAR_CHART_RIGHT_PADDING 8

@interface QYBarChart ()

@property (nonatomic, strong) NSMutableArray *xLabels;

@end

@implementation QYBarChart

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaultValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValues];
    }
    return self;
}

- (void)setupDefaultValues {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds   = YES;

    //数据
    _xAxisTitles = [NSMutableArray new];
    _yAxisTitles = [NSMutableArray new];
    _yAxisValues = [NSMutableArray new];
    //控制
    _isDrawCoordinate = YES;
    _isDrawYaxixBaseLine = YES;
    _isDashDotBaseLine = YES;
    _isShowXaxixTitle = YES;
    _isShowYaxixTitle = YES;
    //颜色
    _yAxisTitleColor = [UIColor blackColor];
    _xAxisTitleColor = [UIColor blackColor];
    _coordinateColor = [UIColor blackColor];
    _baseLineColor = [UIColor grayColor];
    //尺寸
    _yAxisTitleWidth = 40;
    _yAxisTitleOffset = 0;
    _xAxisTitleHeight = 20;
    _xAxisTitleOffset = 0;
    _coordinateLineWidth = 1;
    
    //--
    _xLabels = [NSMutableArray new];
}

- (void)drawChart { 
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    if (self.isDrawCoordinate) {
        [self drawCoordinateWithContext];
    }
    if (self.isDrawYaxixBaseLine) {
        if (self.isDashDotBaseLine) {
            [self drawDashLine];
        } else {
            [self drawBaseLine];
        }
    }
    if (self.chartData) {
        [self drawBarWithChartData:self.chartData];
        if (self.isShowXaxixTitle) {
            [self drawXLabels];
        }
    }
}

- (void)drawXLabels {
    if (self.xLabels.count) {
        [self.xLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.xLabels removeAllObjects];
    }
    
    CGFloat offSetY = self.isShowYaxixTitle ? (self.yAxisTitleWidth + self.yAxisTitleOffset) : 0;
    CGFloat offSetX = self.isShowXaxixTitle ? (self.xAxisTitleHeight + self.xAxisTitleOffset) : 0;
    CGFloat chartWidth = self.bounds.size.width - BAR_CHART_LEFT_PADDING - offSetY - BAR_CHART_RIGHT_PADDING;
    
    for (int i = 0; i < self.xAxisTitles.count; i++) {
        CGFloat xPosition = chartWidth * (i+1)/(self.xAxisTitles.count + 1);
        CGFloat labelWidth = chartWidth/self.xAxisTitles.count;
        
        UILabel *xlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, self.xAxisTitleHeight)];
        xlabel.font                      = [UIFont boldSystemFontOfSize:11.0f];
        xlabel.backgroundColor           = [UIColor clearColor];
        xlabel.textColor                 = self.xAxisTitleColor;
        xlabel.textAlignment             = NSTextAlignmentCenter;
        xlabel.userInteractionEnabled    = YES;
        xlabel.adjustsFontSizeToFitWidth = YES;
        xlabel.numberOfLines             = 0;
        xlabel.text                      = self.xAxisTitles[i];
        xlabel.center                    = CGPointMake(offSetY + BAR_CHART_LEFT_PADDING + xPosition, self.bounds.size.height - offSetX + self.xAxisTitleHeight * 0.5);
        
        [self.xLabels addObject:xlabel];
        [self addSubview:xlabel];
    }
}

- (void)drawBarWithChartData:(NSArray *)datas {
    CGFloat offSetY = self.isShowYaxixTitle ? (self.yAxisTitleWidth + self.yAxisTitleOffset) : 0;
    CGFloat offSetX = self.isShowXaxixTitle ? (self.xAxisTitleHeight + self.xAxisTitleOffset) : 0;
    CGFloat chartHeight = self.bounds.size.height - BAR_CHART_TOP_PADDING - offSetX;
    CGFloat chartWidth = self.bounds.size.width - BAR_CHART_LEFT_PADDING - offSetY - BAR_CHART_RIGHT_PADDING;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSInteger count = datas.count > self.xAxisTitles.count ? datas.count : self.xAxisTitles.count;
    
    for (int i = 0; i < count; i++) {
        NSArray *barDatas = datas[i];
        //柱状图x轴定位
        CGFloat xPosition = chartWidth * (i+1)/(count + 1);
        
        //柱状图y轴定位
        CGFloat currentValue = 0.f;
        for (int j = 0; j < barDatas.count; j++) {
            QYBarChartData *barData = barDatas[j];
            
            CGFloat yValue = currentValue + barData.value;
            CGFloat yStartPosition = chartHeight * (1.f -(currentValue - self.yAxisRange.location) / self.yAxisRange.length);
            CGFloat yEndPosition = chartHeight * (1.f -(yValue - self.yAxisRange.location) / self.yAxisRange.length);
            currentValue += barData.value;
            
//            UIBezierPath *path = [UIBezierPath bezierPath];
//            [path moveToPoint:CGPointMake(offSetY + BAR_CHART_LEFT_PADDING + xPosition, BAR_CHART_TOP_PADDING + yStartPosition)];
//            [path addLineToPoint:CGPointMake(offSetY + BAR_CHART_LEFT_PADDING + xPosition, BAR_CHART_TOP_PADDING + yEndPosition)];
//            path.lineWidth = barData.barWidth;
//            [barData.color setStroke];
//            [path stroke];
            
            CGContextSetLineWidth(context, barData.barWidth);
            CGContextSetStrokeColorWithColor(context, barData.color.CGColor);
            CGContextMoveToPoint(context, offSetY + BAR_CHART_LEFT_PADDING + xPosition, BAR_CHART_TOP_PADDING + yStartPosition);
            CGContextAddLineToPoint(context, offSetY + BAR_CHART_LEFT_PADDING + xPosition, BAR_CHART_TOP_PADDING + yEndPosition);
            CGContextStrokePath(context);
        }
    }
}


#pragma mark - Draw Coordinate
- (void)drawCoordinateWithContext {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat width = self.bounds.size.width;
    CGFloat offSetY = self.isShowYaxixTitle ? (self.yAxisTitleWidth + self.yAxisTitleOffset) : 0;
    CGFloat offSetX = self.isShowXaxixTitle ? (self.xAxisTitleHeight + self.xAxisTitleOffset) : 0;
    CGFloat chartHeight = self.bounds.size.height - BAR_CHART_TOP_PADDING - offSetX;
    
    CGContextSetStrokeColorWithColor(context, self.coordinateColor.CGColor);
    CGContextMoveToPoint(context, offSetY + BAR_CHART_LEFT_PADDING, BAR_CHART_TOP_PADDING);
    CGContextAddLineToPoint(context, offSetY + BAR_CHART_LEFT_PADDING, BAR_CHART_TOP_PADDING + chartHeight);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, self.coordinateColor.CGColor);
    CGContextMoveToPoint(context, offSetY + BAR_CHART_LEFT_PADDING, BAR_CHART_TOP_PADDING + chartHeight);
    CGContextAddLineToPoint(context, width - BAR_CHART_RIGHT_PADDING, BAR_CHART_TOP_PADDING + chartHeight);
    CGContextStrokePath(context);
}

// 绘制网格
- (void)drawBaseLine {
    //绘制实线网格
    if (!self.yAxisValues.count) {
        return;
    }
    CGFloat width = self.bounds.size.width;
    CGFloat offSetY = self.isShowYaxixTitle ? (self.yAxisTitleWidth + self.yAxisTitleOffset) : 0;
    CGFloat offSetX = self.isShowXaxixTitle ? (self.xAxisTitleHeight + self.xAxisTitleOffset) : 0;
    CGFloat chartHeight = self.bounds.size.height - BAR_CHART_TOP_PADDING - offSetX;
    //绘制实线网格
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.baseLineColor.CGColor);
    // 画横虚线
    for (NSInteger i=0; i<self.yAxisValues.count; i++) {
        NSNumber *value = self.yAxisValues[i];
        CGFloat num = [value floatValue];
        CGFloat yPosition = chartHeight * (1.f -(num - self.yAxisRange.location) / self.yAxisRange.length);
        
        CGContextMoveToPoint(context, offSetY + BAR_CHART_LEFT_PADDING, BAR_CHART_TOP_PADDING + yPosition);
        CGContextAddLineToPoint(context, width - BAR_CHART_RIGHT_PADDING, BAR_CHART_TOP_PADDING + yPosition);
        CGContextStrokePath(context);
    }
}

- (void)drawDashLine {
    if (!self.yAxisValues.count) {
        return;
    }
    CGFloat width = self.bounds.size.width;
    CGFloat offSetY = self.isShowYaxixTitle ? (self.yAxisTitleWidth + self.yAxisTitleOffset) : 0;
    CGFloat offSetX = self.isShowXaxixTitle ? (self.xAxisTitleHeight + self.xAxisTitleOffset) : 0;
    CGFloat chartHeight = self.bounds.size.height - BAR_CHART_TOP_PADDING - offSetX;
    //绘制虚线网格
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置上下文环境 属性
    CGFloat dashLineWidth = 1.f;
    [self.baseLineColor setStroke];
    CGContextSetLineWidth(context, dashLineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetAlpha(context, 0.7);
    CGFloat alilengths[2] = {5, 3};
    CGContextSetLineDash(context, 0, alilengths, 2);
    // 画横虚线
    for (NSInteger i=0; i<self.yAxisValues.count; i++) {
        NSNumber *value = self.yAxisValues[i];
        CGFloat num = [value floatValue];
        CGFloat yPosition = chartHeight * (1.f -(num - self.yAxisRange.location) / self.yAxisRange.length);
        
        CGPoint startPoint = CGPointMake(offSetY + BAR_CHART_LEFT_PADDING, BAR_CHART_TOP_PADDING + yPosition);
        CGPoint endPoint = CGPointMake(width - BAR_CHART_RIGHT_PADDING, BAR_CHART_TOP_PADDING + yPosition);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y );
        CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y );
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathEOFillStroke);
        CGPathRelease(path);
    }
    CGFloat alilengths2[2] = {5, 0};
    CGContextSetLineDash(context, 0, alilengths2, 2);
}


@end














