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
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *paths;
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
    
    self.shapeLayer.path = [self CGRectangle3];
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
    if (!_items) {
        NSArray *UIBezierItems = @[
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
        
        NSArray *CGPathRefItems = @[
                            @"line1",
                            @"line2",
                            @"line3",
                            @"rectangle1",
                            @"rectangle2",
                            @"rectangle3",
                            @"oval1",
                            ];
        
        _items = @[UIBezierItems, CGPathRefItems];
        
    }
    return _items;
}

- (NSArray *)paths{
    if (!_paths) {
        NSArray *UIBezierPaths = @[
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
        
        NSArray *CGPathRefPaths = @[
                                   (id)[self CGLine1],
                                   (id)[self CGLine2],
                                   (id)[self CGLine3],
                                   (id)[self CGRectangle1],
                                   (id)[self CGRectangle2],
                                   (id)[self CGRectangle3],
                                   (id)[self CGOval1]
                                   ];
        _paths = @[UIBezierPaths, CGPathRefPaths];
    }
    return _paths;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *items = [self.items objectAtIndex:section];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSArray *items = [self.items objectAtIndex:indexPath.section];
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *paths = [self.paths objectAtIndex:indexPath.section];
    if (indexPath.section == 0) {
        self.shapeLayer.path = ((UIBezierPath *)[paths objectAtIndex:indexPath.row]).CGPath;
    }else{
        self.shapeLayer.path = (__bridge CGPathRef)[paths objectAtIndex:indexPath.row];
    }
    self.tableView.hidden = YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"UIBezierPath";
    }else{
        return @"CGPathRef";
    }
}

#pragma mark - action
- (void)selctedPath{
    self.tableView.hidden = !self.tableView.hidden;
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
    [path addLineToPoint:CGPointMake(110, 110)];
    [path addLineToPoint:CGPointMake(10, 110)];
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

#pragma mark - CGPathRef : the result same as UIBezierPath
- (CGPathRef)CGLine1{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, nil, 50, 100);
    CGPathAddLineToPoint(pathRef, nil, 150, 100);
    return pathRef;
}

- (CGPathRef)CGLine2{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, nil, 50, 100);
    CGPathAddQuadCurveToPoint(pathRef, nil, 100, 150, 150, 100);
    return pathRef;
}

- (CGPathRef)CGLine3{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, nil, 50, 100);
    CGPathAddCurveToPoint(pathRef, nil, 100, 50, 100, 150, 150, 100);
    return pathRef;
}

- (CGPathRef)CGRectangle1{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, nil, CGRectMake(10, 10, 100, 100));
    return pathRef;
}

- (CGPathRef)CGRectangle2{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, nil, 10, 10);
    CGPathAddLineToPoint(pathRef, nil, 110, 10);
    CGPathAddLineToPoint(pathRef, nil, 110, 110);
    CGPathAddLineToPoint(pathRef, nil, 10, 110);
    CGPathAddLineToPoint(pathRef, nil, 10, 10);
    return pathRef;
}

- (CGPathRef)CGRectangle3{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRoundedRect(pathRef, nil, CGRectMake(50, 50, 200, 200), 50, 50);
    return pathRef;
}

- (CGPathRef)CGOval1{
    CGPathRef pathRef = CGPathCreateWithEllipseInRect(CGRectMake(50, 50, 100, 200), nil);
    return pathRef;
}

@end
