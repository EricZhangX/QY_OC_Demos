//
//  QYCollectionViewCell.h
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/4.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ModuleType) {
    ModuleTypeBloodPressure = 0,
    ModuleTypeWeight,
    ModuleTypeSport,
    ModuleTypeHeartRate
};

@interface CardItemModel : NSObject

@property (nonatomic, assign) ModuleType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleImg;
@property (nonatomic, strong) NSString *centerImg;

@property (nonatomic, assign) NSInteger systolicPressure;
@property (nonatomic, assign) NSInteger diastolicPressure;


- (instancetype)initWithType:(ModuleType)type Title:(NSString *)title TitleImg:(NSString *)titleImg CenterImg:(NSString *)centerImg;

@end

@interface QYCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bleImgView;
@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImgView;
@property (weak, nonatomic) IBOutlet UIView *leftBaseView;
@property (weak, nonatomic) IBOutlet UILabel *systolicPressureLabel;
@property (weak, nonatomic) IBOutlet UIView *rightBaseView;
@property (weak, nonatomic) IBOutlet UILabel *diastolicPressureLabel;

- (void)setUpUIByModel:(CardItemModel *)model;

@end














