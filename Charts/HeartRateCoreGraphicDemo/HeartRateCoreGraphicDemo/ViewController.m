//
//  ViewController.m
//  HeartRateCoreGraphicDemo
//
//  Created by 张庆玉 on 2017/2/17.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "ViewController.h"
#import "HeartRateCurveView.h"
#import "PointContainer.h"

@interface ViewController ()

@property (nonatomic , strong) NSArray *dataSource;
@property (nonatomic , strong) HeartRateCurveView *refreshMoniterView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"心电图";
    
    [self.view addSubview:self.refreshMoniterView];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    void (^createData)(void) = ^{
        NSString *tempString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        
        NSMutableArray *tempData = [[tempString componentsSeparatedByString:@","] mutableCopy];
        [tempData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *tempDataa = @(-[obj integerValue] + 2048);
            [tempData replaceObjectAtIndex:idx withObject:tempDataa];
        }];
        self.dataSource = tempData;
        [self createWorkDataSourceWithTimeInterval:0.024];
    };
    createData();
}


- (void)createWorkDataSourceWithTimeInterval:(NSTimeInterval )timeInterval {
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerRefresnFun) userInfo:nil repeats:YES];
}

- (void)createAddWorkDataSourceWithTimeInterval:(NSTimeInterval )timeInterval {
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerInsertDataFun) userInfo:nil repeats:YES];
}

//刷新方式绘制
- (void)timerRefresnFun {
    for (int i=0; i<5; i++) {
        [[PointContainer sharedContainer] addPointAsRefreshChangeform:[self bubbleRefreshPoint]];
    }
    NSLog(@"---%ld",[PointContainer sharedContainer].numberOfRefreshElements);
    [self.refreshMoniterView fireDrawingWithPoints:[PointContainer sharedContainer].refreshPointContainer pointsCount:[PointContainer sharedContainer].numberOfRefreshElements];
}

- (void)timerInsertDataFun {
    
}

#pragma mark -
#pragma mark - DataSource

- (CGPoint)bubbleRefreshPoint {
    static NSInteger dataSourceCounterIndex = -1;
    dataSourceCounterIndex ++;
    dataSourceCounterIndex %= [self.dataSource count];
    
    NSInteger pixelPerPoint = 1;
    static NSInteger xCoordinateInMoniter = 0;
    
    CGPoint targetPointToAdd = (CGPoint){xCoordinateInMoniter,[self.dataSource[dataSourceCounterIndex] integerValue] * 0.5 + 120};
    
    xCoordinateInMoniter += pixelPerPoint;
    xCoordinateInMoniter %= kMaxContainerCapacity;
    
    //NSLog(@"吐出来的点:%@",NSStringFromCGPoint(targetPointToAdd));
    return targetPointToAdd;
}

- (HeartRateCurveView *)refreshMoniterView {
    if (!_refreshMoniterView) {
        NSInteger i = CGRectGetWidth(self.view.frame);
        NSInteger j = i%25;
        CGFloat xOffset = j/2;
        CGFloat width = CGRectGetWidth(self.view.frame) - 2 * xOffset;
        _refreshMoniterView = [[HeartRateCurveView alloc] initWithFrame:CGRectMake(xOffset, 60, width, 250)];
        _refreshMoniterView.backgroundColor = [UIColor blackColor];
    }
    return _refreshMoniterView;
}


@end
