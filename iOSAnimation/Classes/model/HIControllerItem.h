//
//  HIControllerItem.h
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "HIBaseObject.h"
#import <UIKit/UIKit.h>

@interface HIControllerItem : HIBaseObject

+ (instancetype)itemWithTitle:(NSString *)title detail:(NSString *)detail controller:(UIViewController *)controller;

/** title*/
@property (nonatomic, strong) NSString *title;
/** detail*/
@property (nonatomic, strong) NSString *detail;
/** controller*/
@property (nonatomic, strong) UIViewController *controller;

@end


@interface HIControllerItemGroup : HIBaseObject

+ (instancetype)groupWithItems:(NSArray<HIControllerItem *> *)items title:(NSString *)title;

/** items*/
@property (nonatomic, strong) NSArray <HIControllerItem *> *items;
/** group title*/
@property (nonatomic, strong) NSString *title;

@end
