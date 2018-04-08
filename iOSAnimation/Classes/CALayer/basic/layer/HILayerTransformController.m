//
//  HILayerTransformController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 17/4/28.
//  Copyright © 2017年 h_nChen. All rights reserved.
//

#import "HILayerTransformController.h"

#define ITEM_WIDTH  64.0
#define ITEM_HEIGHT 32.0
#define MARGIN 20.0
#define LAYER_WIDTH 100

@interface HILayerTransformController ()

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CALayer *benchmarkLayer;

@property (nonatomic, strong) UILabel *tips;

@property (nonatomic, strong) UISegmentedControl *modeSegment;
@property (nonatomic, strong) UISegmentedControl *actionSegment;
@property (nonatomic, strong) UISegmentedControl *directionSegment;
@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, assign) CALayerTransformDirection direction;
@property (nonatomic, assign) CALayerTransformAction action;

@end

@implementation HILayerTransformController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"transform";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view.layer addSublayer:self.layer];
    [self.view.layer addSublayer:self.benchmarkLayer];
    
    [self.view addSubview:self.tips];
    
    [self.view addSubview:self.actionSegment];
    [self.view addSubview:self.directionSegment];
    [self.view addSubview:self.slider];
    
    self.navigationItem.titleView = self.modeSegment;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    
    [self reset];
    
}

#pragma mark - getter
- (CALayer *)layer{
    if (!_layer) {
        _layer = [CALayer layer];
        _layer.frame = CGRectMake((self.view.bounds.size.width - LAYER_WIDTH) * 0.5, (self.view.bounds.size.height - LAYER_WIDTH) * 0.5, LAYER_WIDTH, LAYER_WIDTH);
        _layer.backgroundColor = [UIColor redColor].CGColor;
        
        /* open this code, the layer will display a image, help observing the change
         * 打开这段代码，该layer将显示一个图片，有助于观察变化
         
        _layer.contents = (id)[UIImage imageNamed:@"huaji"].CGImage;
         */
    }
    return _layer;
}

