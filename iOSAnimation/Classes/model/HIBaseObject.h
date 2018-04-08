//
//  HIBaseObject.h
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HIBaseObject : NSObject

+ (instancetype)instance;

+ (instancetype)instance:(void(^)(id instance))completed;

@end
