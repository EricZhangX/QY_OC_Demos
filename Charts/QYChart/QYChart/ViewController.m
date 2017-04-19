//
//  ViewController.m
//  QYChart
//
//  Created by 张庆玉 on 2017/4/14.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "ViewController.h"
#import "QYBarChart.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet QYBarChart *barChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBarChart];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end










