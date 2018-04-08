//
//  HIBaseObject.m
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "HIBaseObject.h"

@implementation HIBaseObject

+ (instancetype)instance {
    return [[self alloc] init];
}

+ (instancetype)instance:(void(^)(id instance))completed {
    HIBaseObject *object = [self instance];
    completed(object);
    return object;
}

@end


