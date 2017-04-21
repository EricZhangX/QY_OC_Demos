//
//  QYCoordinateChart.h
//  QYChart
//
//  Created by 张庆玉 on 2017/4/19.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_CHART_TOP_PADDING 30
#define BAR_CHART_LEFT_PADDING 20
#define BAR_CHART_RIGHT_PADDING 8

@interface QYCoordinateChart : UIView
{
    CGFloat offSetY;
    CGFloat offSetX;
    CGFloat chartWidth;
    CGFloat chartHeight;
}

//数据
//X轴数组
@property (nonatomic, strong) NSMutableArray *xAxisTitles;
//y轴数组
@property (nonatomic, strong) NSMutableArray *yAxisTitles;
//y轴数组2
@property (nonatomic, strong) NSMutableArray<NSNumber *> *yAxisValues;
//Y轴取值范围
@property (nonatomic, assign) NSRange yAxisRange;
//底图颜色数组
@property (nonatomic, strong) NSMutableArray<UIColor *> *baseLineColors;

//控制
//是否绘制坐标轴 default = YES
@property (nonatomic, assign) BOOL isDrawCoordinate;
//是否绘制y轴底图 default = YES
@property (nonatomic, assign) BOOL isDrawYaxixBaseLine;
//底图是不是虚线 default = YES
@property (nonatomic, assign) BOOL isDashDotBaseLine;
//是否显示x轴title default = YES
@property (nonatomic, assign) BOOL isShowXaxixTitle;
//是否显示y轴title default = YES
@property (nonatomic, assign) BOOL isShowYaxixTitle;
//y轴title 是否与标尺对齐 default = YES
@property (nonatomic, assign) BOOL isYaxixTitleSameLevelWithBaseline;


//颜色
//Y轴字体颜色 default = black
@property (nonatomic, strong) UIColor *yAxisTitleColor;
//X轴字体颜色 default = black
@property (nonatomic, strong) UIColor *xAxisTitleColor;
//坐标轴颜色 default = black
@property (nonatomic, strong) UIColor *coordinateColor;
//底图颜色 default = gray
@property (nonatomic, strong) UIColor *baseLineColor;


//尺寸
//Y轴Title的宽度 default = 40
@property (nonatomic, assign) CGFloat yAxisTitleWidth;
//y轴Title的偏移量 default = 0
@property (nonatomic, assign) CGFloat yAxisTitleOffset;
//X轴Title的高度 default = 20
@property (nonatomic, assign) CGFloat xAxisTitleHeight;
//x轴Title的偏移量 default = 1
@property (nonatomic, assign) CGFloat xAxisTitleOffset;

//坐标轴宽度 default = 1
@property (nonatomic, assign) CGFloat coordinateLineWidth;

- (void)drawChart;

@end
