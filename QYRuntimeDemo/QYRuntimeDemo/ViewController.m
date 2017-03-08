//
//  ViewController.m
//  QYRuntimeDemo
//
//  Created by 张庆玉 on 2017/3/7.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "ViewController.h"

#import "Cat.h"

#import "Aspects.h"
#import "CountTool.h"
#import "NSObject+hook.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *clickCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *methodReplaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyAddLabel;

@property (nonatomic, strong) Cat *cat;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateClickCount];
    self.cat = [Cat new];
    self.methodReplaceLabel.text = [self.cat say];
}

- (IBAction)replaceMethodBtnClicked:(id)sender {
    [self updateClickCount];
    [Cat aspect_hookSelector:@selector(say) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info) {
        NSInvocation *invocation = info.originalInvocation;
        NSString *sayStr = @"汪汪...";
        [invocation setReturnValue:&sayStr];
    } error:nil];
    
    self.methodReplaceLabel.text = [self.cat say];
}

- (IBAction)addPropertyBtnClicked:(id)sender {
    [self updateClickCount];
    NSObject *obj = [NSObject new];
    obj.hookTitle = @"hook";
    self.propertyAddLabel.text = [NSString stringWithFormat:@"addedProperty:%@",obj.hookTitle];
}

- (void)updateClickCount {
    NSInteger count = [CountTool getClickCount];
    self.clickCountLabel.text = [NSString stringWithFormat:@"%ld",count];
}

@end
