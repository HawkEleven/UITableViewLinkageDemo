//
//  CompareTableHeader.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/20.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import "CompareTableHeader.h"
#import "CarModel.h"
#import "CompareHeaderView.h"
#import "Header.h"

@implementation CompareTableHeader

- (void)setDatas:(NSArray<CarModel *> *)datas {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CompareRightHeader class]] || [view isKindOfClass:[CompareAddHeader class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < datas.count; i ++) {
    if (i == datas.count - 1) {
        CompareAddHeader *header = [CompareAddHeader creatView];
        header.frame = CGRectMake(ITEM_WIDTH * i, 0, ITEM_WIDTH, 66);
        header.addBlock = ^{
          [[NSNotificationCenter defaultCenter] postNotificationName:@"addNotification" object:nil];
        };
        [self addSubview:header];
    } else {
        CompareRightHeader *header = [CompareRightHeader creatView];
        header.frame = CGRectMake(ITEM_WIDTH * i, 0, ITEM_WIDTH, 66);
        header.modelNameLabel.text = datas[i].specName;
        header.deleteBlock = ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteNotification" object:nil userInfo:@{@"index" : @(i)}];
        };
        [self addSubview:header];
    }
    }
}

@end
