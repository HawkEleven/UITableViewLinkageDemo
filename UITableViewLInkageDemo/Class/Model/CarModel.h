//
//  CarModel.h
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CarSpeccolorlistModel, GroupParamsModel, ParamlistModel;
@interface CarModel : NSObject

@property (nonatomic, assign) NSInteger specId;

@property (nonatomic, strong) NSArray<GroupParamsModel *> *groupParamsViewModelList;

@property (nonatomic, strong) NSArray<CarSpeccolorlistModel *> *specColorList;

@property (nonatomic,   copy) NSString *specName;

@property (nonatomic, assign) NSInteger seriesId;

// 同步滚动距离
@property (nonatomic, assign) CGPoint currentOffset;

@end


@interface CarSpeccolorlistModel : NSObject

@property (nonatomic, assign) NSInteger specId;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger bodyId;

@property (nonatomic,   copy) NSString *colorValue;

@property (nonatomic,   copy) NSString *colorName;

@property (nonatomic, assign) NSInteger colorId;

@end


@interface GroupParamsModel : NSObject

@property (nonatomic, assign) NSInteger groupId;

@property (nonatomic,   copy) NSString *groupName;

@property (nonatomic, strong) NSArray<ParamlistModel *> *paramList;

@end


@interface ParamlistModel : NSObject

@property (nonatomic, assign) NSInteger paramId;

@property (nonatomic,   copy) NSString *paramValue;

@property (nonatomic,   copy) NSString *paramName;

@end


