//
//  ConfigurationView.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import "ConfigurationView.h"
#import "Header.h"
#import "CompareHeaderView.h"
#import "ConfigCell.h"
#import "ConfigSectionHeaderView.h"
#import "CarModel.h"

static CGFloat const kHeaderHeight = 66;

@interface ConfigurationView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,   copy) NSArray<GroupParamsModel *> *dataArr;
@property (nonatomic, strong) CompareHiddenHeader *hiddenHeader;


@end

@implementation ConfigurationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 设置tableView的交互区域
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ITEM_WIDTH, self.bounds.size.height)];
        self.path = path;
    }
    return self;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr[section].paramList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConfigCell *cell = [ConfigCell cellWithTableView:tableView];
    cell.titleLabel.text = self.dataArr[indexPath.section].paramList[indexPath.row].paramName;
    cell.backgroundColor = self.backgroundColor;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ConfigSectionHeaderView *sectionHeader = [ConfigSectionHeaderView creatView];
    sectionHeader.titleLabel.text = self.dataArr[section].groupName;
    return sectionHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(e_scrollViewDidScroll:)]) {
        [self.delegate e_scrollViewDidScroll:scrollView];
    }
}

#pragma mark - setter/getter
- (void)setDatas:(NSArray<CarModel *> *)datas {
    _datas = datas;
    
    _dataArr = datas[0].groupParamsViewModelList;
    [self.tableView reloadData];
    self.hiddenHeader.backgroundColor = self.backgroundColor;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeaderHeight, self.bounds.size.width, self.bounds.size.height - kHeaderHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.sectionHeaderHeight = 30;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.backgroundColor;
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (CompareHiddenHeader *)hiddenHeader {
    if (!_hiddenHeader) {
        _hiddenHeader = [CompareHiddenHeader creatView];
        _hiddenHeader.frame = CGRectMake(0, 0, ITEM_WIDTH, kHeaderHeight);
        _hiddenHeader.hiddenBlock = ^(UIButton *button) {
            
        };
        [self addSubview:_hiddenHeader];
    }
    return _hiddenHeader;
}



@end
