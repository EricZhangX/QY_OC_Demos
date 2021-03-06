//
//  QYLineChart.h
//  QYChart
//
//  Created by 张庆玉 on 2017/4/19.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "QYCoordinateChart.h"
#import "QYLineChartData.h"
#import "QYColor.h"


@interface QYLineChart : QYCoordinateChart

@property (nonatomic, strong) NSMutableArray<QYLineChartData *> *chartData;

//是否是曲线
@property (nonatomic, assign) BOOL isCurveLine;
//是否是渐变色
@property (nonatomic, assign) BOOL isGradientRamp;

@property (nonatomic, strong) QYColor *startColor;
@property (nonatomic, strong) QYColor *endColor;

@end
