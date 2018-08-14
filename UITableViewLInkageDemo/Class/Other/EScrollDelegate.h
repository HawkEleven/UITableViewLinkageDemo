//
//  EScrollDelegate.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/14.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EScrollDelegate <NSObject>

- (void)e_scrollViewDidScroll:(UIScrollView *)scrollView;
@end
