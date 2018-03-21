//
//  HILayerFillController.m
//  iOSAnimation
//
//  Created by h_n on 2018/3/21.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#define PADDING 20.0
#define LAYER_WIDTH ((SCREEN_W - PADDING * 3)  / 2 )
#define MARGIN 5;

#import "HILayerFillController.h"

@interface HILayerFillController ()

@property (nonatomic, strong) CAShapeLayer *LShapeLayer;
@property (nonatomic, strong) CAShapeLayer *RShapeLayer;

@property (nonatomic, strong) UISlider *rSlider;
@property (nonatomic, strong) UISlider *gSlider;
@property (nonatomic, strong) UISlider *bSlider;

@property (nonatomic, strong) UISegmentedControl *ruleSegment;

@end

@implementation HILayerFillController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStyleDone target:self action:@selector(handleReset)];
    
    [self.view addSubview:self.rSlider];
    [self.view addSubview:self.gSlider];
    [self.view addSubview:self.bSlider];
    
    [self.view addSubview:self.ruleSegment];
    
    [self.view.layer addSublayer:self.LShapeLayer];
    [self.view.layer addSublayer:self.RShapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (CAShapeLayer *)LShapeLayer{
    if (!_LShapeLayer) {
        _LShapeLayer = [CAShapeLayer layer];
        _LShapeLayer.frame = CGRectMake(PADDING, (SCREEN_H - LAYER_WIDTH) - PADDING, LAYER_WIDTH, LAYER_WIDTH);
        _LShapeLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _LShapeLayer.borderWidth = 0.5;
        
        CGFloat raduis = 60;
        CGFloat beginX = _LShapeLayer.frame.size.width / 2;
        CGFloat beginY = _LShapeLayer.frame.size.height/ 2;
        CGPoint center = CGPointMake(beginX, beginY);
        
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:raduis startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:raduis / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        [path1 appendPath:path2];
        
        // effect path
        _LShapeLayer.lineWidth = 2;
        _LShapeLayer.path = path1.CGPath;
        _LShapeLayer.strokeColor = [UIColor redColor].CGColor;
        _LShapeLayer.strokeStart = 0;
        _LShapeLayer.strokeEnd = 1.0;
        _LShapeLayer.fillColor = [UIColor blueColor].CGColor;
        _LShapeLayer.fillRule = kCAFillRuleNonZero;
        
        // 添加说明
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:13];
        textLabel.textColor = [UIColor blackColor];
        textLabel.text = @"两个path的方向是相同的，内外环都是顺时针方向";
        textLabel.numberOfLines = 0;
        CGSize size = [textLabel sizeThatFits:_LShapeLayer.frame.size];
        textLabel.frame = CGRectMake(CGRectGetMinX(_LShapeLayer.frame), CGRectGetMinY(_LShapeLayer.frame) - size.height - PADDING, size.width, size.height);
        [self.view addSubview:textLabel];
    }
    return _LShapeLayer;
}

- (CAShapeLayer *)RShapeLayer{
    if (!_RShapeLayer) {
        _RShapeLayer = [CAShapeLayer layer];
        _RShapeLayer.frame = CGRectMake(CGRectGetMaxX(self.LShapeLayer.frame) + PADDING, CGRectGetMinY(self.LShapeLayer.frame), LAYER_WIDTH, LAYER_WIDTH);
        _RShapeLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _RShapeLayer.borderWidth = 0.5;
        
        CGFloat raduis = 60;
        CGFloat beginX = _RShapeLayer.frame.size.width / 2;
        CGFloat beginY = _RShapeLayer.frame.size.height/ 2;
        CGPoint center = CGPointMake(beginX, beginY);
        
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:raduis startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:raduis / 2 startAngle:0 endAngle:M_PI * 2 clockwise:NO];
        [path1 appendPath:path2];
        // effect path
        _RShapeLayer.lineWidth = 2;
        _RShapeLayer.path = path1.CGPath;
        _RShapeLayer.strokeColor = [UIColor redColor].CGColor;
        _RShapeLayer.strokeStart = 0;
        _RShapeLayer.strokeEnd = 1.0;
        _RShapeLayer.fillColor = [UIColor blueColor].CGColor;
        _RShapeLayer.fillRule = kCAFillRuleNonZero;
        
        // 添加说明
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:13];
        textLabel.textColor = [UIColor blackColor];
        textLabel.text = @"两个path的方向是相反的, 外环是顺时针方向，内环是逆时针方向";
        textLabel.numberOfLines = 0;
        CGSize size = [textLabel sizeThatFits:_RShapeLayer.frame.size];
        textLabel.frame = CGRectMake(CGRectGetMinX(_RShapeLayer.frame), CGRectGetMinY(_LShapeLayer.frame) - size.height - PADDING, size.width, size.height);
        [self.view addSubview:textLabel];
    }
    return _RShapeLayer;
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

- (UISegmentedControl *)ruleSegment{
    if (!_ruleSegment) {
        NSArray *items = @[@"kCAFillRuleNonZero", @"kCAFillRuleEvenOdd"];
        CGFloat segmentW = items.count * 160;
        CGFloat segmentH = 32;
        CGFloat segmentX = (SCREEN_W - segmentW) / 2;
        CGFloat segmentY = CGRectGetMaxY(self.bSlider.frame) + PADDING;
        
        _ruleSegment = [[UISegmentedControl alloc] initWithItems:items];
        _ruleSegment.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
        _ruleSegment.selectedSegmentIndex = 0;
        [_ruleSegment addTarget:self action:@selector(selectedFillRule:) forControlEvents:UIControlEventValueChanged];
    }
    return _ruleSegment;
}

#pragma mark - handle action
- (void)handleReset {
    self.rSlider.value = 0.5;
    self.gSlider.value = 0.5;
    self.bSlider.value = 0.5;
    
    [self colorSliderChanged];
}

/**
 * 调整strokeColor的值
 */
- (void)colorSliderChanged {
    self.LShapeLayer.fillColor = [UIColor colorWithRed:self.rSlider.value green:self.gSlider.value blue:self.bSlider.value alpha:1].CGColor;
    self.RShapeLayer.fillColor = [UIColor colorWithRed:self.rSlider.value green:self.gSlider.value blue:self.bSlider.value alpha:1].CGColor;
}

- (void)selectedFillRule:(UISegmentedControl *)control {
    if (control.selectedSegmentIndex == 0) {
        self.LShapeLayer.fillRule = kCAFillRuleNonZero;
        self.RShapeLayer.fillRule = kCAFillRuleNonZero;
    } else {
        self.LShapeLayer.fillRule = kCAFillRuleEvenOdd;
        self.RShapeLayer.fillRule = kCAFillRuleEvenOdd;
    }
}

@end
