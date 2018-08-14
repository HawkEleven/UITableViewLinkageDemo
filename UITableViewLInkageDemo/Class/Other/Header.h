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
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]

/////////////////////////// 懒加载 /////////////////////////////
#define ELazyMutableArray(_array) \
return !(_array) ? (_array) = [NSMutableArray array] : (_array);

//////////////////////////////////////////////////////////////

// 判断是否iPhone X
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// status bar height.
#define STATUS_BAR_HEIGHT (IS_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define NAVIGATION_BAR_HEIGHT 44.f

// Status bar & navigation bar height.
#define STATUS_AND_NAVIGATION_HEIGHT (IS_iPhoneX ? 88.f : 64.f)

// Tabbar height.
#define TAB_BAR_HEIGHT (IS_iPhoneX ? (49.f + 34.f) : 49.f)

// Tabbar safe bottom margin.
#define TAB_BAR_SAFE_BOTTOM_MARGIN (IS_iPhoneX ? 34.f : 0.f)

/////////////////////////////////////////////////////////////////////////////////
///  安全运行block
#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;

#ifndef weakify

#if DEBUG

#if __has_feature(objc_arc)

#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;

#else

#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;

#endif

#else

#if __has_feature(objc_arc)

#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;

#else

#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;

#endif

#endif

#endif



#ifndef strongify

#if DEBUG

#if __has_feature(objc_arc)

#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;

#else

#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;

#endif

#else

#if __has_feature(objc_arc)

#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;

#else

#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;

#endif

#endif

#endif

//////////////////////////////////////////////////////////////
#define ITEM_WIDTH 94

#endif /* Header_h */
