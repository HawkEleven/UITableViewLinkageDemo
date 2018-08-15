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
#import "CompareCollectionCell.h"

static NSString * const CellIdentifier = @"CompareCollectionCell";
@interface CompareDetailView () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) CGPoint setOffset;

@end

@implementation CompareDetailView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark - public method
- (void)setScrollWithContentOffset:(CGPoint)offset {
    self.setOffset = offset;

    for (int i = 0; i < self.dataArr.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CompareCollectionCell *cell = (CompareCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.tableView.contentOffset = self.setOffset;
    }
}

#pragma mark - ====== UICollectionViewDelegate,UICollectionViewDataSource =====
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CompareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.tableView.delegate = self;
    [cell setModel:self.dataArr[indexPath.item] index:indexPath.item];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] init];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

bool flag = YES;
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if (!flag) return;
        if (self.delegate && [self.delegate respondsToSelector:@selector(e_scrollViewDidScroll:)]) {
            [self.delegate e_scrollViewDidScroll:scrollView];
        }
        
    } else {
        flag = NO;
        for (int i = 0; i < self.dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            CompareCollectionCell *cell = (CompareCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            cell.tableView.contentOffset = self.setOffset;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    flag = YES;
}

#pragma mark - setter/getter
- (void)setDatas:(NSArray<CarModel *> *)datas {
    _datas = datas;
    
    _dataArr = datas.copy;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = ITEM_WIDTH;
        CGFloat height = self.bounds.size.height;
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = self.backgroundColor;
        
        [_collectionView registerClass:[CompareCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self addSubview:_collectionView];
        
    }
    return _collectionView;
}

@end
