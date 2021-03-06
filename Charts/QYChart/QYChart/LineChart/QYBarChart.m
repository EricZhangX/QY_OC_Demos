//
//  QYBarChart.m
//  QYChart
//
//  Created by 张庆玉 on 2017/4/19.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "QYBarChart.h"



@interface QYBarChart ()

@end

@implementation QYBarChart


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.chartData) {
        [self drawBarWithChartData:self.chartData];
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

@end














