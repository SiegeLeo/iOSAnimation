//
//  HICALayerController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HICALayerController.h"
#import "HIControllerItem.h"
#import "HILayerBasicController.h"

@interface HICALayerController ()

@end

@implementation HICALayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"layerTitle", nil);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CALayer"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    HIControllerItem *item = [self.datas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HIControllerItem *item = [self.datas objectAtIndex:indexPath.row];
    if (!item.controller) {
        return;
    }
    [self.navigationController pushViewController:item.controller animated:YES];
}


#pragma mark - getter
- (void)setControllers {
    [self.datas removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [HIControllerItem instance:^(HIControllerItem *item) {
        item.title = @"Basic";
        item.detail = NSLocalizedString(@"CABasic", nil);
        item.controller = [[HILayerBasicController alloc] init];
        [weakSelf.datas addObject:item];
    }];
    [HIControllerItem instance:^(HIControllerItem *item) {
        item.title = @"CAAnimation";
        item.detail = NSLocalizedString(@"CAAnimation", nil);
        item.controller = nil;
        [weakSelf.datas addObject:item];
    }];
    [HIControllerItem instance:^(HIControllerItem *item) {
        item.title = @"CABasicAnimation";
        item.detail = NSLocalizedString(@"CABasicAnimation", nil);
        item.controller = nil;
        [weakSelf.datas addObject:item];
    }];
    [HIControllerItem instance:^(HIControllerItem *item) {
        item.title = @"CAKeyFrameAnimation";
        item.detail = NSLocalizedString(@"CAKeyFrameAnimation", nil);
        item.controller = nil;
        [weakSelf.datas addObject:item];
    }];
    [HIControllerItem instance:^(HIControllerItem *item) {
        item.title = @"CAGroupAnimation";
        item.detail = NSLocalizedString(@"CAGroupAnimation", nil);
        item.controller = nil;
        [weakSelf.datas addObject:item];
    }];
    [HIControllerItem instance:^(HIControllerItem *item) {
        item.title = @"CAAnimationDelegate";
        item.detail = NSLocalizedString(@"CAAnimationDelegate", nil);
        item.controller = nil;
        [weakSelf.datas addObject:item];
    }];
    [HIControllerItem instance:^(HIControllerItem *item) {
        item.title = @"AdvancedAnimation";
        item.detail = NSLocalizedString(@"CAAdvancedAnimation", nil);
        item.controller = nil;
        [weakSelf.datas addObject:item];
    }];
}

@end
