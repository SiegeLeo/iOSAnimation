//
//  HICALayerController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HICALayerController.h"
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self titles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CALayer"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self titles] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[self details] objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row + 1 > [self classes].count) {
        return;
    }
    
    [self.navigationController pushViewController:[[(Class)[[self classes] objectAtIndex:indexPath.row] alloc] init] animated:YES];
}


#pragma mark - getter

/**
 * 分类的标题
 * class's title
 */
- (NSArray *)titles{
    NSArray *titles = @[@"Basic",
                        @"CAAnimation",
                        @"CABasicAnimation",
                        @"CAKeyFrameAnimation",
                        @"CAGroupAnimation",
                        @"CAAnimationDelegate",
                        @"AdvancedAnimation"
                        ];
    return titles;
}

/**
 * 分类的详细描述
 * class's description
 */
- (NSArray *)details{
    NSArray *details = @[
                         NSLocalizedString(@"CABasic", nil),
                         NSLocalizedString(@"CAAnimation", nil),
                         NSLocalizedString(@"CABasicAnimation", nil),
                         NSLocalizedString(@"CAKeyFrameAnimation", nil),
                         NSLocalizedString(@"CAGroupAnimation", nil),
                         NSLocalizedString(@"CAAnimationDelegate", nil),
                         NSLocalizedString(@"CAAdvancedAnimation", nil),
                         ];
    return details;
}

/**
 * 控制器的class
 * controller's class
 */
- (NSArray *)classes{
    NSArray *classes = @[[HILayerBasicController class],
                         
                         ];
    return classes;
}

@end
