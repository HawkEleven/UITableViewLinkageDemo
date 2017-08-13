//
//  ViewController.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/7/3.
//  Copyright © 2017年 Hawk. All rights reserved.
//

#import "ViewController.h"
#import "CompareCell.h"
#import "CompareHeaderView.h"
#import "CompareSectionHeaderView.h"
#import "Header.h"
#import "CompareTableView.h"

typedef NS_ENUM(NSInteger, ParameterCompareType) {
    ParameterCompareTypeAdd, // 添加车型
    ParameterCompareTypeDelete // 删除车型
};

static NSString * const BrandCellIdentifier = @"BrandCell";
static CGFloat const kItemWidth = 94;
static CGFloat const kHeaderHeight = 66;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

/** 参数名称列表 */
@property (nonatomic, strong) CompareTableView *backgroundTableView;
@property (nonatomic, strong) UITableView *emptyTableView;
@property (nonatomic, strong) CompareHiddenHeader *hiddenHeader;
@property (nonatomic, strong) CompareAddHeader *addHeader;
@property (nonatomic, strong) UIScrollView *scrollView;
/** 头部名称视图 */
@property (nonatomic, strong) UIScrollView *littleScrollView;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray<UITableView *> *tableViewArr;
@property (nonatomic, strong) NSMutableArray<UIView *> *headerArr;
@property (nonatomic, strong) NSMutableArray *nameArr;
@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *rowArr;
@property (nonatomic, strong) NSMutableArray *idArr;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = [UIColor whiteColor];

    [self _initUI];
    [self _loadParameterDataWithCout:3];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.frame = CGRectMake(kItemWidth, 64 + kHeaderHeight, kScreenWidth - kItemWidth, self.backgroundTableView.contentSize.height);
    CGSize contentSize = self.scrollView.contentSize;
    contentSize.height = self.backgroundTableView.contentSize.height;
    self.scrollView.contentSize = contentSize;
}

#pragma mark - private methods
- (void)_initUI {
    [self.view addSubview:self.hiddenHeader];

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.backgroundTableView];
    
    [self.scrollView addSubview:self.emptyTableView];
    [self.tableViewArr addObject:self.emptyTableView];
    [self.view addSubview:self.littleScrollView];
    [self.littleScrollView addSubview:self.addHeader];
    [self.headerArr addObject:self.addHeader];
    self.scrollView.contentSize = CGSizeMake(4 * kItemWidth, 0);
}

/**
 *  具体参数列表
 */
- (UITableView *)_creatTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}

/**
 *  头部视图
 */
- (CompareRightHeader *)_creatHeaderView {
    CompareRightHeader *rightHeader = [CompareRightHeader creatView];
    rightHeader.frame = CGRectMake(kItemWidth, 0, kItemWidth, kHeaderHeight);
    rightHeader.deleteBlock = ^(UIButton *button) {
        [self _deleteModels:button];
    };
    return rightHeader;
}

/**
 *  重新布局列表视图
 *
 *  @param arr   列表集合
 *  @param index 开始位置
 *  @param type  添加或删除
 */
- (void)_layoutWithArr:(NSMutableArray *)arr fromIndex:(NSInteger)index type:(ParameterCompareType)type {
    if (type == ParameterCompareTypeDelete) {
        UIView *view = arr[index];
        [view removeFromSuperview];
        [arr removeObjectAtIndex:index];
    }
    for (NSInteger i = index; i < arr.count; i ++) {
        UIView *header = arr[i];
        CGRect frame = header.frame;
        if (type == ParameterCompareTypeAdd) {
            frame.origin.x += kItemWidth;
            header.frame = frame;
        } else {
            frame.origin.x -= kItemWidth;
            header.frame = frame;
        }
    }
    NSInteger sum;
    if (self.count + 1 < 5) {
        sum = 4;
    } else {
        sum = self.count + 1;
    }
    self.scrollView.contentSize = CGSizeMake(kItemWidth * sum, 0);
    self.littleScrollView.contentSize = CGSizeMake(kItemWidth * sum, 0);
}

