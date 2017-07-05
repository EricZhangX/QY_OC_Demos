//
//  QYCollectionTableVC.h
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/4.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYCollectionTableVCDelegate <NSObject>

- (void)updateItemData:(NSIndexPath *)indexpath;

@end

@interface QYCollectionTableVC : UITableViewController

@property (nonatomic, weak) id<QYCollectionTableVCDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
