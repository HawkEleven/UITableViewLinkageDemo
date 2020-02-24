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


@interface CompareCell ()

@property (nonatomic, strong) NSMutableArray<CompareItem *> *compareItems;

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
    if (!self.compareItems.count) {
        for (NSInteger i = 0; i < datas.count; i ++) {
            CompareItem *item = [CompareItem creatView];
            [self.contentView addSubview:item];
            [self.compareItems addObject:item];
            item.frame = CGRectMake(ITEM_WIDTH * i, 0, ITEM_WIDTH, 40);
        }
    } else {
        if (self.compareItems.count > datas.count) {
            for (NSInteger i = self.compareItems.count - 1; i > datas.count - 1; i --) {
                [(CompareItem *)self.compareItems[i] removeFromSuperview];
                [self.compareItems removeObject:self.compareItems[i]];
            }
        } else if (self.compareItems.count < datas.count) {
            for (NSInteger i = self.compareItems.count; i < datas.count; i ++) {
                CompareItem *item = [CompareItem creatView];
                [self.contentView addSubview:item];
                [self.compareItems addObject:item];
                item.frame = CGRectMake(ITEM_WIDTH * i, 0, ITEM_WIDTH, 40);
            }
        }
    }
    for (NSInteger i = 0; i < datas.count; i ++) {
        self.compareItems[i].titleLabel.text = datas[i].groupParamsViewModelList[indexPath.section].paramList[indexPath.row].paramValue;
    }
}

- (NSMutableArray<CompareItem *> *)compareItems {
    if (!_compareItems) {
        _compareItems = [NSMutableArray array];
    }
    return _compareItems;
}

@end
