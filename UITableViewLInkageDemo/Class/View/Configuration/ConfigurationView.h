//
//  ConfigurationView.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//  左侧配置项

#import "BackgroundView.h"
#import "EScrollDelegate.h"

@class CarModel;
@interface ConfigurationView : BackgroundView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,   copy) NSArray<CarModel *> *datas;
@property (nonatomic,   weak) id<EScrollDelegate> delegate;

- (void)setScrollWithContentOffset:(CGPoint)offset;

@end
