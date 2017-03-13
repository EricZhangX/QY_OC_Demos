//
//  QYRefreshView.h
//  QYScrollView
//
//  Created by 张庆玉 on 2017/3/13.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, RefreshDirection) {
    RefreshDirectionDown = 0,
    RefreshDirectionUp,
    RefreshDirectionRight,
    RefreshDirectionLeft,
};

typedef NS_ENUM(NSInteger, RefreshState) {
    RefreshStatePulling = 0,
    RefreshStateNormal,
    RefreshStateLoading,
};

@class QYRefreshView;
@protocol QYRefreshViewDelegate <NSObject>

- (void)qyRefreshViewDidTriggerRefresh:(QYRefreshView*)view;
- (BOOL)qyRefreshViewDataSourceIsLoading:(QYRefreshView*)view;

@optional
- (NSDate*)qyRefreshViewDataSourceLastUpdated:(QYRefreshView*)view;

@end



@interface QYRefreshView : UIView

@property (nonatomic, weak) id<QYRefreshViewDelegate> delegate;

- (id)initWithScrollView:(UIScrollView* )scrollView refreshDirection:(RefreshDirection)direction;
- (void)adjustPosition;

- (void)refreshLastUpdatedDate;
- (void)qyRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)qyRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)qyRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)setTitle:(NSString *)title forState:(RefreshState)state;

@end










