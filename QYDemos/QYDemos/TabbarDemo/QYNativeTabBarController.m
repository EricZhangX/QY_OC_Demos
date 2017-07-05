//
//  QYNativeTabBarController.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/6/27.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYNativeTabBarController.h"

@interface QYNativeTabBarController ()

@end

@implementation QYNativeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标签栏文字和图片的颜色
    self.tabBar.tintColor = [UIColor orangeColor];
    
    //设置标签栏的颜色
    self.tabBar.barTintColor = [UIColor blackColor];
    
    //设置标签栏风格(默认高度49)
    self.tabBar.barStyle = UIBarStyleBlack;
    
    //设置初始状态选中的下标
    self.selectedIndex = 1;
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
