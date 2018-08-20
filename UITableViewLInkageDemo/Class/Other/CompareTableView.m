//
//  CompareTableView.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/8/13.
//  Copyright © 2017年 Hawk. All rights reserved.
//

#import "CompareTableView.h"

@implementation CompareTableView

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
