//
//  UISegmentedControl+HICategory.h
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (HICategory)

/** 点击事件的block*/
@property (nonatomic, strong) void(^hi_clickedBlock)(UISegmentedControl *segment);

@end
