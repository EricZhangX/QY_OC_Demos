//
//  HRItemFlowView.h
//  MWell_Health_PlatForm_IOS
//
//  Created by 张庆玉 on 2017/4/25.
//  Copyright © 2017年 midea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface HRItemFlowView : UIView

/**
 *  存放需要显示的Item
 */
@property (nonatomic, strong) NSMutableArray *viewList;

/**
 *  通过传入一组按钮初始化HRItemFlowView
 *
 *  @param viewList 按钮数组
 *
 *  @return HRItemFlowView对象
 */
- (instancetype)initWithViewList:(NSMutableArray *)viewList;


@end
