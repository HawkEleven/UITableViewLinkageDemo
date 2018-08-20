//
//  CompareDetailView.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//  右侧对比项

#import <UIKit/UIKit.h>
#import "EScrollDelegate.h"

@class CarModel;
@interface CompareDetailView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,   copy) NSArray<CarModel *> *datas;
@property (nonatomic,   weak) id<EScrollDelegate> delegate;


@end
