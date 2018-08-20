//
//  ConfigCell.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/20.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
