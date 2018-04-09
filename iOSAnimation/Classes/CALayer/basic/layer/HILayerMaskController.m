//
//  HILayerMaskController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/5/2.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerMaskController.h"
#import "HISliderView.h"
#import "UISegmentedControl+HICategory.h"

@interface HILayerMaskController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegment;

@property (weak, nonatomic) IBOutlet HISliderView *xSliderView;
@property (weak, nonatomic) IBOutlet HISliderView *ySliderView;

@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *pinkView;
@property (nonatomic, strong) UIColor *originColor;

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation HILayerMaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    self.layer = self.blueView.layer;
    self.maskLayer = self.pinkView.layer;
    self.originColor = self.pinkView.backgroundColor;
    
    __weak typeof(self) weakSelf = self;
    
    self.modeSegment.hi_clickedBlock = ^(UISegmentedControl *segment) {
        if (segment.selectedSegmentIndex == 0) {
            weakSelf.maskLayer.backgroundColor = weakSelf.originColor.CGColor;
            weakSelf.maskLayer.contents = nil;
        }
        if (segment.selectedSegmentIndex == 1) {
            weakSelf.maskLayer.backgroundColor = [UIColor clearColor].CGColor;
            weakSelf.maskLayer.contents = (id)[UIImage imageNamed:@"huaji"].CGImage;
        }
        weakSelf.layer.mask = weakSelf.maskLayer;
    };
    
    CGPoint origin = self.maskLayer.position;
    self.xSliderView.valueChangeBlock = ^(float value) {
        CGFloat newX = origin.x + (value - 0.5) * 100;
        [weakSelf.maskLayer setValue:@(newX) forKeyPath:@"position.x"];
    };
    
    self.ySliderView.valueChangeBlock = ^(float value) {
        CGFloat newY = origin.y + (value - 0.5) * 100;
        [weakSelf.maskLayer setValue:@(newY) forKeyPath:@"position.y"];
    };
}

#pragma mark - action

- (IBAction)cleanMask:(id)sender {
    self.layer.mask = nil;
    
    [self.blueView addSubview:self.pinkView];
    self.maskLayer.backgroundColor = self.originColor.CGColor;
    self.maskLayer.contents = nil;
}

@end
