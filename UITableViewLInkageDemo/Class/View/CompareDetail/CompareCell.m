//
//  CompareCell.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/7/3.
//  Copyright © 2016年 Hawk. All rights reserved.
//

#import "CompareCell.h"
#import "CarModel.h"
#import "Header.h"

@interface CompareItem : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)creatView;

@end

@implementation CompareItem

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareItem" owner:nil options:nil] objectAtIndex:0];
}

@end


@implementation CompareCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"CompareCell";
    CompareCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CompareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setDatas:(NSArray<CarModel *> *)datas withIndex:(NSIndexPath *)indexPath {
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[CompareItem class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < datas.count; i ++) {
        CompareItem *item = [CompareItem creatView];
        item.frame = CGRectMake(ITEM_WIDTH * i, 0, ITEM_WIDTH, 40);
        item.titleLabel.text = datas[i].groupParamsViewModelList[indexPath.section].paramList[indexPath.row].paramValue;
        [self.contentView addSubview:item];
    }
}

@end
