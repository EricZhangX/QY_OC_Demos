//
//  QYLayout.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/4.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYLayout.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation QYLayout

- (CGSize)collectionViewContentSize {
    return CGSizeMake(ScreenWidth, ScreenHeight - 140);
}

- (void)prepareLayout {
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (NSInteger i = 0; i < array.count; i ++) {
        UICollectionViewLayoutAttributes *attributes = [array objectAtIndex:i];
        CGRect frame = attributes.frame;
        CGFloat height = (ScreenHeight - 140) * 0.3;
        CGFloat width = ScreenWidth - 16;
        if (attributes.indexPath.row == 0) {
            frame = CGRectMake(8, 8, width, height);
            attributes.frame = frame;
        } else if (attributes.indexPath.row == 1) {
            frame = CGRectMake(8, 16 + height, width * 0.5 - 4, height);
            attributes.frame = frame;
        } else if (attributes.indexPath.row == 2) {
            frame = CGRectMake(8 + width * 0.5 + 4, 16 + height, width * 0.5 - 4, height);
            attributes.frame = frame;
        } else if (attributes.indexPath.row == 3) {
            frame = CGRectMake(8, 24 + height * 2, width, height);
            attributes.frame = frame;
        }

    }
    
    return array;
    
}

@end
