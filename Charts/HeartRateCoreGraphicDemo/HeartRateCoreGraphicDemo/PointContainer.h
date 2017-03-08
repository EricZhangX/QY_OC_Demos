//
//  PointContainer.h
//  HeartRateCoreGraphicDemo
//
//  Created by 张庆玉 on 2017/2/17.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define SqureWidth 25
#define kMaxContainerCapacity (NSInteger)Main_Screen_Width - (NSInteger)Main_Screen_Width%SqureWidth

@interface PointContainer : NSObject

@property (nonatomic ,readonly) NSInteger numberOfRefreshElements;
@property (nonatomic ,readonly) CGPoint *refreshPointContainer;

+ (PointContainer *)sharedContainer;

//刷新变换
- (void)addPointAsRefreshChangeform:(CGPoint)point;

@end
