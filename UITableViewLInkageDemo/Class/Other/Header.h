//
//  Header.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/7/3.
//  Copyright © 2017年 Hawk. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define HexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]

/////////////////////////// 懒加载 /////////////////////////////
#define ELazyMutableArray(_array) \
return !(_array) ? (_array) = [NSMutableArray array] : (_array);

#endif /* Header_h */
