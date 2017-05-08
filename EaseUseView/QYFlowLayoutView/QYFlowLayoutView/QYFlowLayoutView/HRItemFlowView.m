//
//  HRItemFlowView.m
//  MWell_Health_PlatForm_IOS
//
//  Created by 张庆玉 on 2017/4/25.
//  Copyright © 2017年 midea. All rights reserved.
//

#import "HRItemFlowView.h"


@implementation HRItemFlowView

- (instancetype)initWithViewList:(NSMutableArray *)viewList {
    self = [super init];
    if (self) {
        self.viewList = viewList;
    }
    return self;
}

- (void)setViewList:(NSMutableArray *)viewList {
    _viewList = viewList;
    for (UIView *view in viewList) {
        [self addSubview:view];
        [self caculateLayout];
    }
}

- (void)caculateLayout {
    CGFloat margin = 10;
    
    // 存放每行的第一个Button
    NSMutableArray *rowFirstButtons = [NSMutableArray array];
    
    // 对第一个Button进行设置
    UIButton *button0 = self.viewList[0];
    button0.x = margin;
    button0.y = margin;
    [rowFirstButtons addObject:self.viewList[0]];
    
    // 对其他Button进行设置
    int row = 0;
    for (int i = 1; i < self.viewList.count; i++) {
        UIButton *button = self.viewList[i];
        
        int sumWidth = 0;
        int start = (int)[self.viewList indexOfObject:rowFirstButtons[row]];
        for (int j = start; j <= i; j++) {
            UIButton *button = self.viewList[j];
            sumWidth += (button.width + margin);
        }
        sumWidth += 10;
        
        UIButton *lastButton = self.viewList[i - 1];
        if (sumWidth >= self.width) {
            button.x = margin;
            button.y = lastButton.y + margin + button.height;
            [rowFirstButtons addObject:button];
            row ++;
        } else {
            button.x = sumWidth - margin - button.width;
            button.y = lastButton.y;
        }
        NSLog(@"frame = %.2f,%.2f,%.2f,%.2f",button.x,button.y,button.width,button.height);
    }
    
    
    UIButton *lastButton = self.viewList.lastObject;
    self.height = CGRectGetMaxY(lastButton.frame) + 10;
}

//- (void)layoutSubviews {
//    
//    CGFloat margin = 10;
//    
//    // 存放每行的第一个Button
//    NSMutableArray *rowFirstButtons = [NSMutableArray array];
//    
//    // 对第一个Button进行设置
//    UIButton *button0 = self.viewList[0];
//    button0.x = margin;
//    button0.y = margin;
//    [rowFirstButtons addObject:self.viewList[0]];
//    
//    // 对其他Button进行设置
//    int row = 0;
//    for (int i = 1; i < self.viewList.count; i++) {
//        UIButton *button = self.viewList[i];
//        
//        int sumWidth = 0;
//        int start = (int)[self.viewList indexOfObject:rowFirstButtons[row]];
//        for (int j = start; j <= i; j++) {
//            UIButton *button = self.viewList[j];
//            sumWidth += (button.width + margin);
//        }
//        sumWidth += 10;
//        
//        UIButton *lastButton = self.viewList[i - 1];
//        if (sumWidth >= self.width) {
//            button.x = margin;
//            button.y = lastButton.y + margin + button.height;
//            [rowFirstButtons addObject:button];
//            row ++;
//        } else {
//            button.x = sumWidth - margin - button.width;
//            button.y = lastButton.y;
//        }
//        NSLog(@"frame = %.2f,%.2f,%.2f,%.2f",button.x,button.y,button.width,button.height);
//    }
//    
//    
//    UIButton *lastButton = self.viewList.lastObject;
//    self.height = CGRectGetMaxY(lastButton.frame) + 10;
//    
//}


@end
