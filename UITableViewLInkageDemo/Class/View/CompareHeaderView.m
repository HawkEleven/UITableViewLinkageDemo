//
//  ParameterCompareHeaderView.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/7/3.
//  Copyright © 2016年 Hawk. All rights reserved.
//

#import "CompareHeaderView.h"

@implementation CompareHiddenHeader
{
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_promptLabel;
}

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareHeaderView" owner:self options:nil] objectAtIndex:0];
}

- (IBAction)hidden:(UIButton *)sender {

}

@end

@implementation CompareRightHeader

- (void)awakeFromNib {
    [super awakeFromNib];

}

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareHeaderView" owner:self options:nil] objectAtIndex:1];
}

- (IBAction)delete:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

@end

@implementation CompareAddHeader

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareHeaderView" owner:self options:nil] objectAtIndex:2];
}

- (IBAction)add:(UIButton *)sender {
    if (self.addBlock) {
        self.addBlock();
    }
}

@end
