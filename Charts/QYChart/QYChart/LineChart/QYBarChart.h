//
//  QYBarChart.h
//  QYChart
//
//  Created by 张庆玉 on 2017/4/19.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYBarChartData.h"

@interface QYBarChart : UIView

//数据
//X轴数组
@property (nonatomic, strong) NSMutableArray *xAxisTitles;
//y轴数组
@property (nonatomic, strong) NSMutableArray *yAxisTitles;
//y轴数组2
@property (nonatomic, strong) NSMutableArray<NSNumber *> *yAxisValues;
//数据源
@property (nonatomic, strong) NSMutableArray<NSArray<QYBarChartData *> *> *chartData;
//Y轴取值范围
@property (nonatomic, assign) NSRange yAxisRange;

//控制
//是否绘制坐标轴 default = YES
@property (nonatomic, assign) BOOL isDrawCoordinate;
//是否绘制y轴底图 default = YES
@property (nonatomic, assign) BOOL isDrawYaxixBaseLine;
//底图是不是虚线 default = YES
@property (nonatomic, assign) BOOL isDashDotBaseLine;
//是否显示x轴title
@property (nonatomic, assign) BOOL isShowXaxixTitle;
//是否显示y轴title
@property (nonatomic, assign) BOOL isShowYaxixTitle;


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
