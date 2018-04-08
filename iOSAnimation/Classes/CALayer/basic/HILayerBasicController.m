//
//  HILayerBasicController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerBasicController.h"
#import "HIControllerItem.h"

/** Layer*/
#import "HILayerPositionController.h"
#import "HILayerBoundsController.h"
#import "HILayerTransformController.h"
#import "HILayerMaskController.h"
#import "HILayerContentsController.h"

/** shapeLayer*/
#import "HILayerPathController.h"
#import "HILayerStrokeController.h"
#import "HILayerFillController.h"
#import "HILayerLineController.h"
#import "HILayerLineDashController.h"

@interface HILayerBasicController ()

/** layer's storyboard*/
@property (nonatomic, strong) UIStoryboard *layerPropertySB;

@end

@implementation HILayerBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"layerTitleBasic", nil);

    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HIControllerItemGroup *group = [self.datas objectAtIndex:section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ids = @"layerBasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ids];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ids];
    }
    HIControllerItemGroup *group = [self.datas objectAtIndex:indexPath.section];
    HIControllerItem *item = [group.items objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    HIControllerItemGroup *group = [self.datas objectAtIndex:section];
    return group.title;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HIControllerItemGroup *group = [self.datas objectAtIndex:indexPath.section];
    HIControllerItem *item = [group.items objectAtIndex:indexPath.row];
    if (!item.controller) {
        return;
    }
    [self.navigationController pushViewController:item.controller animated:YES];
}


#pragma mark - getter

- (void)setControllers {
    self.layerPropertySB = [UIStoryboard storyboardWithName:@"HILayerProperty" bundle:nil];
    
    __weak typeof(self) weakSelf = self;
    
    // layer
    [HIControllerItemGroup instance:^(HIControllerItemGroup *group) {
        group.title = @"CALayer";
        group.items = @[
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"bounds";
                            item.detail = @"Class: HILayerPositionController, bounds";
                            item.controller = [self.layerPropertySB instantiateViewControllerWithIdentifier:@"layer.Bounds"];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"position";
                            item.detail = @"Class: HILayerPositionController, position";
                            item.controller = [self.layerPropertySB instantiateViewControllerWithIdentifier:@"layer.Position"];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"transform";
                            item.detail = @"Class: HILayerTransformController, transform";
                            item.controller = [[HILayerTransformController alloc] init];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"mask";
                            item.detail = @"Class: HILayerMaskController, mask";
                            item.controller = [[HILayerMaskController alloc] init];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"contents";
                            item.detail = @"Class: HILayerMaskController, contents";
                            item.controller = [[HILayerContentsController alloc] init];
                        }],
                        ];
        [weakSelf.datas addObject:group];
    }];
    
    // ShapeLayer
    [HIControllerItemGroup instance:^(HIControllerItemGroup *group) {
        group.title = @"CAShapeLayer";
        group.items = @[
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"path";
                            item.detail = @"Class: HILayerPathController, path";
                            item.controller = [[HILayerPathController alloc] init];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"strokes";
                            item.detail = @"Class: HILayerStrokeController, strokeColor、strokeStart、strokeEnd";
                            item.controller = [[HILayerStrokeController alloc] init];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"fills";
                            item.detail = @"Class: HILayerFillController, fillColor、fillRule";
                            item.controller = [[HILayerFillController alloc] init];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"lines";
                            item.detail = @"HILayerLineController, lineWidth、miterLimit、lineJoin、lineCap";
                            item.controller = [[HILayerLineController alloc] init];
                        }],
                        [HIControllerItem instance:^(HIControllerItem *item) {
                            item.title = @"lineDash";
                            item.detail = @"Class: HILayerLineDashController, lineDashPhase、Dash、Pattern";
                            item.controller = [[HILayerLineDashController alloc] init];
                        }],
                        ];
        [weakSelf.datas addObject:group];
    }];
    
    // GradientLayer
    [HIControllerItemGroup instance:^(HIControllerItemGroup *group) {
        group.title = @"CAGradientLayer";
        group.items = @[];
        [weakSelf.datas addObject:group];
    }];
}

@end
