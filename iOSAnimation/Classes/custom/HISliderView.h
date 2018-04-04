//
//  HISliderView.h
//  iOSAnimation
//
//  Created by h_n on 2018/4/4.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface HISliderView : UIView

/** slider的block回调*/
@property (nonatomic, strong) void(^valueChangeBlock)(float value);

@end