#pragma mark - load Data
- (void)_loadParameterDataWithCout:(NSInteger)count {
    // 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.sectionArr removeAllObjects];
        [self.rowArr removeAllObjects];
        for (NSInteger i = 0; i < count; i ++) {
            [self.nameArr addObject:[NSString stringWithFormat:@"种类%zi", i]];
            [self.idArr addObject:[NSString stringWithFormat:@"%zi",i]];
        }
        for (NSInteger i = 0; i < 5; i ++) {
            [self.sectionArr addObject:[NSString stringWithFormat:@"基本参数%zi", i]];
        }
        for (NSInteger j = 0; j < 6; j ++) {
            [self.rowArr addObject:[NSString stringWithFormat:@"基本参数%zi", j]];
        }
        
        self.hiddenHeader.hidden = NO;
        self.addHeader.hidden = NO;
        [self.backgroundTableView reloadData];
        [self.emptyTableView reloadData];
        
        if (self.tableViewArr.count > 1) {
            for (NSInteger i = self.headerArr.count - 2; i >= 0; i --) {
                _count --;
                CompareRightHeader *rightHeader = (CompareRightHeader *)self.headerArr[i];
                NSInteger index = [self.headerArr indexOfObject:rightHeader];
                [self _layoutWithArr:self.headerArr fromIndex:index type:ParameterCompareTypeDelete];
                [self _layoutWithArr:self.tableViewArr fromIndex:index type:ParameterCompareTypeDelete];
            }
        }
        
        for (NSInteger i = 0; i < self.idArr.count; i ++) {
            [self _addModels];
        }
        for (UITableView *tableView in self.tableViewArr) {
            [tableView reloadData];
        }
        
        for (NSInteger i = 0; i < self.nameArr.count; i ++) {
            CompareRightHeader *header = (CompareRightHeader *)self.headerArr[i];
            header.modelNameLabel.text = self.nameArr[i];
        }
    });
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _backgroundTableView) {
        CompareLeftCell *leftCell = [CompareLeftCell cellWithTableView:tableView];
        leftCell.titleLabel.text = self.rowArr[indexPath.row];
        leftCell.backgroundColor = [UIColor clearColor];
        return leftCell;
    } else if (tableView == _emptyTableView) {
        CompareRightCell *rightCell = [CompareRightCell cellWithTableView:tableView];
        return rightCell;
    } else {
//        NSInteger rightTableViewIndex = [self.tableViewArr indexOfObject:tableView];
        CompareRightCell *rightCell = [CompareRightCell cellWithTableView:tableView];
        
        rightCell.titleLabel.text = self.rowArr[indexPath.row];
        return rightCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CompareSectionHeaderView *sectionHeader = [CompareSectionHeaderView creatView];
    sectionHeader.titleLabel.text = self.sectionArr[section];
    return sectionHeader;
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
//    label.text = [NSString stringWithFormat:@"   基本参数%zi", section];
//    label.font = [UIFont systemFontOfSize:10];
//    label.textColor = HexColorInt32_t(1E2124);
//    label.backgroundColor = HexColorInt32_t(F0F0F0);
//    if (tableView != self.backgroundTableView) {
//        label.text = @"";
//    }
//    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.littleScrollView) {
        if (self.scrollView.contentOffset.x != self.littleScrollView.contentOffset.x) {
            self.scrollView.contentOffset = CGPointMake(self.littleScrollView.contentOffset.x, 0);
        }
    } else if (scrollView == self.scrollView) {
        if (self.littleScrollView.contentOffset.x != self.scrollView.contentOffset.x) {
            self.littleScrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
        }
    } else if ([scrollView isKindOfClass:[UITableView class]]) {
        if (scrollView == self.backgroundTableView) {
            for (UITableView *right in self.tableViewArr) {
                right.contentOffset = CGPointMake(0, self.backgroundTableView.contentOffset.y);
            }
        } else {
            UITableView *scrollTableView = (UITableView *)scrollView;
            self.backgroundTableView.contentOffset = CGPointMake(0, scrollTableView.contentOffset.y);
            for (NSInteger i = 0; i < self.tableViewArr.count; i ++) {
                if (self.tableViewArr[i] != scrollTableView) {
                    self.tableViewArr[i].contentOffset = CGPointMake(0, scrollTableView.contentOffset.y);
                }
            }
        }
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, scrollView.contentOffset.y, 94, CGRectGetHeight(self.backgroundTableView.frame))];
    self.backgroundTableView.path = path;
}

