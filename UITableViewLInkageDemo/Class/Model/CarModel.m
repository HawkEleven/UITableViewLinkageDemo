//
//  CarModel.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2018/8/13.
//  Copyright © 2018年 Hawk. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"specColorList" : [CarSpeccolorlistModel class], @"groupParamsViewModelList" : [GroupParamsModel class]};
}


@end

@implementation CarSpeccolorlistModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID" : @"id"};
}

@end


@implementation GroupParamsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"paramList" : [ParamlistModel class]};
}


@end


@implementation ParamlistModel


@end



