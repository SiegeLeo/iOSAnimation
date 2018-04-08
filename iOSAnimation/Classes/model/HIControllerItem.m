//
//  HIControllerItem.m
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "HIControllerItem.h"

@implementation HIControllerItem

+ (instancetype)itemWithTitle:(NSString *)title detail:(NSString *)detail controller:(UIViewController *)controller {
    HIControllerItem *item = [HIControllerItem instance];
    item.title      = title;
    item.detail     = detail;
    item.controller = controller;
    return item;
}

@end

@implementation HIControllerItemGroup

+ (instancetype)groupWithItems:(NSArray<HIControllerItem *> *)items title:(NSString *)title {
    HIControllerItemGroup *group = [HIControllerItemGroup instance];
    group.items = items;
    group.title = title;
    return group;
}

@end
