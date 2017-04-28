//
//  HICALayerController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HICALayerController.h"

@interface HICALayerController ()

@end

@implementation HICALayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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


#pragma mark - getter
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

@end
