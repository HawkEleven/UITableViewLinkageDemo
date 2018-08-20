//
//  CompareDetailView.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import "CompareDetailView.h"
#import "Header.h"
#import "CarModel.h"
#import "CompareTableHeader.h"
#import "CompareCell.h"

static CGFloat const kHeaderHeight = 66;
@interface CompareDetailView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollVeiw;
@property (nonatomic,   copy) NSArray<GroupParamsModel *> *dataArr;
@property (nonatomic, strong) CompareTableHeader *tableHeader;
@property (nonatomic, assign) NSInteger index;

@end

@implementation CompareDetailView

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr[section].paramList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompareCell *cell = [CompareCell cellWithTableView:tableView];
    [cell setDatas:self.datas withIndex:indexPath];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(e_scrollViewDidScroll:)]) {
        [self.delegate e_scrollViewDidScroll:scrollView];
    }
}

#pragma mark - setter/getter
- (void)setDatas:(NSArray<CarModel *> *)datas {
    _datas = datas;
    
    self.scrollVeiw.contentSize = CGSizeMake(datas.count * ITEM_WIDTH, 0);
    self.tableView.frame = CGRectMake(0, kHeaderHeight, datas.count * ITEM_WIDTH, self.scrollVeiw.bounds.size.height);
    self.tableHeader.frame = CGRectMake(0, 0, datas.count * ITEM_WIDTH, kHeaderHeight);
    
    _dataArr = datas[0].groupParamsViewModelList;
    [self.tableHeader setDatas:datas];
    [self.tableView reloadData];
    
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
        
        [self.scrollVeiw addSubview:_tableView];
    }
    return _tableView;
}

- (CompareTableHeader *)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[CompareTableHeader alloc] init];
        [self.scrollVeiw addSubview:_tableHeader];
    }
    return _tableHeader;
}

- (UIScrollView *)scrollVeiw {
    if (!_scrollVeiw) {
        _scrollVeiw = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollVeiw.bounces = NO;
        [self addSubview:_scrollVeiw];
    }
    return _scrollVeiw;
}

@end
