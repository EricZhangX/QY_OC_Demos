//
//  ViewController.m
//  QYFlowLayoutView
//
//  Created by 张庆玉 on 2017/4/26.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "ViewController.h"
#import "HRItemFlowView.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *headerView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) HRItemFlowView *flowButtonView;
@property (nonatomic, strong) NSMutableArray *buttonList;

@end

@implementation ViewController

- (NSMutableArray *)buttonList {
    if (_buttonList == nil) {
        _buttonList = [NSMutableArray array];
        for (int i = 0; i < 18; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.width = 60;
            label.height = 33;
            label.backgroundColor = [UIColor yellowColor];
            
            label.text = [NSString stringWithFormat:@"按钮%d", i];
            if (i == 0 || i == 10) {
                label.width = 80;
                label.height = 33;
                label.backgroundColor = [UIColor colorWithRed:102/255.0 green:180/255.0 blue:180/255.0 alpha:1];
            }
            if (i == 15 || i == 9 || i == 6) {
                label.width = 100;
                label.height = 33;
                label.backgroundColor = [UIColor colorWithRed:255/255.0 green:196/255.0 blue:102/255.0 alpha:1];
            }
            [_buttonList addObject:label];
        }
    }
    return _buttonList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFlowButtonView];
    NSLog(@"--/333/%.2f",self.flowButtonView.height);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--/444/%.2f",self.flowButtonView.height);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--/555/%.2f",self.flowButtonView.height);
}

- (void)addFlowButtonView {
    
    // 实例化一个CFFlowButtonView对象
    HRItemFlowView *flowButtonView = [[HRItemFlowView alloc] initWithFrame:CGRectMake(20, 10, 300, 10)];
    NSLog(@"--/--/%.2f",flowButtonView.height);
    flowButtonView.viewList = self.buttonList;
    self.flowButtonView = flowButtonView;
    NSLog(@"--/==/%.2f",self.flowButtonView.height);
    self.flowButtonView.backgroundColor = [UIColor lightGrayColor];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    [headerView addSubview:self.flowButtonView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"cell";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"--/row/%.2f",self.flowButtonView.height);
    return self.flowButtonView.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSLog(@"--/section/%.2f",self.flowButtonView.height);
    return self.flowButtonView.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    headerView.frame = CGRectMake(0, 0, self.view.width, self.flowButtonView.height+10);
    NSLog(@"--/view/%.2f",self.flowButtonView.height);
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
