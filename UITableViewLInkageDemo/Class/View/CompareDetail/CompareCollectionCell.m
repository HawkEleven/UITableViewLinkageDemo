//
//  CompareCollectionCell.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import "CompareCollectionCell.h"
#import "CompareCell.h"
#import "CarModel.h"
#import "CompareHeaderView.h"
#import "Header.h"

static CGFloat const kHeaderHeight = 66;
@interface CompareCollectionCell () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,   copy) NSArray<GroupParamsModel *> *dataArr;
@property (nonatomic, strong) CompareRightHeader *header;
@property (nonatomic, strong) CompareAddHeader *addHeader;
@property (nonatomic, assign) NSInteger index;

@end

@implementation CompareCollectionCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, kHeaderHeight, self.bounds.size.width, self.bounds.size.height - kHeaderHeight);
    self.header.frame = CGRectMake(0, 0, ITEM_WIDTH, kHeaderHeight);
    self.addHeader.frame = CGRectMake(0, 0, ITEM_WIDTH, kHeaderHeight);
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr[section].paramList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompareRightCell *cell = [CompareRightCell cellWithTableView:tableView];
    cell.titleLabel.text = self.dataArr[indexPath.section].paramList[indexPath.row].paramValue;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] init];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(e_scrollViewDidScroll:)]) {
            [self.delegate e_scrollViewDidScroll:scrollView];
        }
    }
}

#pragma mark - setter/getter
- (void)setModel:(CarModel *)model index:(NSInteger)index {
    _index  = index;
    
    _dataArr = model.groupParamsViewModelList.copy;
    [self.tableView reloadData];
    
    if (model.specId) {
        self.header.hidden = NO;
        self.addHeader.hidden = YES;
        self.header.modelNameLabel.text = model.specName;
    } else { // 最后一组，空视图
        self.header.hidden = YES;
        self.addHeader.hidden = NO;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.backgroundColor;
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (CompareRightHeader *)header {
    if (!_header) {
        _header = [CompareRightHeader creatView];
        @weakify(self);
        
        _header.deleteBlock = ^{
            @strongify(self);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteNotification" object:self userInfo:@{@"index" : @(self.index)}];
        };
        [self addSubview:_header];
    }
    return _header;
}

- (CompareAddHeader *)addHeader {
    if (!_addHeader) {
        _addHeader = [CompareAddHeader creatView];
        @weakify(self);
        _addHeader.addBlock = ^{
            @strongify(self);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addNotification" object:self];

        };
        [self addSubview:_addHeader];
    }
    return _addHeader;
}

@end
