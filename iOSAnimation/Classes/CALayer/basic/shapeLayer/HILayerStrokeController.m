//
//  HIStrokeColorController.m
//  iOSAnimation
//
//  Created by h_n on 2018/3/20.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "HILayerStrokeController.h"

@interface HILayerStrokeController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UISlider *rSlider;
@property (nonatomic, strong) UISlider *gSlider;
@property (nonatomic, strong) UISlider *bSlider;

@property (nonatomic, strong) UISlider *sSlider;
@property (nonatomic, strong) UISlider *eSlider;

@end

@implementation HILayerStrokeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStyleDone target:self action:@selector(handleReset)];
    
    [self.view addSubview:self.rSlider];
    [self.view addSubview:self.gSlider];
    [self.view addSubview:self.bSlider];
    [self.view addSubview:self.sSlider];
    [self.view addSubview:self.eSlider];
    
    [self.view.layer addSublayer:self.shapeLayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getter
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake((self.view.bounds.size.width - LAYER_WIDTH) * 0.5, (self.view.bounds.size.height - LAYER_WIDTH) * 0.5 + 80, LAYER_WIDTH, LAYER_WIDTH);
        _shapeLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _shapeLayer.borderWidth = 0.5;
        
        // effect path
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
        _shapeLayer.lineWidth = 2;
        _shapeLayer.path = path.CGPath;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 1.0;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer;
}

- (UISlider *)rSlider{
    if (!_rSlider) {
        CGFloat sliderW = 180;
        CGFloat sliderH = 32;
        CGFloat sliderX = (self.view.bounds.size.width - sliderW) * 0.6;
        CGFloat sliderY = 64 + MARGIN;
        _rSlider = [[UISlider alloc] init];
        _rSlider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _rSlider.value = 0.5;
        [_rSlider addTarget:self action:@selector(colorSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"color_R:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        [self.view addSubview:item];
    }
    return _rSlider;
}

- (UISlider *)gSlider{
    if (!_gSlider) {
        CGFloat sliderW = self.rSlider.bounds.size.width;
        CGFloat sliderH = self.rSlider.bounds.size.height;
        CGFloat sliderX = self.rSlider.frame.origin.x;
        CGFloat sliderY = CGRectGetMaxY(self.rSlider.frame) + MARGIN;
        _gSlider = [[UISlider alloc] init];
        _gSlider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _gSlider.value = 0.5;
        [_gSlider addTarget:self action:@selector(colorSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"color_G:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        [self.view addSubview:item];
    }
    return _gSlider;
}

- (UISlider *)bSlider{
    if (!_bSlider) {
        CGFloat sliderW = self.gSlider.bounds.size.width;
        CGFloat sliderH = self.gSlider.bounds.size.height;
        CGFloat sliderX = self.gSlider.frame.origin.x;
        CGFloat sliderY = CGRectGetMaxY(self.gSlider.frame) + MARGIN;
        _bSlider = [[UISlider alloc] init];
        _bSlider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _bSlider.value = 0.5;
        [_bSlider addTarget:self action:@selector(colorSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"color_B:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        [self.view addSubview:item];
    }
    return _bSlider;
}

- (UISlider *)sSlider{
    if (!_sSlider) {
        CGFloat sliderW = self.bSlider.bounds.size.width;
        CGFloat sliderH = self.bSlider.bounds.size.height;
        CGFloat sliderX = self.bSlider.frame.origin.x;
        CGFloat sliderY = CGRectGetMaxY(self.bSlider.frame) + MARGIN;
        _sSlider = [[UISlider alloc] init];
        _sSlider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _sSlider.value = 0;
        [_sSlider addTarget:self action:@selector(pathSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"strokeStart:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        item.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:item];
    }
    return _sSlider;
}

- (UISlider *)eSlider{
    if (!_eSlider) {
        CGFloat sliderW = self.sSlider.bounds.size.width;
        CGFloat sliderH = self.sSlider.bounds.size.height;
        CGFloat sliderX = self.sSlider.frame.origin.x;
        CGFloat sliderY = CGRectGetMaxY(self.sSlider.frame) + MARGIN;
        _eSlider = [[UISlider alloc] init];
        _eSlider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _eSlider.value = 1;
        [_eSlider addTarget:self action:@selector(pathSliderChanged) forControlEvents:UIControlEventValueChanged];
        
        UILabel *item = [[UILabel alloc] init];
        item.text = @"strokeEnd:";
        item.textAlignment = NSTextAlignmentRight;
        item.frame = CGRectMake(sliderX - 80, sliderY, 80, sliderH);
        item.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:item];
    }
    return _eSlider;
}

#pragma mark - handle action
- (void)handleReset {
    self.rSlider.value = 0.5;
    self.gSlider.value = 0.5;
    self.bSlider.value = 0.5;
    
    self.sSlider.value = 0.0;
    self.eSlider.value = 1.0;
    
    [self colorSliderChanged];
    [self pathSliderChanged];
}

/**
 * 调整strokeColor的值
 */
- (void)colorSliderChanged {
    self.shapeLayer.strokeColor = [UIColor colorWithRed:self.rSlider.value green:self.gSlider.value blue:self.bSlider.value alpha:1].CGColor;
}

/**
 * 调整start和end的值
 */
- (void)pathSliderChanged {
    self.shapeLayer.strokeStart = self.sSlider.value;
    self.shapeLayer.strokeEnd = self.eSlider.value;
}


@end
