//
//  StarView.m
//  SleepPillow
//
//  Created by 张庆玉 on 27/05/2017.
//  Copyright © 2017 MWellness. All rights reserved.
//

#import "StarView.h"

@interface StarView ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *stars;

@end

@implementation StarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setStarLevel:(NSInteger)starLevel {
    if (starLevel < 0) {
        starLevel = 0;
    }
    if (starLevel > 10) {
        starLevel  = 10;
    }
    _starLevel = starLevel;
    float x = (float)starLevel/2.f;
    
    for (NSInteger i = 0; i < self.stars.count; i ++) {
        UIImageView *imgView = self.stars[i];
        NSString *imgName = @"";
        if (x - (i + 1) >= 0 && x != 0) {
            imgName = @"star_full";
        }else if ((i + 1) - x >= 1){
            imgName = @"star_nil";
        }else{
            imgName = @"star_half";
        }
        imgView.image = [UIImage imageNamed:imgName];
    }
}


@end
















