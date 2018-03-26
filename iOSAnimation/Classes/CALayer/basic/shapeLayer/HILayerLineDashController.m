//
//  HILayerLineDaseController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 26/03/2018.
//  Copyright © 2018 h_nChen. All rights reserved.
//

#import "HILayerLineDashController.h"

#define LAYER_WIDTH 200
#define MARGIN 5;
#define PADDING 20.0
#define step 20

@interface HILayerLineDashController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UISlider *slider1;
@property (nonatomic, strong) UISlider *slider2;
@property (nonatomic, strong) UISlider *slider3;

@end

@implementation HILayerLineDashController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.slider1];
    [self.view addSubview:self.slider2];
    [self.view addSubview:self.slider3];
    
    [self.view.layer addSublayer:self.shapeLayer];
    
    
    self.shapeLayer.lineDashPhase = self.slider1.value * step;
    self.shapeLayer.lineDashPattern = @[@(self.slider2.value * step), @(self.slider3.value * step)];
}


#pragma mark - getter
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake((SCREEN_W - LAYER_WIDTH) * 0.5, (SCREEN_H - LAYER_WIDTH) * 0.5 + 80, LAYER_WIDTH, LAYER_WIDTH);
        _shapeLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _shapeLayer.borderWidth = 0.5;
        
        // effect path
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 150)];
        [path addLineToPoint:CGPointMake(100, 50)];
        [path addLineToPoint:CGPointMake(150, 150)];
        
        _shapeLayer.lineWidth = 2;
        _shapeLayer.path = path.CGPath;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 1.0;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer;
}

- (UISlider *)slider1 {
    if (!_slider1) {
        CGFloat sliderW = 180;
        CGFloat sliderH = 32;
        CGFloat sliderX = (self.view.bounds.size.width - sliderW) * 0.6;
        CGFloat sliderY = 64 + MARGIN;
        _slider1 = [[UISlider alloc] init];
        _slider1.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _slider1.value = 0.5;
        [_slider1 addTarget:self action:@selector(lineDashPhaseSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"DashPhase:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        item.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:item];
    }
    return _slider1;
}

- (UISlider *)slider2 {
    if (!_slider2) {
        CGFloat sliderW = 180;
        CGFloat sliderH = 32;
        CGFloat sliderX = (self.view.bounds.size.width - sliderW) * 0.6;
        CGFloat sliderY = CGRectGetMaxY(self.slider1.frame) + MARGIN;
        _slider2 = [[UISlider alloc] init];
        _slider2.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _slider2.value = 0.5;
        [_slider2 addTarget:self action:@selector(lineDashSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"Dash:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        item.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:item];
    }
    return _slider2;
}

- (UISlider *)slider3 {
    if (!_slider3) {
        CGFloat sliderW = 180;
        CGFloat sliderH = 32;
        CGFloat sliderX = (self.view.bounds.size.width - sliderW) * 0.6;
        CGFloat sliderY = CGRectGetMaxY(self.slider2.frame) + MARGIN;
        _slider3 = [[UISlider alloc] init];
        _slider3.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _slider3.value = 0.5;
        [_slider3 addTarget:self action:@selector(linePatternSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"Pattern:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        item.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:item];
    }
    return _slider3;
}


#pragma mark - handle action
- (void)lineDashPhaseSliderChanged {
    self.shapeLayer.lineDashPhase = self.slider1.value * step;
}

- (void)lineDashSliderChanged {
    self.shapeLayer.lineDashPattern = @[@(self.slider2.value * step), @(self.slider3.value * step)];
}

- (void)linePatternSliderChanged {
    self.shapeLayer.lineDashPattern =  @[@(self.slider2.value * step), @(self.slider3.value * step)];
}

@end
