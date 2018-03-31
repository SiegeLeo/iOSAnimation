//
//  HILayerPositionController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 31/03/2018.
//  Copyright © 2018 h_nChen. All rights reserved.
//

#import "HILayerPositionController.h"

#define LAYER_WIDTH 100
#define MARGIN 20.0

@interface HILayerPositionController ()

@property (nonatomic, strong) CALayer *layer;
/* 原始的postion*/
@property (nonatomic, assign) CGPoint originPosition;
/* 显示position的点*/
@property (nonatomic, strong) CALayer *point;


@property (nonatomic, strong) UISlider *xSlider;
@property (nonatomic, strong) UISlider *ySlider;

@end

@implementation HILayerPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.layer];
    self.originPosition = self.layer.position;
    
    self.point.position = self.layer.position;
    [self.view.layer addSublayer:self.point];
    
    [self.view addSubview:self.xSlider];
    [self.view addSubview:self.ySlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (CALayer *)layer{
    if (!_layer) {
        _layer = [CALayer layer];
        _layer.frame = CGRectMake((self.view.bounds.size.width - LAYER_WIDTH) * 0.5, (self.view.bounds.size.height - LAYER_WIDTH) * 0.5, LAYER_WIDTH, LAYER_WIDTH);
        _layer.backgroundColor = [UIColor lightGrayColor].CGColor;

    }
    return _layer;
}

- (CALayer *)point {
    if (!_point) {
        _point = [CALayer layer];
        _point.backgroundColor = [UIColor redColor].CGColor;
        _point.bounds = CGRectMake(0, 0, 4, 4);
        _point.cornerRadius = 2;
        _point.masksToBounds = YES;
    }
    return _point;
}

- (UISlider *)xSlider{
    if (!_xSlider) {
        CGFloat sliderW = 180;
        CGFloat sliderH = 32;
        CGFloat sliderX = (self.view.bounds.size.width - sliderW)*0.5;
        CGFloat sliderY = 64 + MARGIN;
        _xSlider = [[UISlider alloc] init];
        _xSlider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _xSlider.value = 0.5;
        [_xSlider addTarget:self action:@selector(xSliderChanged:) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"x:    ";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 30, sliderY, 30, sliderH);
        [self.view addSubview:item];
        
    }
    return _xSlider;
}

- (UISlider *)ySlider{
    if (!_ySlider) {
        CGFloat sliderW = self.xSlider.bounds.size.width;
        CGFloat sliderH = self.xSlider.bounds.size.height;
        CGFloat sliderX = self.xSlider.frame.origin.x;
        CGFloat sliderY = CGRectGetMaxY(self.xSlider.frame) + MARGIN;
        _ySlider = [[UISlider alloc] init];
        _ySlider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _ySlider.value = 0.5;
        [_ySlider addTarget:self action:@selector(ySliderChanged:) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"y:    ";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 30, sliderY, 30, sliderH);
        [self.view addSubview:item];
    }
    return _ySlider;
}

#pragma mark - handle action

- (void)xSliderChanged:(UISlider *)slider{
    CGPoint newPosition = CGPointMake(self.originPosition.x + (slider.value - 0.5) * 100, self.layer.position.y);
    self.layer.position = newPosition;
    self.point.position = self.layer.position;
}

- (void)ySliderChanged:(UISlider *)slider{
    CGPoint newPosition = CGPointMake(self.layer.position.x, self.originPosition.y + (slider.value - 0.5) * 100);
    self.layer.position = newPosition;
    self.point.position = self.layer.position;
}
@end
