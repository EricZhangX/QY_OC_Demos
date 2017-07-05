//
//  QYCollectionViewCell.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/4.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYCollectionViewCell.h"

@implementation CardItemModel


- (instancetype)initWithType:(ModuleType)type Title:(NSString *)title TitleImg:(NSString *)titleImg CenterImg:(NSString *)centerImg {
    self = [super init];
    if (self) {
        self.type = type;
        self.title = title;
        self.titleImg = titleImg;
        self.centerImg = centerImg;
    }
    return self;
}

@end

@implementation QYCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUpUIByModel:(CardItemModel *)model {
    switch (model.type) {
        case ModuleTypeBloodPressure: {
            [self checkShowItemCenterImg:YES BluetoothShopImg:YES];
            self.systolicPressureLabel.text = [NSString stringWithFormat:@"%@",@(model.systolicPressure)];
            self.diastolicPressureLabel.text = [NSString stringWithFormat:@"%@",@(model.diastolicPressure)];
        }
            break;
        case ModuleTypeWeight: {
            [self checkShowItemCenterImg:NO BluetoothShopImg:NO];
        }
            break;
        case ModuleTypeSport: {
            [self checkShowItemCenterImg:NO BluetoothShopImg:YES];
        }
            break;
        case ModuleTypeHeartRate: {
            [self checkShowItemCenterImg:NO BluetoothShopImg:NO];
        }
            break;
        default:
            break;
    }
    
    self.titleImgView.image = [UIImage imageNamed:model.titleImg];
    self.titleLabel.text = model.title;
    self.centerImgView.image = [UIImage imageNamed:model.centerImg];
}

- (void)checkShowItemCenterImg:(BOOL)centerFlag BluetoothShopImg:(BOOL)bsFlag {
    self.centerImgView.hidden = centerFlag;
    self.leftBaseView.hidden = self.rightBaseView.hidden = !centerFlag;
    self.bleImgView.hidden = self.shopImgView.hidden = bsFlag;
}

@end























