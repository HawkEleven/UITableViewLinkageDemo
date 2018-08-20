//
//  CompareCell.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/7/3.
//  Copyright © 2016年 Hawk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarModel;
@interface CompareCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setDatas:(NSArray<CarModel *> *)datas withIndex:(NSIndexPath *)indexPath;

@end
