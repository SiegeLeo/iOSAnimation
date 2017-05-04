//
//  HILayerPathController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/5/3.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerPathController.h"

#define LAYER_WIDTH 300

@interface HILayerPathController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HILayerPathController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"path";
    
    [self.view.layer addSublayer:self.shapeLayer];
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"select" style:UIBarButtonItemStylePlain target:self action:@selector(selctedPath)];
}

#pragma mark - getter
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake((self.view.bounds.size.width - LAYER_WIDTH) * 0.5, (self.view.bounds.size.height - LAYER_WIDTH) * 0.5, LAYER_WIDTH, LAYER_WIDTH);
        _shapeLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _shapeLayer.borderWidth = 0.5;
        
        // effect path stroke
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 1.0;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.hidden = YES;
    }
    return _tableView;
}

- (NSArray *)items{
    NSArray *items = @[
                       @"line1",
                       @"line2",
                       @"line3",
                       @"rectangle1",
                       @"rectangle2",
                       @"rectangle3",
                       @"oval1",
                       @"oval2",
                       @"oval3",
                       ];
    return items;
}

- (NSArray *)paths{
    NSArray *paths = @[
                       [self line1],
                       [self line2],
                       [self line3],
                       [self rectangle1],
                       [self rectangle2],
                       [self rectangle3],
                       [self oval1],
                       [self oval2],
                       [self oval3]
                       ];
    return paths;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self items] .count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[self items] objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.shapeLayer.path = ((UIBezierPath *)[[self paths] objectAtIndex:indexPath.row]).CGPath;
    self.tableView.hidden = YES;
}

#pragma mark - action
- (void)selctedPath{
    self.tableView.hidden = NO;
}

#pragma mark - UIBezierPath
- (UIBezierPath *)line1{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 50)];
    [path addLineToPoint:CGPointMake(self.shapeLayer.bounds.size.width - 100, 50)];
    return path;
}

- (UIBezierPath *)line2{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 100)];
    [path addQuadCurveToPoint:CGPointMake(150, 100) controlPoint:CGPointMake(100, 50)];
    return path;
}

- (UIBezierPath *)line3{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 100)];
    [path addCurveToPoint:CGPointMake(150, 100) controlPoint1:CGPointMake(100, 50) controlPoint2:CGPointMake(100, 150)];
    return path;
}

- (UIBezierPath *)rectangle1{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 100, 100)];
    return path;
}

- (UIBezierPath *)rectangle2{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(110, 10)];
    
    [path moveToPoint:CGPointMake(110, 10)];
    [path addLineToPoint:CGPointMake(110, 110)];
    
    [path moveToPoint:CGPointMake(110, 110)];
    [path addLineToPoint:CGPointMake(10, 110)];
    
    [path moveToPoint:CGPointMake(10, 110)];
    [path addLineToPoint:CGPointMake(10, 10)];
    
    return path;
}

- (UIBezierPath *)rectangle3{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 200, 200) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(100, 0)];
    return path;
}

- (UIBezierPath *)oval1{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 200)];
    return path;
}

- (UIBezierPath *)oval2{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    return path;
}

- (UIBezierPath *)oval3{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 200) cornerRadius:50];
    return path;
}



@end
