//
//  UISlider+HICategory.m
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "UISlider+HICategory.h"
#import <objc/runtime.h>

static void *key_hi_sliderChanged = &key_hi_sliderChanged;

@implementation UISlider (HICategory)

- (void)setHi_sliderChanged:(hi_sliderChangedBlock)hi_sliderChanged {
    if (hi_sliderChanged) {
        objc_setAssociatedObject(self, &key_hi_sliderChanged, hi_sliderChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    }
}

- (hi_sliderChangedBlock)hi_sliderChanged {
    return objc_getAssociatedObject(self, &key_hi_sliderChanged);
}

#pragma mark - private
- (void)sliderChanged {
    if (self.hi_sliderChanged) {
        self.hi_sliderChanged(self);
    }
}

@end
