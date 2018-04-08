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
}

- (void)viewDidLayoutSubviews {
    __weak typeof(self) weakSelf = self;
    self.wSlider.valueChangeBlock = ^(float value) {
        CGFloat width = (value - 0.5) * 100  + weakSelf.blueView.layer.bounds.size.width;
        [weakSelf.blueView.layer setValue:@(width) forKeyPath:@"bounds.size.width"];
        
        /* bounds also can be changed in the way
         [weakSelf.blueView.layer setValue:[NSValue valueWithCGRect:CGRectMake(0, 0, width, weakSelf.blueView.layer.bounds.size.height)] forKey:@"bounds"];
         */
    };
    
    self.hSlider.valueChangeBlock = ^(float value) {
        CGFloat height = (value - 0.5) * 100  + weakSelf.blueView.layer.bounds.size.height;
        [weakSelf.blueView.layer setValue:@(height) forKeyPath:@"bounds.size.height"];
        
        /* bounds also can be changed in the way
         [weakSelf.blueView.layer setValue:[NSValue valueWithCGRect:CGRectMake(0, 0, width = weakSelf.blueView.layer.bounds.size.width, height)] forKey:@"bounds"];
         */
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
