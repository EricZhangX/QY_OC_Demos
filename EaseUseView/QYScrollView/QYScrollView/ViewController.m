//
//  ViewController.m
//  QYScrollView
//
//  Created by 张庆玉 on 2017/3/13.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "ViewController.h"
#import "QYRefreshView.h"

@interface ViewController ()<UIScrollViewDelegate,QYRefreshViewDelegate>
{
    QYRefreshView* _PullLeftRefreshView;
    BOOL _reloading;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScroolView];
}


- (void)setUpScroolView {
    [self.view addSubview:self.scrollView];
    _PullLeftRefreshView = [[QYRefreshView alloc] initWithScrollView:self.scrollView refreshDirection:RefreshDirectionLeft];
//    [_PullLeftRefreshView setTitle:@"左拉加载更多" forState:RefreshStateNormal];
//    [_PullLeftRefreshView setTitle:@"加载中..." forState:RefreshStateLoading];
//    [_PullLeftRefreshView setTitle:@"松开加载更多" forState:RefreshStatePulling];
    
    _PullLeftRefreshView.delegate = self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor grayColor];
        _scrollView.scrollEnabled = YES;
        _scrollView.contentSize = CGSizeMake(2*self.view.frame.size.width, self.view.frame.size.height);
    }
    return  _scrollView;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_PullLeftRefreshView qyRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_PullLeftRefreshView qyRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - QYRefreshViewDelegate
- (void)refreshDone {
    _reloading = NO;
    [_PullLeftRefreshView qyRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
    NSLog(@"刷新完成.............");
}

- (void)qyRefreshViewDidTriggerRefresh:(QYRefreshView *)view {
    NSLog(@"开始刷新.............");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _reloading = NO;
        [_PullLeftRefreshView qyRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
    });
    //[self performSelector:@selector(refreshDone) withObject:nil afterDelay:1.0f];
}

- (BOOL)qyRefreshViewDataSourceIsLoading:(QYRefreshView *)view {
    return _reloading;
}









@end
