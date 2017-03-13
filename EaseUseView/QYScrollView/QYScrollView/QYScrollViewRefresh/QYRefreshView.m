//
//  QYRefreshView.m
//  QYScrollView
//
//  Created by 张庆玉 on 2017/3/13.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "QYRefreshView.h"

@interface QYRefreshView ()
{
    
    RefreshState _state;
    RefreshDirection _direction;
    
    UIScrollView* _scrollView;
    
    BOOL _pagingEnabled;
    UIActivityIndicatorView *_activityView;
}
/** 显示上次刷新时间的标签 */
@property (weak, nonatomic) UILabel *updatedTimeLabel;
/** 上次刷新时间 */
@property (strong, nonatomic) NSDate *updatedTime;
/** 显示状态文字的标签 */
@property (weak, nonatomic) UILabel *stateLabel;
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;

@end

@implementation QYRefreshView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        

        [self addSubview:self.updatedTimeLabel];
        [self addSubview:self.stateLabel];
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        view.frame = CGRectMake(frame.size.width*0.5-10.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
        [self addSubview:view];
        _activityView = view;
        
        [self setState:RefreshStateNormal];
    }
    
    return self;
}

- (void)setState:(RefreshState)aState{
    BOOL refresh = (_direction == RefreshDirectionDown||_direction == RefreshDirectionRight);
    NSString *stateTitle = @"";
    stateTitle = _stateTitles[@(aState)];
    switch (aState) {
        case RefreshStatePulling:
            if (refresh) {
                self.stateLabel.text = NSLocalizedString(stateTitle, @"下拉/左拉刷新的title");
            } else {
                self.stateLabel.text = NSLocalizedString(stateTitle, @"上拉/右拉加载的title");
            }
            break;
        case RefreshStateNormal:
            if (refresh) {
                self.stateLabel.text = NSLocalizedString(stateTitle, @"");
            } else {
                self.stateLabel.text = NSLocalizedString(stateTitle, @"");
            }
            
            [_activityView stopAnimating];
            [self refreshLastUpdatedDate];
            break;
        case RefreshStateLoading:
            self.stateLabel.text = NSLocalizedString(stateTitle, @"加载中...");
            [_activityView startAnimating];
            break;
        default:
            break;
    }
    
    _state = aState;
}

- (id)initWithScrollView:(UIScrollView* )scrollView refreshDirection:(RefreshDirection)direction {
    CGSize size = scrollView.frame.size;
    CGPoint center = CGPointZero;
    CGFloat degrees = 0.0f;
    
    _direction = direction;
    _scrollView = scrollView;
    
    switch (direction) {
        case RefreshDirectionDown:
            center = CGPointMake(size.width/2, 0.0f-size.height/2);
            degrees = 0.0f;
            break;
        case RefreshDirectionUp:
            center = CGPointMake(size.width/2, scrollView.contentSize.height+size.height/2);
            degrees = 180.0f;
            break;
        case RefreshDirectionRight:
            center = CGPointMake(0.0f-size.width/2, size.height/2);
            size = CGSizeMake(size.height, size.width);
            degrees = -90.0f;
            break;
        case RefreshDirectionLeft:
            center = CGPointMake(scrollView.contentSize.width+size.width/2, size.height/2);
            size = CGSizeMake(size.height, size.width);
            degrees = 90.0f;
            break;
        default:
            break;
    }
    self = [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        self.transform = CGAffineTransformMakeRotation((degrees * M_PI) / 180.0f);
        self.center = center;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        if (RefreshDirectionUp == direction) {
            self.updatedTimeLabel.transform = CGAffineTransformMakeRotation((degrees * M_PI) / 180.0f);
            self.stateLabel.transform = CGAffineTransformMakeRotation((degrees * M_PI) / 180.0f);
        }
        [scrollView addSubview:self];
    }
    return self;
}

- (void)adjustPosition {
    CGSize size = _scrollView.frame.size;
    CGPoint center = CGPointZero;
    
    switch (_direction) {
        case RefreshDirectionDown:
            center = CGPointMake(size.width/2, 0.0f-size.height/2);
            break;
        case RefreshDirectionUp:
            center = CGPointMake(size.width/2, _scrollView.contentSize.height+size.height/2);
            break;
        case RefreshDirectionRight:
            center = CGPointMake(0.0f-size.width/2, size.height/2);
            break;
        case RefreshDirectionLeft:
            center = CGPointMake(_scrollView.contentSize.width+size.width/2, size.height/2);
            break;
        default:
            break;
    }
    
    self.center = center;
}

