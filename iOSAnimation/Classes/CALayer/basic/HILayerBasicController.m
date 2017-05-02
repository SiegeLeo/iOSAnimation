//
//  HILayerBasicController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerBasicController.h"

#import "HILayerTransformController.h"
#import "HILayerMaskController.h"

@interface HILayerBasicController ()

@end

@implementation HILayerBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"layerTitleBasic", nil);
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self propertyTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)[[self propertyTitles] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ids = @"layerBasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ids];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ids];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[[self propertyTitles] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[[self propertyDetails] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[self titles] objectAtIndex:section];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row + 1 > [[[self classes] objectAtIndex:indexPath.section] count]) {
        return;
    }
    Class class = [[[self classes] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:[[class alloc] init] animated:YES];
}


#pragma mark - getter

/**
 * 分类标题
 * class's titles
 */
- (NSArray *)titles{
    NSArray *titles = @[
                        @"CALayer",
                        @"CAShapeLayer",
                        @"CAGradientLayer"
                        ];
    
    return titles;
}

/**
 * 属性标题
 * propertyTitles
 */
- (NSArray *)propertyTitles{
    NSArray *propertyTitles = @[
                                [self layerProperties],
                                [self shapeLayerProperties],
                                [self gradientLayerProperties]
                                ];
    return propertyTitles;
}

/**
 * layer的属性
 * layer's properties
 */
- (NSArray *)layerProperties{
    NSArray *layerProperties = @[
                                 @"transform",
                                 @"mask",
                                 ];
    return layerProperties;
}

/**
 * shapeLayer的属性
 * shapeLayer's properties
 */
- (NSArray *)shapeLayerProperties{
    NSArray *shapeLayerProperties = @[
                                      @"path",
                                      @"strokeColor",
                                      ];
    return shapeLayerProperties;
}

/**
 * gradientLayer的属性
 * gradientLayer's properties
 */
- (NSArray *)gradientLayerProperties{
    NSArray *gradientLayerProperties = @[];
    return gradientLayerProperties;
}

/**
 * 属性的备注
 * property's description
 */
- (NSArray *)propertyDetails{
    NSArray *propertyDetails = @[
                                [self layerPropertyDetails],
                                [self shapeLayerPropertyDetails],
                                [self gradientLayerPropertyDetails]
                                ];
    return propertyDetails;
}

/**
 * layer的属性
 * layer's descriptions
 */
- (NSArray *)layerPropertyDetails{
    NSArray *layerPropertyDetails = @[
                                      @"Class: HILayerTransformController, transform",
                                      @"Class: HILayerMaskController, mask",
                                     ];
    return layerPropertyDetails;
}

/**
 * shapeLayer的属性
 * shapeLayer's descriptions
 */
- (NSArray *)shapeLayerPropertyDetails{
    NSArray *shapeLayerPropertyDetails = @[
                                          @"Class: ",
                                          @"Class: ",
                                          ];
    return shapeLayerPropertyDetails;
}

/**
 * gradientLayer的属性
 * gradientLayer's descriptions
 */
- (NSArray *)gradientLayerPropertyDetails{
    NSArray *gradientLayerPropertyDetails = @[];
    return gradientLayerPropertyDetails;
}

/**
 * controller's classes
 * controller's classse
 */
- (NSArray *)classes{
    NSArray *classes = @[
                         [self layerClasses],
                         [self shapeLayerClasses],
                         [self gradientLayerClasses],
                         ];
    return classes;
}

/**
 * layerContrller's classes
 * layerContrller's classes
 */
- (NSArray *)layerClasses{
    NSArray *layerClasses = @[
                              [HILayerTransformController class],
                              [HILayerMaskController class]
                              ];
    return layerClasses;
}
/**
 * shapeLayerContrller's classes
 * shapeLayerContrller's classes
 */
- (NSArray *)shapeLayerClasses{
    NSArray *shapeLayerClasses = @[];
    return shapeLayerClasses;
}
/**
 * gradientLayerContrller's classes
 * gradientLayerContrller's classes
 */
- (NSArray *)gradientLayerClasses{
    NSArray *gradientLayerClasses = @[];
    return gradientLayerClasses;
}


@end