- (CALayer *)benchmarkLayer{
    if (!_benchmarkLayer) {
        _benchmarkLayer = [CALayer layer];
        _benchmarkLayer.frame = CGRectMake(CGRectGetMidX(self.layer.frame), CGRectGetMidY(self.layer.frame), LAYER_WIDTH, LAYER_WIDTH);
        _benchmarkLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _benchmarkLayer;
}

-(UILabel *)tips{
    if (!_tips) {
        _tips = [[UILabel alloc] init];
        _tips.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _tips.text = NSLocalizedString(@"CALayerTransformTips", nil);
        _tips.textColor = [UIColor whiteColor];
        _tips.font = [UIFont boldSystemFontOfSize:20];
        _tips.numberOfLines = 0;
        _tips.textAlignment = NSTextAlignmentCenter;
        _tips.frame = CGRectMake(0, 0, self.view.bounds.size.width, ITEM_HEIGHT);
        [_tips sizeToFit];
        _tips.center = CGPointMake(self.view.bounds.size.width * 0.5, (self.view.bounds.size.height - _tips.frame.size.height - MARGIN) + (_tips.frame.size.height * 0.5));
    }
    return _tips;
}

- (UISegmentedControl *)modeSegment{
    if (!_modeSegment) {
        NSArray *items = @[@"Transform3D", @"forKeyPath"];
        CGFloat segmentW = items.count * ITEM_WIDTH;
        CGFloat segmentH = ITEM_HEIGHT;
        CGFloat segmentX = 0;
        CGFloat segmentY = 0;
        
        _modeSegment = [[UISegmentedControl alloc] initWithItems:items];
        _modeSegment.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
        _modeSegment.selectedSegmentIndex = CALayerTransformMode3D;
        [_modeSegment addTarget:self action:@selector(selectedMode:) forControlEvents:UIControlEventValueChanged];
    }
    return _modeSegment;
}


- (UISegmentedControl *)actionSegment{
    if (!_actionSegment) {
        NSArray *items = @[@"translate", @"scale", @"rotate"];
        CGFloat segmentW = items.count * ITEM_WIDTH;
        CGFloat segmentH = ITEM_HEIGHT;
        CGFloat segmentX = (self.view.bounds.size.width - segmentW) * 0.5;
        CGFloat segmentY = 64 + MARGIN;
        
        _actionSegment = [[UISegmentedControl alloc] initWithItems:items];
        _actionSegment.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
        _actionSegment.selectedSegmentIndex = CALayerTransformActionTranslate;
        [_actionSegment addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _actionSegment;
}


- (UISegmentedControl *)directionSegment{
    if (!_directionSegment) {
        NSArray *items = @[@"x", @"y", @"z"];
        CGFloat segmentW = items.count * ITEM_WIDTH;
        CGFloat segmentH = ITEM_HEIGHT;
        CGFloat segmentX = (self.view.bounds.size.width - segmentW) * 0.5;
        CGFloat segmentY = CGRectGetMaxY(self.actionSegment.frame) + MARGIN;
        
        _directionSegment = [[UISegmentedControl alloc] initWithItems:items];
        _directionSegment.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
        _directionSegment.selectedSegmentIndex = CALayerTransformDirectionX;
        [_directionSegment addTarget:self action:@selector(selectedDirection:) forControlEvents:UIControlEventValueChanged];
    }
    return _directionSegment;
}

- (UISlider *)slider{
    if (!_slider) {
        CGFloat sliderW = self.directionSegment.frame.size.width;
        CGFloat sliderH = self.directionSegment.frame.size.height;
        CGFloat sliderX = self.directionSegment.frame.origin.x;
        CGFloat sliderY = CGRectGetMaxY(self.directionSegment.frame) + MARGIN;
        _slider = [[UISlider alloc] init];
        _slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        _slider.value = 0.5;
        [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}


#pragma mark - action
- (void)selectedMode:(UISegmentedControl *)segment{
    [self reset];
}

- (void)selectedDirection:(UISegmentedControl *)segment{
    self.direction = segment.selectedSegmentIndex;
    [self reset];
}

- (void)selectedAction:(UISegmentedControl *)segment{
    self.action = segment.selectedSegmentIndex;
    [self reset];
}

- (void)sliderChanged:(UISlider *)slider{
    if (self.modeSegment.selectedSegmentIndex == CALayerTransformMode3D) {
        switch (self.action) {
            case CALayerTransformActionTranslate:
                [self translate:slider.value];
                break;
            case CALayerTransformActionRotate:
                [self rotate:slider.value];
                break;
            case CALayerTransformActionScale:
                [self scale:slider.value];
                break;
            default:
                break;
        }
    } else {
            switch (self.action) {
                case CALayerTransformActionTranslate:
                    [self setTranslation:slider.value];
                    break;
                case CALayerTransformActionRotate:
                    [self setRotation:slider.value];
                    break;
                case CALayerTransformActionScale:
                    [self setScale:slider.value];
                    break;
                default:
                    break;
            }
        }
     
}

/**
 * set layer's default transform
 * 重置layer的变化
 */
- (void)reset{
    self.slider.value = 0.5;
    self.layer.transform = CATransform3DIdentity;
    
    if (self.direction == CALayerTransformDirectionZ && self.action == CALayerTransformActionTranslate) {
        // show the benchmark layer
        self.benchmarkLayer.hidden = NO;
        // show tips
        self.tips.hidden = NO;
    }else{
        // hide the benchmark layer
        self.benchmarkLayer.hidden = YES;
        // hide the tips
        self.tips.hidden = YES;
    }
}

#pragma mark - private

/**
 * translate by CATransform3D
 * 通过CATransform3D控制位移
 */
- (void)translate:(CGFloat)value{
    CGFloat tx = 0;
    CGFloat ty = 0;
    CGFloat tz = 0;
    
    switch (self.direction) {
        case CALayerTransformDirectionX:
            tx = (value - 0.5) * 100;
            break;
        case CALayerTransformDirectionY:
            ty = (value - 0.5) * 100;
            break;
        case CALayerTransformDirectionZ:
            tz = (value - 0.5) * 100;
            break;
        default:
            break;
    }
    self.layer.transform = CATransform3DTranslate(CATransform3DIdentity, tx, ty, tz);
}

/**
 * rotate by CATransform3D
 * 通过CATransform3D控制旋转
 */
- (void)rotate:(CGFloat)value{
    CGFloat dx = 0;
    CGFloat dy = 0;
    CGFloat dz = 0;
    
    CGFloat angle = (value - 0.5) * (M_PI / 0.5);
    
    switch (self.direction) {
        case CALayerTransformDirectionX:
            dx = 1;
            break;
        case CALayerTransformDirectionY:
            dy = 1;
            break;
        case CALayerTransformDirectionZ:
            dz = 1;
            break;
        default:
            break;
    }
    self.layer.transform = CATransform3DRotate(CATransform3DIdentity, angle, dx, dy, dz);
}

/**
 * scale by CATransform3D
 * 通过CATransform3D控制缩放
 */
- (void)scale:(CGFloat)value{
    CGFloat sx = 1;
    CGFloat sy = 1;
    CGFloat sz = 1;
    
    switch (self.direction) {
        case CALayerTransformDirectionX:
            sx = sx + (value - 0.5) * 2;
            break;
        case CALayerTransformDirectionY:
            sy = sy + (value - 0.5) * 2;
            break;
        case CALayerTransformDirectionZ:
            sz = sz + (value - 0.5) * 2;
            break;
        default:
            break;
    }
    self.layer.transform = CATransform3DScale(CATransform3DIdentity, sx, sy, sz);
}

// transform.translation.x/y/z
- (void)setTranslation:(CGFloat)value{
    CGFloat distance = (value - 0.5) * 100;
    switch (self.direction) {
        case CALayerTransformDirectionX:
            [self.layer setValue:@(distance) forKeyPath:@"transform.translation.x"];
            break;
        case CALayerTransformDirectionY:
            [self.layer setValue:@(distance) forKeyPath:@"transform.translation.y"];
            break;
        case CALayerTransformDirectionZ:
            [self.layer setValue:@(distance) forKeyPath:@"transform.translation.z"];
            break;
        default:
            break;
    }
}

// transform.rotation.x/y/z
- (void)setRotation:(CGFloat)value{
    
    CGFloat angle = (value - 0.5) * (M_PI / 0.5);
    
    switch (self.direction) {
        case CALayerTransformDirectionX:
            [self.layer setValue:@(angle) forKeyPath:@"transform.rotation.x"];
            break;
        case CALayerTransformDirectionY:
            [self.layer setValue:@(angle) forKeyPath:@"transform.rotation.y"];
            break;
        case CALayerTransformDirectionZ:
            [self.layer setValue:@(angle) forKeyPath:@"transform.rotation.z"];
            break;
        default:
            break;
    }
}

// transfor.scale.x/y/z
- (void)setScale:(CGFloat)value{
    CGFloat scale = 1 + (value - 0.5) * 2;
    switch (self.direction) {
        case CALayerTransformDirectionX:
            [self.layer setValue:@(scale) forKeyPath:@"transform.scale.x"];
            break;
        case CALayerTransformDirectionY:
            [self.layer setValue:@(scale) forKeyPath:@"transform.scale.y"];
            break;
        case CALayerTransformDirectionZ:
            [self.layer setValue:@(scale) forKeyPath:@"transform.scale.z"];
            break;
        default:
            break;
    }
}
@end