- (void)refreshLastUpdatedDate {
    if ([_delegate respondsToSelector:@selector(qyRefreshViewDataSourceLastUpdated:)]) {
        
        NSDate *date = [_delegate qyRefreshViewDataSourceLastUpdated:self];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setAMSymbol:@"AM"];
        [formatter setPMSymbol:@"PM"];
        [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss"];
        self.updatedTimeLabel.text = [NSString stringWithFormat:@"上次刷新: %@", [formatter stringFromDate:date]];
        [[NSUserDefaults standardUserDefaults] setObject:self.updatedTimeLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        self.updatedTimeLabel.text = nil;
    }
}

- (void)qyRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if (_state == RefreshStateLoading) {
        switch (_direction) {
            case RefreshDirectionDown: {
                CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
                offset = MIN(offset, 60);
                scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
                break;
            }
            case RefreshDirectionUp: {
                CGFloat offset = MAX(scrollView.frame.size.height+scrollView.contentOffset.y-scrollView.contentSize.height, 0);
                offset = MIN(offset, 60);
                scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, offset, 0.0f);
                break;
            }
            case RefreshDirectionRight: {
                CGFloat offset = MAX(scrollView.contentOffset.x * -1, 0);
                offset = MIN(offset, 60);
                scrollView.contentInset = UIEdgeInsetsMake(0.0f, offset, 0.0f, 0.0f);
                break;
            }
            case RefreshDirectionLeft: {
                CGFloat offset = MAX(scrollView.frame.size.width+scrollView.contentOffset.x-scrollView.contentSize.width, 0);
                offset = MIN(offset, 60);
                scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, offset);
                break;
            }
            default:
                break;
        }
        
    } else if (scrollView.isDragging) {
        
        BOOL _loading = NO;
        if ([_delegate respondsToSelector:@selector(qyRefreshViewDataSourceIsLoading:)]) {
            _loading = [_delegate qyRefreshViewDataSourceIsLoading:self];
        }
        
        BOOL pullingCondition = NO;
        BOOL normalCondition = NO;
        switch (_direction) {
            case RefreshDirectionDown:
                pullingCondition = (scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f);
                normalCondition = (scrollView.contentOffset.y < -65.0f);
                break;
            case RefreshDirectionUp: {
                CGFloat y = scrollView.contentOffset.y+scrollView.frame.size.height;
                pullingCondition = ((y < (scrollView.contentSize.height+65.0f)) && (y > scrollView.contentSize.height));
                normalCondition = (y > (scrollView.contentSize.height+65.0f));
                break;
            }
            case RefreshDirectionRight:
                pullingCondition = (scrollView.contentOffset.x > -65.0f && scrollView.contentOffset.x < 0.0f);
                normalCondition = (scrollView.contentOffset.x < -65.0f);
                break;
            case RefreshDirectionLeft: {
                CGFloat x = scrollView.contentOffset.x+scrollView.frame.size.width;
                pullingCondition = ((x < (scrollView.contentSize.width+65.0f)) && (x > scrollView.contentSize.width));
                normalCondition = (x > (scrollView.contentSize.width+65.0f));
                break;
            }
            default:
                break;
        }
        
        if (_state == RefreshStatePulling && pullingCondition && !_loading) {
            [self setState:RefreshStateNormal];
        } else if (_state == RefreshStateNormal && normalCondition && !_loading) {
            [self setState:RefreshStatePulling];
        }
        
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    }
}

- (void)qyRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(qyRefreshViewDataSourceIsLoading:)]) {
        _loading = [_delegate qyRefreshViewDataSourceIsLoading:self];
    }
    
    BOOL condition = NO;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    switch (_direction) {
        case RefreshDirectionDown:
            condition = (scrollView.contentOffset.y <= - 65.0f);
            insets = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
            break;
        case RefreshDirectionUp: {
            CGFloat y = scrollView.contentOffset.y+scrollView.frame.size.height-scrollView.contentSize.height;
            condition = (y > 65.0f);
            insets = UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f);
            break;
        }
        case RefreshDirectionRight:
            condition = (scrollView.contentOffset.x <= - 65.0f);
            insets = UIEdgeInsetsMake(0.0f, 60.0f, 0.0f, 0.0f);
            break;
        case RefreshDirectionLeft: {
            CGFloat x = scrollView.contentOffset.x+scrollView.frame.size.width-scrollView.contentSize.width;
            condition = (x > 65.0f);
            insets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 60.0f);
            break;
        }
        default:
            break;
    }
    
    if (condition && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(qyRefreshViewDidTriggerRefresh:)]) {
            [_delegate qyRefreshViewDidTriggerRefresh:self];
        }
        
        _pagingEnabled = scrollView.pagingEnabled;
        scrollView.pagingEnabled = NO;
        
        [self setState:RefreshStateLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = insets;
        [UIView commitAnimations];
        
    }
}

- (void)qyRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];
    scrollView.pagingEnabled = _pagingEnabled;
    [self setState:RefreshStateNormal];
}

- (void)setTitle:(NSString *)title forState:(RefreshState)state {
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    // 刷新当前状态的文字
    self.stateLabel.text = self.stateTitles[@(_state)];
}


#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
        stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        stateLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        stateLabel.textColor = [UIColor whiteColor];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)updatedTimeLabel {
    if (!_updatedTimeLabel) {
        UILabel *updatedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
        updatedTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        updatedTimeLabel.font = [UIFont systemFontOfSize:12.0f];
        updatedTimeLabel.textColor = [UIColor whiteColor];
        updatedTimeLabel.backgroundColor = [UIColor clearColor];
        updatedTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _updatedTimeLabel;
}

@end













