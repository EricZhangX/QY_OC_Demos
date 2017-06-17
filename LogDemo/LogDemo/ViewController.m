//
//  ViewController.m
//  LogDemo
//
//  Created by 张庆玉 on 02/06/2017.
//  Copyright © 2017 Qingyu. All rights reserved.
//

#import "ViewController.h"
#import "CocoaLumberjack.h"
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DDLogWarn(@"hahahhaha");
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
