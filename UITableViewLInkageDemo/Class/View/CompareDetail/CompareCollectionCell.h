//
//  CompareCollectionCell.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarModel;
@interface CompareCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UITableView *tableView;

- (void)setModel:(CarModel *)model index:(NSInteger)index;

@end
