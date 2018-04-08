//
//  UISlider+HICategory.h
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^hi_sliderChangedBlock)(UISlider *slider);

@interface UISlider (HICategory)

/** 滑动的block*/
@property (nonatomic, strong) hi_sliderChangedBlock hi_sliderChanged;

@end
