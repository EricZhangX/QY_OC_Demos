//
//  ZQYLineChart.h
//  ZQYChartDemos
//
//  Created by zhangqingyu on 16/1/20.
//  Copyright © 2016年 张庆玉. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TagNum 5500

//Y轴标识的位置
typedef enum {
    Left    = 0,
    Right,
    Both
}YmarkPosition;

//Y轴标识的类型(数字,时间)
typedef enum {
    Time    = 0,
    Number  = 1
}YaxisTitleType;


@class ZQYLineChart;

#pragma mark - Delegate functions
@protocol ZQYLineChartDelegate <NSObject>

@optional
// X轴元素被点击时
- (void)XaxisItemSeleted:(NSInteger) index;
@end

@interface ZQYLineChart : UIView

/**
 * 图表数据源
 * 可存放单个或多个数组,绘制多条曲线.
 * YmarkPosition = Both 时,默认左侧图标数组为index=0的数组元素,右侧图标数组为index=1的数组元素.
 * 例:  chartDatas = @[@[@"10",@"20",@"30"],@[@"43",@"24",@"33"]]
 *                      leftDataSourceArr     rightDataSourceArr
 * @[@[@(10),@(20)],@[@(33),@(45)]]
 */
@property (nonatomic, strong) NSArray *chartDatas;

//底图是不是虚线
@property (nonatomic, assign) BOOL isDashDotLine;
//Y轴标识位置(左,右,中)
@property (nonatomic, assign) YmarkPosition ymarkPosition;
//Y轴数量
@property (nonatomic, assign) NSInteger YaxisCount;
//Y轴取值范围(左)
@property (nonatomic, assign) NSRange LeftYaxisRange;
//Y轴取值类型(左)
@property (nonatomic, assign) YaxisTitleType LeftYaxisType;
//Y轴取值范围(右)
@property (nonatomic, assign) NSRange RightYaxisRange;
//Y轴取值类型(右)
@property (nonatomic, assign) YaxisTitleType RightYaxisType;
//X轴数组
@property (nonatomic, strong) NSArray *XaxisTitlesArr;

//颜色
//Y轴字体颜色
@property (nonatomic, strong) UIColor *YaxisTitleColor;
//X轴字体颜色
@property (nonatomic, strong) UIColor *XaxisTitleColor;
//X轴被选中的字体颜色
@property (nonatomic, strong) UIColor *XaxisSelectedTitleColor;
//图表底图线条颜色
@property (nonatomic, strong) UIColor *chartBaseLineColor;
//图表颜色
@property (nonatomic, strong) NSArray *chartLineColorsArr;

//尺寸
//Y轴Title的宽度
@property (nonatomic, assign) CGFloat YaxisTitleWidth;
//X轴Title的高度
@property (nonatomic, assign) CGFloat XaxisTitleHeight;
//底图线条的宽度
@property (nonatomic, assign) CGFloat chartBaseLineWidth;
//图表线条的宽度
@property (nonatomic, assign) CGFloat chartLineWidth;

// 交互设置
// 可否点击
@property (nonatomic, assign) BOOL isEnableButton;
// 选定的按钮Index
@property (nonatomic, assign) NSInteger seletedIndex;

//代理
@property (nonatomic, weak) id <ZQYLineChartDelegate> delegate;

/**
 * 初始化方法
 */
- (instancetype)initWithChartDatas:(NSArray *)chartDatas frame:(CGRect)frame options:(NSDictionary *)options;
//选择X轴某一个item
- (void)selectItem:(NSInteger)index;

// 根据数据源重新加载
- (void)reloadWithDatas:(NSArray *)datasArr andSeleteItem:(NSInteger) index;

extern NSString * const ZQY_isDashDotLine;
extern NSString * const ZQY_ymarkPosition;
extern NSString * const ZQY_YaxisCount;
extern NSString * const ZQY_LeftYaxisRange;
extern NSString * const ZQY_LeftYaxisType;
extern NSString * const ZQY_RightYaxisRange;
extern NSString * const ZQY_RightYaxisType;
extern NSString * const ZQY_XaxisTitlesArr;

extern NSString * const ZQY_YaxisTitleColor;
extern NSString * const ZQY_XaxisTitleColor;
extern NSString * const ZQY_XaxisSelectedTitleColor;
extern NSString * const ZQY_chartBaseLineColor;
extern NSString * const ZQY_chartLineColorsArr;

extern NSString * const ZQY_YaxisTitleWidth;
extern NSString * const ZQY_XaxisTitleHeight;
extern NSString * const ZQY_chartBaseLineWidth;
extern NSString * const ZQY_chartLineWidth;

extern NSString * const ZQY_isEnableButton;


@end
