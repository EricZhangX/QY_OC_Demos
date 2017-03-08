//
//  PointContainer.m
//  HeartRateCoreGraphicDemo
//
//  Created by 张庆玉 on 2017/2/17.
//  Copyright © 2017年 张庆玉. All rights reserved.
//

#import "PointContainer.h"



@interface PointContainer ()
@property (nonatomic , assign) NSInteger numberOfRefreshElements;

@property (nonatomic , assign) CGPoint *refreshPointContainer;

@end

@implementation PointContainer

- (void)dealloc {
    free(self.refreshPointContainer);
    self.refreshPointContainer = NULL;
}

+ (PointContainer *)sharedContainer {
    static PointContainer *container_ptr = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        container_ptr = [[self alloc] init];
        container_ptr.refreshPointContainer = malloc(sizeof(CGPoint) * kMaxContainerCapacity);
        memset(container_ptr.refreshPointContainer, 0, sizeof(CGPoint) * kMaxContainerCapacity);
        
    });
    return container_ptr;
}

- (void)addPointAsRefreshChangeform:(CGPoint)point {
    static NSInteger currentPointsCount = 0;
    NSLog(@"===%ld",currentPointsCount);
    if (currentPointsCount < kMaxContainerCapacity) {
        self.numberOfRefreshElements = currentPointsCount + 1;
        self.refreshPointContainer[currentPointsCount] = point;
        currentPointsCount ++;
    } else {
        NSInteger workIndex = 0;
        while (workIndex != kMaxContainerCapacity - 1) {
            self.refreshPointContainer[workIndex] = self.refreshPointContainer[workIndex + 1];
            workIndex ++;
        }
        self.refreshPointContainer[kMaxContainerCapacity - 1] = point;
        self.numberOfRefreshElements = kMaxContainerCapacity;
    }
    
//    printf("当前元素个数:%2ld->",self.numberOfRefreshElements);
//    for (int k = 0; k != kMaxContainerCapacity; ++k) {
//        printf("(%4.0f,%4.0f)",self.refreshPointContainer[k].x,self.refreshPointContainer[k].y);
//    }
//    putchar('\n');
}


@end
