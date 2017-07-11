//
//  QYCollectionVC.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/4.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYCollectionVC.h"
#import "QYCollectionViewCell.h"
#import "QYFlowLayout.h"
#import "QYCollectionTableVC.h"




@interface QYCollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,QYCollectionTableVCDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *modelsArr;

@end

@implementation QYCollectionVC

- (NSMutableArray *)modelsArr {
    if (!_modelsArr) {
        _modelsArr = [NSMutableArray new];
    }
    return _modelsArr;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self createCartModels];
    
    QYFlowLayout *layout = [[QYFlowLayout alloc] init];
    
    [self.collectionView setCollectionViewLayout:layout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"QYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)createCartModels {
    NSArray *titles = @[@"血压",@"体重",@"运动",@"心率"];
    NSArray *titlImgs = @[@"all",@"bussiness-man",@"Category",@"favorite"];
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        NSString *titleImg = titlImgs[i];
        NSString *centerImg = titlImgs[i];
        
        CardItemModel *model = [[CardItemModel alloc] initWithType:i Title:title TitleImg:titleImg CenterImg:centerImg];
        if ([title isEqualToString:@"血压"]) {
            model.systolicPressure = 133;
            model.diastolicPressure = 88;
        }
        [self.modelsArr addObject:model];
    }
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    CardItemModel *model = self.modelsArr[indexPath.row];
    [cell setUpUIByModel:model];
    return cell;
}

- (void)updateItemData:(NSIndexPath *)indexpath {
    NSLog(@"update");
    CardItemModel *model = self.modelsArr[indexpath.row];
    [self.modelsArr removeObject:model];
    [self.modelsArr insertObject:model atIndex:0];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QYCollectionTableVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"QYCollectionTableVC"];
    vc.indexPath = indexPath;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
