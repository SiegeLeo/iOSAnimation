//
//  UISegmentedControl+HICategory.m
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "UISegmentedControl+HICategory.h"
#import <objc/runtime.h>

static void *hi_clickedBlock = &hi_clickedBlock;

@implementation UISegmentedControl (HICategory)

- (void)setHi_clickedBlock:(void (^)(UISegmentedControl *))hi_clickedBlock {
    if (hi_clickedBlock) {
        objc_setAssociatedObject(self, &hi_clickedBlock, hi_clickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(segmentedChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void (^)(UISegmentedControl *))hi_clickedBlock {
    return objc_getAssociatedObject(self, &hi_clickedBlock);
}

#pragma mark - private
- (void)segmentedChanged:(UISegmentedControl *)segment {
    self.hi_clickedBlock(self);
}

@end
