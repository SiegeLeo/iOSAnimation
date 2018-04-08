//
//  HIBaseTableViewController.h
//  iOSAnimation
//
//  Created by h_n on 2018/4/8.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HIBaseTableViewController : UITableViewController

- (void)setControllers;

/** 数据源数组*/
@property (nonatomic, strong) NSMutableArray *datas;

@end
