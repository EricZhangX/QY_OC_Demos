//
//  QYPickerView.h
//  CustomerPickerView
//
//  Created by 张庆玉 on 2017/2/20.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYPickerView;

@protocol QYPickerViewDelegate <NSObject>

@optional
- (void)picker:(QYPickerView *)qYpickerView didSelectedValue:(NSString *)valueStr andIndexpath:(NSIndexPath *)indexpath;

@end

@interface QYPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic ,weak) id<QYPickerViewDelegate> delegate;

@property (nonatomic, strong) NSArray<NSString*> *dataSource;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (instancetype)initWithFrame:(CGRect)frame andSelectedRow:(NSInteger)row;


@end
