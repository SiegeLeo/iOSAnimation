//
//  HILayerBoundsController.m
//  iOSAnimation
//
//  Created by h_n on 2018/4/3.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "HILayerBoundsController.h"
#import "HISliderView.h"

@interface HILayerBoundsController ()

@property (weak, nonatomic) IBOutlet HISliderView *wSlider;

@property (weak, nonatomic) IBOutlet HISliderView *hSlider;

@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation HILayerBoundsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"bounds";
    
    CGPoint point = self.blueView.layer.frame.origin;
    CGSize size = self.blueView.layer.bounds.size;
    
    self.wSlider.valueChangeBlock = ^(float value) {
        CGFloat width = (value - 0.5) * 100  + size.width;
        self.blueView.layer.bounds = CGRectMake(point.x, point.y, width, self.blueView.layer.frame.size.height);
    };
    
    self.hSlider.valueChangeBlock = ^(float value) {
        CGFloat height = (value - 0.5) * 100  + size.height;
        self.blueView.layer.bounds = CGRectMake(point.x, point.y, self.blueView.layer.frame.size.width, height);
    };
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
