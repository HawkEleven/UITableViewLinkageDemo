//
//  ConfigCell.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/20.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import "ConfigCell.h"

@implementation ConfigCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"ConfigCell";
    ConfigCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConfigCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
