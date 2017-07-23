//
//  ParameterCompareHeaderView.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/7/3.
//  Copyright © 2016年 Hawk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ParameterClickBlock)();

@interface CompareHiddenHeader : UIView

@property (nonatomic, copy) ParameterClickBlock hiddenBlock;

+ (instancetype)creatView;

@end

@interface CompareRightHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *modelNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) ParameterClickBlock deleteBlock;

+ (instancetype)creatView;

@end

@interface CompareAddHeader : UIView

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, copy) ParameterClickBlock addBlock;

+ (instancetype)creatView;

@end
