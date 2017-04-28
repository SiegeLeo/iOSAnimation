//
//  HILayerTransformController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerTransformController.h"

@interface HILayerTransformController ()

@property (nonatomic, strong) CALayer *layer;

@property (nonatomic, strong) UISegmentedControl *actionSegment;

@property (nonatomic, strong) UISegmentedControl *directionSegment;

@property (nonatomic, strong) UISlider *slider;
@end

@implementation HILayerTransformController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"transform";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.layer];
    [self.view addSubview:self.actionSegment];
    [self.view addSubview:self.directionSegment];
    [self.view addSubview:self.slider];
    
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithTitle:@"action" style:UIBarButtonItemStylePlain target:self action:@selector(action)],
                                                [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset)],
                                                ];
}

#pragma mark - getter
- (CALayer *)layer{
    if (!_layer) {
        _layer = [CALayer layer];
        _layer.frame = CGRectMake(100, 200, 100, 100);
        _layer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _layer;
}

- (UISegmentedControl *)actionSegment{
    if (!_actionSegment) {
        _actionSegment = [[UISegmentedControl alloc] initWithItems:@[@"translate", @"scale", @"rotate"]];
        _actionSegment.frame = CGRectMake(10, 74, 48 * 4, 32);
        [_actionSegment addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionSegment;
}


- (UISegmentedControl *)directionSegment{
    if (!_directionSegment) {
        _directionSegment = [[UISegmentedControl alloc] initWithItems:@[@"x", @"y", @"z"]];
        _directionSegment.frame = CGRectMake(10, 120, 48 * 4, 32);
        [_directionSegment addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _directionSegment;
}

- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.frame = CGRectMake(10, 180, 48 * 4, 10);
        _slider.value = 0.5;
        [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

#pragma mark - private
- (void)selectedSegment:(UISegmentedControl *)segment{
    
}

- (void)sliderChanged:(UISlider *)slider{
    NSLog(@"the value is %f", slider.value);
}

#pragma mark - action
- (void)action{

}

- (void)reset{
    
}
@end
