//
//  QYPickerView.m
//  CustomerPickerView
//
//  Created by 张庆玉 on 2017/2/20.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "QYPickerView.h"

@interface QYPickerView ()
{
    NSInteger selectedRow;
}
@property (strong, nonatomic)  UIPickerView *pickeview;

@end
@implementation QYPickerView

- (instancetype)initWithFrame:(CGRect)frame andSelectedRow:(NSInteger)row {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        [self setUpButtons];
        [self addSubview:self.pickeview];
        selectedRow = row;
        [self.pickeview selectRow:row inComponent:0 animated:YES];
        
    }
    return self;
}

/**
 *  确定--取消按钮
 */
- (void)setUpButtons {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-240, self.bounds.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:0.494 green:0.498 blue:0.494 alpha:1.00] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelButton];
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-70, 0, 70, 40)];
    [confirmButton setTitleColor:[UIColor colorWithRed:0.212 green:0.686 blue:0.984 alpha:1.00] forState:UIControlStateNormal];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:view];
    
}
/**
 *  取消按钮回调
 */
- (void)cancelButtonClicked:(id)sender {
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 *  确定按钮回调
 */
- (void)confirmButtonClicked:(id)sender {
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if ([self.delegate respondsToSelector:@selector(picker:didSelectedValue:andIndexpath:)]) {
        NSString *str = nil;
        if (!self.dataSource.count) {
            return;
        } else if (self.dataSource.count > selectedRow) {
            str = self.dataSource[selectedRow];
        } else {
            str = self.dataSource[0];
        }
        if (!self.indexPath) {
            self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        }
        [self.delegate picker:self didSelectedValue:str andIndexpath:self.indexPath];
    }
}

- (UIPickerView *)pickeview {
    if (!_pickeview) {
        _pickeview = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-250, self.bounds.size.width, 250)];
        _pickeview.delegate = self;
        _pickeview.dataSource = self;
        _pickeview.backgroundColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00];
    }
    return _pickeview;
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *itemLabel = nil;
    itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, 26)];
    itemLabel.textAlignment = NSTextAlignmentCenter;
    NSString *showStr = self.dataSource[row];
    itemLabel.text = showStr;
    
    itemLabel.font = [UIFont systemFontOfSize:24];
    itemLabel.textColor = [UIColor colorWithRed:0.196 green:0.196 blue:0.196 alpha:1.00];
    itemLabel.backgroundColor = [UIColor clearColor];
    return itemLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.0;
}

#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedRow = row;
}


@end
