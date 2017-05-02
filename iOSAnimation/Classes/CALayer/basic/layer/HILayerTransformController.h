//
//  HILayerTransformController.h
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CALayerTransformMode) {
    CALayerTransformMode3D,
    CALayerTransformModeValue
};

typedef NS_ENUM(NSInteger, CALayerTransformDirection) {
    CALayerTransformDirectionX,
    CALayerTransformDirectionY,
    CALayerTransformDirectionZ
};

typedef NS_ENUM(NSInteger, CALayerTransformAction) {
    CALayerTransformActionTranslate,
    CALayerTransformActionScale,
    CALayerTransformActionRotate
};



@interface HILayerTransformController : UIViewController

@end
