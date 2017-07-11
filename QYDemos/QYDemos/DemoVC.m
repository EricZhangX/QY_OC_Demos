//
//  DemoVC.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/7.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "DemoVC.h"

#import "QYAnimateIndicatorView.h"

@interface DemoVC ()

@end

@implementation DemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QYAnimateIndicatorView *activityIndicatorView = [[QYAnimateIndicatorView alloc] initWithType:QYAnimateIndicatorTypeLineScalePulseOut tintColor:[UIColor whiteColor] size:CGSizeMake(160.f, 5.f)];
    
    activityIndicatorView.frame = CGRectMake(20, 110, 300, 100);
    
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
