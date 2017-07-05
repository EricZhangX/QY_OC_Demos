//
//  QYFlowLayout.m
//  QYDemos
//
//  Created by 张庆玉 on 2017/7/4.
//  Copyright © 2017年 Qingyu. All rights reserved.
//

#import "QYFlowLayout.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ItemSeporat  16.f

@implementation QYFlowLayout

- (CGSize)collectionViewContentSize {
    return CGSizeMake(ScreenWidth, ScreenHeight - 120);
}

- (void)prepareLayout {
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (NSInteger i = 0; i < array.count; i ++) {
        UICollectionViewLayoutAttributes *attributes = [array objectAtIndex:i];
        
        NSInteger j = i / 3;
        NSInteger k = i % 3;
        
        CGRect frame = attributes.frame;
        CGFloat height = (ScreenHeight - 120 - (4 * ItemSeporat)) * 0.33;
        CGFloat width = ScreenWidth - (ItemSeporat * 2);
        CGFloat startY = j * 2 * (ItemSeporat + height);
        
        if (k == 0) {
            frame = CGRectMake(ItemSeporat, ItemSeporat + startY, width, height);
        } else if (k == 1) {
            frame = CGRectMake(ItemSeporat, ItemSeporat * 2 + startY + height, width * 0.5 - (ItemSeporat * 0.5), height);
        } else if (k == 2) {
            frame = CGRectMake(ItemSeporat + width * 0.5 + (ItemSeporat * 0.5), (ItemSeporat * 2) + startY + height, width * 0.5 - (ItemSeporat * 0.5), height);
        }
        attributes.frame = frame;

    }
    
    return array;
    
}


@end














