//
//  HILayerMaskController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/5/2.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerMaskController.h"

#define MARGIN 20.0
#define LAYER_WIDTH 100

@interface HILayerMaskController ()

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, strong) UISlider *xSlider;
@property (nonatomic, strong) UISlider *ySlider;

@end

@implementation HILayerMaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Mask";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view.layer addSublayer:self.layer];
    [self.layer addSublayer:self.maskLayer];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"mask" style:UIBarButtonItemStylePlain target:self action:@selector(makeMask)];
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
        _layer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _layer;
}

- (CALayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.frame =  CGRectMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds), LAYER_WIDTH, LAYER_WIDTH);
        _maskLayer.backgroundColor = [UIColor blueColor].CGColor;
        _maskLayer.cornerRadius = LAYER_WIDTH * 0.5;
        _maskLayer.masksToBounds = YES;
        
        /* open this code and remove maskLayer's backgroundColor, the superLayer.mask shape will became this image shape
         * 打开这段代码并且移除maskLayer的背景色，蒙板的形状将变成图片的形状
         
         _maskLayer.contents = (id)[UIImage imageNamed:@"huaji"].CGImage;
         */
    }
    return _maskLayer;
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

#pragma mark - action
- (void)makeMask{
    [self.maskLayer removeFromSuperlayer];
    self.layer.mask = self.maskLayer;
    [self.view addSubview:self.xSlider];
    [self.view addSubview:self.ySlider];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
}

- (void)done{
    self.layer.mask = nil;
    [self.layer addSublayer:self.maskLayer];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"mask" style:UIBarButtonItemStylePlain target:self action:@selector(makeMask)];
}

- (void)xSliderChanged:(UISlider *)slider{
    CGFloat distanceX = (slider.value - 0.5)*(self.maskLayer.bounds.size.width / 0.5);
    CGFloat distanceY = self.maskLayer.frame.origin.y;
    self.maskLayer.frame = CGRectMake(distanceX, distanceY, self.maskLayer.bounds.size.width, self.maskLayer.bounds.size.height);
}

- (void)ySliderChanged:(UISlider *)slider{
    CGFloat distanceX = self.maskLayer.frame.origin.x;
    CGFloat distanceY = (slider.value - 0.5)*(self.maskLayer.bounds.size.width / 0.5);
    self.maskLayer.frame = CGRectMake(distanceX, distanceY, self.maskLayer.bounds.size.width, self.maskLayer.bounds.size.height);
}
@end
