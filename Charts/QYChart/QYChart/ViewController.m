//
//  ViewController.m
//  QYChart
//
//  Created by 张庆玉 on 2017/4/14.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "ViewController.h"
#import "QYBarChart.h"
#import "QYLineChart.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet QYBarChart *barChart;
@property (weak, nonatomic) IBOutlet QYLineChart *lineChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBarChart];
    [self drawLineChart];
}

- (void)drawBarChart {
    NSMutableArray *dataArr = [NSMutableArray new];
    NSMutableArray *titles = [NSMutableArray new];
    
    for (int i = 0; i<10; i++) {
        NSInteger rand = random()%3+1;
        NSMutableArray *barDatas = [NSMutableArray new];
        for (int j = 0;  j< rand; j++) {
            UIColor *color = [UIColor colorWithRed:1.f/rand green:0.867/rand blue:0.345/rand alpha:1.00];
            CGFloat value = (j+1) * 5;
            
            QYBarChartData *data = [[QYBarChartData alloc] initWithValue:value Width:10.f Color:color];
            [barDatas addObject:data];
        }
        [dataArr addObject:barDatas];
        
        NSString *title = [NSString stringWithFormat:@"X-%d",i];
        [titles addObject:title];
    }
    
    self.barChart.chartData = dataArr;
    self.barChart.yAxisRange = NSMakeRange(0, 100);
    self.barChart.isShowYaxixTitle = NO;
    self.barChart.coordinateColor = [UIColor colorWithRed:0.722 green:0.200 blue:0.631 alpha:1.00];
    self.barChart.xAxisTitles = titles;
    [self.barChart drawChart];
}

- (void)drawLineChart {
    NSMutableArray *xtitles = [NSMutableArray new];
    NSMutableArray *ytitles = [NSMutableArray new];
    NSMutableArray *yValues = [NSMutableArray new];
    NSMutableArray *baseLineColors = [NSMutableArray new];
    
    NSMutableArray *values = [NSMutableArray new];
    NSMutableArray *values2 = [NSMutableArray new];
    for (int i = 0; i<10; i++) {

        NSString *xtitle = [NSString stringWithFormat:@"X%d",i];
        [xtitles addObject:xtitle];
        
        if (i%2 == 0 && i != 0) {
            NSInteger value = i*10;//+random()%5;
            [yValues addObject:@(value)];
            
            NSString *ytitle = [NSString stringWithFormat:@"Y%d",i];
            [ytitles addObject:ytitle];
            
            UIColor *color = [UIColor colorWithRed:1.f/i green:0.867/i blue:0.1*i alpha:1.00];
            [baseLineColors addObject:color];
        }
        
        NSInteger rand = random()%10+1;
        CGFloat value = i * 5 + 20;
        [values addObject:@(value)];
        
        NSInteger rand1 = random()%10+5;
        CGFloat value1 = (rand1+1) * 5;
        [values2 addObject:@(value1)];
    }
    
    QYLineChartData * data = [[QYLineChartData alloc] initWithValues:values Color:[UIColor redColor] LineWidth:1.f];
    QYLineChartData * data1 = [[QYLineChartData alloc] initWithValues:values2 Color:[UIColor greenColor] LineWidth:1.f];
    
    
    self.lineChart.isDashDotBaseLine = NO;
    self.lineChart.yAxisRange = NSMakeRange(0, 100);
    self.lineChart.coordinateColor = [UIColor colorWithRed:0.722 green:0.200 blue:0.631 alpha:1.00];
    self.lineChart.xAxisTitles = xtitles;
    self.lineChart.yAxisTitles = ytitles;
    self.lineChart.yAxisValues = yValues;
    self.lineChart.baseLineColors = baseLineColors;
    self.lineChart.yAxisTitleOffset = 40;
    self.lineChart.isYaxixTitleSameLevelWithBaseline = NO;
    
    self.lineChart.isCurveLine = YES;
    self.lineChart.isGradientRamp = YES;
    self.lineChart.chartData = [NSMutableArray arrayWithObjects:data,data1, nil];
    
    [self.lineChart drawChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end










