//
//  BackgroundView.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/14.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGPathIsEmpty(self.path.CGPath)) {
        return YES;
    } else if (CGPathContainsPoint(self.path.CGPath, nil, point, nil)) {
        return YES;
    } else {
        return NO;
    }
}

@end
