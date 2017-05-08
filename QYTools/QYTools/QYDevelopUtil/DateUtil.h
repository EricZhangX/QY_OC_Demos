//
//  DateUtil.h
//  QYTools
//
//  Created by 张庆玉 on 2017/5/8.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DateFormatNormal        @"yyyy-MM-dd HH:mm:ss"
#define DateFormatNoSeporate    @"yyyyMMddHHmmss"
#define DateFormatNoTime        @"yyyy-MM-dd"
#define DateFormatNoDate        @"HH:mm:ss"

@interface DateUtil : NSObject

/**
 获取时间戳
 
 @param date 日期
 @return 时间戳
 */
+ (NSTimeInterval)getTimeStampWithDate:(NSDate *)date;

/**
 获取格式化日期
 
 @param date 日期
 @param format 日期格式，如：yyyy-MM-dd HH:mm:ss
 @return 格式化的日期字符串
 */
+ (NSString *)getDateStrWithDate:(NSDate *)date format:(NSString *)format;

/**
 获取日期
 
 @param dateStr 日期字符串
 @param format 日期格式，如：yyyy-MM-dd HH:mm:ss
 @return 日期
 */
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr format:(NSString *)format;

/**
 转换某天的格式

 @param sourceDateStr 带转换的格式化日期
 @param sourceFormat 带转换日期的格式
 @param targetFormat 将要转换成的日期格式
 @return 转换后的格式化日期
 */
+ (NSString *)getDateStrWithSourceDateStr:(NSString *)sourceDateStr sourceFormat:(NSString *)sourceFormat targetFormat:(NSString *)targetFormat;

/**
 将指定日期转换成农历

 @param date 指定的日期
 @return 转换后的日期
 */
+ (NSString *)getTraditionalDateWithDate:(NSDate *)date;


#pragma mark -

/**
 *  获取某天的年份
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSInteger)getYearWithDate:(NSDate *)date;

/**
 *  获取某天的季度
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSInteger)getQuarterWithDate:(NSDate *)date;

/**
 *  获取某天的月份
 *
 *  @param date date description
 *
 *  @return return value description
 */
+ (NSInteger)getMonthWithDate:(NSDate *)date;

/**
 *  获取某天的星期
 *
 *  @param date date description
 *
 *             周日   周一  周二  周三  周四  周五  周六
 *  @return     1      2    3    4     5    6    7
 */
+ (NSInteger)getWeekDayWithDate:(NSDate *)date;

/**
 获取某一日期之前的七天的日期数组

 @param date 日期
 @return 某日之前的七天的日期
 */
+ (NSArray<NSDate *> *)getLastSevenDaysOfTheDate:(NSDate *)date;

/**
 获取某一日期所在的星期的日期数组

 @param date 日期
 @return 某日所在的星期的日期数组
 */
+ (NSArray<NSDate *> *)getWeekDaysOfTheDate:(NSDate *)date;


@end





















