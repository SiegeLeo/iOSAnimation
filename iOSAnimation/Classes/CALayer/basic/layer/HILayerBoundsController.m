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

    CGSize size = self.blueView.layer.bounds.size;
    
    self.wSlider.valueChangeBlock = ^(float value) {
        CGFloat width = (value - 0.5) * 100  + size.width;
        [self.blueView.layer setValue:@(width) forKeyPath:@"bounds.size.width"];
    };
    self.hSlider.valueChangeBlock = ^(float value) {
        CGFloat height = (value - 0.5) * 100  + size.height;
        [self.blueView.layer setValue:@(height) forKeyPath:@"bounds.size.height"];
    };
}

- (void)viewDidLayoutSubviews {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