#pragma mark - event response
- (void)_addModels {
    UITableView *tableView = [self _creatTableView];
    tableView.frame = CGRectMake(kItemWidth * self.count, 0, kItemWidth, kScreenHeight - 64 - kHeaderHeight);
    [self.scrollView addSubview:tableView];
    [self.tableViewArr insertObject:tableView atIndex:self.tableViewArr.count - 1];
    [tableView reloadData];
    
    CompareRightHeader *header = [self _creatHeaderView];
    header.frame = CGRectMake(kItemWidth * self.count, 0, kItemWidth, kHeaderHeight);
    [self.littleScrollView addSubview:header];
    [self.headerArr insertObject:header atIndex:self.headerArr.count - 1];
    
    _count ++;
    [self _layoutWithArr:self.headerArr fromIndex:self.headerArr.count - 1 type:ParameterCompareTypeAdd];
    [self _layoutWithArr:self.tableViewArr fromIndex:self.tableViewArr.count - 1 type:ParameterCompareTypeAdd];
}

- (void)_deleteModels:(UIButton *)button {
    _count --;
    CompareRightHeader *rightHeader = (CompareRightHeader *)button.superview;
    NSInteger index = [self.headerArr indexOfObject:rightHeader];
    [self _layoutWithArr:self.headerArr fromIndex:index type:ParameterCompareTypeDelete];
    [self _layoutWithArr:self.tableViewArr fromIndex:index type:ParameterCompareTypeDelete];
    // 删除相应的ID
    [self.idArr removeObjectAtIndex:index];
    [self.nameArr removeObjectAtIndex:index];
    
}

#pragma mark - getter
- (CompareTableView *)backgroundTableView {
    if (!_backgroundTableView) {
        _backgroundTableView = [[CompareTableView alloc] initWithFrame:CGRectMake(0, 64 + kHeaderHeight, kScreenWidth, kScreenHeight - 64 - kHeaderHeight)];
        _backgroundTableView.delegate = self;
        _backgroundTableView.dataSource = self;
        _backgroundTableView.rowHeight = 40;
        _backgroundTableView.showsVerticalScrollIndicator = NO;
        _backgroundTableView.bounces = NO;
        _backgroundTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _backgroundTableView.scrollEnabled = YES;
        _backgroundTableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_backgroundTableView];
    }
    return _backgroundTableView;
}

- (UITableView *)emptyTableView {
    if (!_emptyTableView) {
        _emptyTableView = [self _creatTableView];
        _emptyTableView.frame = CGRectMake(0, 0, kItemWidth, self.backgroundTableView.contentSize.height);
        [self.view addSubview:_emptyTableView];
    }
    return _emptyTableView;
}

- (CompareHiddenHeader *)hiddenHeader {
    if (!_hiddenHeader) {
        _hiddenHeader = [CompareHiddenHeader creatView];
        _hiddenHeader.hidden = YES;
        _hiddenHeader.frame = CGRectMake(0, 64, kItemWidth, kHeaderHeight);
        _hiddenHeader.hiddenBlock = ^(UIButton *button) {
            
        };
    }
    return _hiddenHeader;
}

- (CompareAddHeader *)addHeader {
    if (!_addHeader) {
        _addHeader = [CompareAddHeader creatView];
        _addHeader.hidden = YES;
        _addHeader.frame = CGRectMake(0, 0, kItemWidth, kHeaderHeight);
        
        __weak __typeof(self) weakSelf = self;
        _addHeader.addBlock = ^() {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            // 模拟添加对比项
            [strongSelf _loadParameterDataWithCout:1];
        };
    }
    return _addHeader;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIScrollView *)littleScrollView {
    if (!_littleScrollView) {
        _littleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kItemWidth, 64, kScreenWidth - kItemWidth, kHeaderHeight)];
        _littleScrollView.backgroundColor = [UIColor whiteColor];
        _littleScrollView.showsHorizontalScrollIndicator = NO;
        _littleScrollView.bounces = NO;
        _littleScrollView.delegate = self;
    }
    return _littleScrollView;
}

- (NSMutableArray<UITableView *> *)tableViewArr { ELazyMutableArray(_tableViewArr); }
- (NSMutableArray<UIView *> *)headerArr { ELazyMutableArray(_headerArr); }
- (NSMutableArray *)nameArr { ELazyMutableArray(_nameArr); }
- (NSMutableArray *)sectionArr { ELazyMutableArray(_sectionArr); }
- (NSMutableArray *)rowArr { ELazyMutableArray(_rowArr); }
- (NSMutableArray *)idArr { ELazyMutableArray(_idArr); }



@end
