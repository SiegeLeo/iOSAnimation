//
//  HILayerContentsController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/5/2.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerContentsController.h"

#define MARGIN 20.0
#define LAYER_WIDTH 100

@interface HILayerContentsController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *clip;
@end

@implementation HILayerContentsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"contents";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view.layer addSublayer:self.layer];
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = self.clip;
}


#pragma mark - getter

- (CALayer *)layer{
    if (!_layer) {
        _layer = [CALayer layer];
        _layer.frame = CGRectMake((self.view.bounds.size.width - LAYER_WIDTH) * 0.5, (self.view.bounds.size.height - LAYER_WIDTH), LAYER_WIDTH, LAYER_WIDTH);
        _layer.backgroundColor = [UIColor redColor].CGColor;
        _layer.contents = (id)[UIImage imageNamed:@"tree"].CGImage;
    }
    return _layer;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height-LAYER_WIDTH))];
        _tableView.rowHeight = 32;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)gravities{
    NSArray *gravities = @[
                           kCAGravityCenter,
                           kCAGravityTop,
                           kCAGravityBottom,
                           kCAGravityLeft,
                           kCAGravityRight,
                           kCAGravityTopLeft,
                           kCAGravityTopRight,
                           kCAGravityBottomLeft,
                           kCAGravityBottomRight,
                           kCAGravityResize,
                           kCAGravityResizeAspect,
                           kCAGravityResizeAspectFill
                           ];
    return gravities;
}

- (UIBarButtonItem *)clip{
    if (!_clip) {
        _clip = [[UIBarButtonItem alloc] initWithTitle:@"clip" style:UIBarButtonItemStylePlain target:self action:@selector(layerClip)];
    }
    return _clip;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self gravities].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[self gravities] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.layer.contentsGravity = [[self gravities] objectAtIndex:indexPath.row];
}

#pragma mark - action
- (void)layerClip{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString: @"done"]){
        self.navigationItem.rightBarButtonItem.title = @"clip";
        self.layer.masksToBounds = NO;
    }else{
        self.navigationItem.rightBarButtonItem.title = @"done";
        self.layer.masksToBounds = YES;
    }
}

@end
