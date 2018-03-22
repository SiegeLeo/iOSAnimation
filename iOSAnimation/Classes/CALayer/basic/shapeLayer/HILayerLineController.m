//
//  HILayerLineController.m
//  iOSAnimation
//
//  Created by h_n on 2018/3/22.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "HILayerLineController.h"

#define LAYER_WIDTH 200
#define MARGIN 5;
#define PADDING 20.0

@interface HILayerLineController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UISlider *slider2;
@property (nonatomic, strong) UISegmentedControl *segment1;
@property (nonatomic, strong) UISegmentedControl *segment2;

@end

@implementation HILayerLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.slider];
    [self.view addSubview:self.slider2];
    [self.view addSubview:self.segment1];
    [self.view addSubview:self.segment2];
    
    [self.view.layer addSublayer:self.shapeLayer];
}

#pragma mark - getter
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake((SCREEN_W - LAYER_WIDTH) * 0.5, (SCREEN_H - LAYER_WIDTH) * 0.5 + 80, LAYER_WIDTH, LAYER_WIDTH);
        _shapeLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _shapeLayer.borderWidth = 0.5;
        
        // effect path
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(80, 120)];
        [path addLineToPoint:CGPointMake(100, 50)];
        [path addLineToPoint:CGPointMake(120, 120)];
        
        _shapeLayer.lineWidth = 2;
        _shapeLayer.path = path.CGPath;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 1.0;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer;
}

- (UISlider *)slider{
    if (!_slider) {
        CGFloat sliderW = 180;
        CGFloat sliderH = 32;
        CGFloat sliderX = (self.view.bounds.size.width - sliderW) * 0.6;
        CGFloat sliderY = 64 + MARGIN;
        _slider = [[UISlider alloc] init];
        _slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _slider.value = 0.5;
        [_slider addTarget:self action:@selector(lineWidthSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"lineWidth:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        [self.view addSubview:item];
    }
    return _slider;
}

- (UISlider *)slider2{
    if (!_slider2) {
        CGFloat sliderW = 180;
        CGFloat sliderH = 32;
        CGFloat sliderX = (self.view.bounds.size.width - sliderW) * 0.6;
        CGFloat sliderY = CGRectGetMaxY(self.slider.frame) + MARGIN;
        _slider2 = [[UISlider alloc] init];
        _slider2.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _slider2.value = 0.5;
        [_slider2 addTarget:self action:@selector(miterLimitSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"miterLimit:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        item.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:item];
    }
    return _slider2;
}

- (UISegmentedControl *)segment1{
    if (!_segment1) {
        NSArray *items = @[@"oinMiter", @"JoinBevel", @"JoinRound"];
        CGFloat segmentW = items.count * 80;
        CGFloat segmentH = 32;
        CGFloat segmentX = (SCREEN_W - segmentW) / 2;
        CGFloat segmentY = CGRectGetMaxY(self.slider2.frame) + PADDING;
        
        _segment1 = [[UISegmentedControl alloc] initWithItems:items];
        _segment1.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
        _segment1.selectedSegmentIndex = 0;
        [_segment1 addTarget:self action:@selector(selectedLineJoin:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment1;
}

- (UISegmentedControl *)segment2{
    if (!_segment2) {
        NSArray *items = @[@"CapButt", @"CapRound", @"CapSquare"];
        CGFloat segmentW = items.count * 80;
        CGFloat segmentH = 32;
        CGFloat segmentX = (SCREEN_W - segmentW) / 2;
        CGFloat segmentY = CGRectGetMaxY(self.segment1.frame) + PADDING;
        
        _segment2 = [[UISegmentedControl alloc] initWithItems:items];
        _segment2.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
        _segment2.selectedSegmentIndex = 0;
        [_segment2 addTarget:self action:@selector(selectedLineCap:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment2;
}

#pragma mark - handle action
- (void)lineWidthSliderChanged {
    self.shapeLayer.lineWidth = self.slider.value * 20;
}

- (void)miterLimitSliderChanged {
    self.shapeLayer.miterLimit = self.slider2.value * 20;
}

- (void)selectedLineJoin:(UISegmentedControl *)control {
    switch (control.selectedSegmentIndex) {
        case 0:
            self.shapeLayer.lineJoin = kCALineJoinMiter;
            break;
        case 1:
            self.shapeLayer.lineJoin = kCALineJoinBevel;
            break;
        case 2:
            self.shapeLayer.lineJoin = kCALineJoinRound;
            break;
        default:
            break;
    }
}

- (void)selectedLineCap:(UISegmentedControl *)control {
    switch (control.selectedSegmentIndex) {
        case 0:
            self.shapeLayer.lineCap = kCALineCapButt;
            break;
        case 1:
            self.shapeLayer.lineCap = kCALineCapRound;
            break;
        case 2:
            self.shapeLayer.lineCap = kCALineCapSquare;
            break;
        default:
            break;
    }
}
@end
