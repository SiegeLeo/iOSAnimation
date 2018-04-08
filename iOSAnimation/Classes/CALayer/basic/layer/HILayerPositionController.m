//
//  HILayerPositionController.m
//  iOSAnimation
//
//  Created by 陈汉楠 on 31/03/2018.
//  Copyright © 2018 h_nChen. All rights reserved.
//

#import "HILayerPositionController.h"
#import "HISliderView.h"

#define LAYER_WIDTH 100
#define MARGIN 20.0

@interface HILayerPositionController ()



/* mark origin position point*/
@property (nonatomic, strong) CALayer *newPoint;

/** mark new position point*/
@property (nonatomic, strong) CALayer *oldPoint;


@property (nonatomic, strong) IBOutlet HISliderView *xSlider;
@property (nonatomic, strong) IBOutlet HISliderView *ySlider;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation HILayerPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    
    self.oldPoint.position = self.blueView.layer.position;
    [self.view.layer addSublayer:self.oldPoint];
    self.newPoint.position = self.blueView.layer.position;
    [self.view.layer addSublayer:self.newPoint];
    
    __weak typeof(self) weakSelf = self;
    self.xSlider.valueChangeBlock = ^(float value) {
        CGFloat newX = weakSelf.blueView.layer.position.x + (value - 0.5) * 100;
        [weakSelf.blueView.layer setValue:@(newX) forKeyPath:@"position.x"];
        
        /* position also can be changed in the way
        [weakSelf.blueView.layer setValue:[NSValue valueWithCGPoint:CGPointMake(newX, weakSelf.blueView.layer.position.y)] forKey:@"position"];
         */
        
        // newPosition's Point
        weakSelf.newPoint.position = CGPointMake(newX, weakSelf.blueView.layer.position.y);
    };
    self.ySlider.valueChangeBlock = ^(float value) {
        CGFloat newY = weakSelf.blueView.layer.position.y + (value - 0.5) * 100;
        [weakSelf.blueView.layer setValue:@(newY) forKeyPath:@"position.y"];
        
        /* position also can be changed in the way
        [weakSelf.blueView.layer setValue:[NSValue valueWithCGPoint:CGPointMake(weakSelf.blueView.layer.position.x, newY)] forKey:@"position"];
         */
        
        // newPosition's Point
        weakSelf.newPoint.position = CGPointMake(weakSelf.blueView.layer.position.x, newY);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CALayer *)oldPoint {
    if (!_oldPoint) {
        _oldPoint = [CALayer layer];
        _oldPoint.backgroundColor = [UIColor redColor].CGColor;
        _oldPoint.bounds = CGRectMake(0, 0, 4, 4);
        _oldPoint.cornerRadius = 2;
        _oldPoint.masksToBounds = YES;
    }
    return _oldPoint;
}

- (CALayer *)newPoint {
    if (!_newPoint) {
        _newPoint = [CALayer layer];
        _newPoint.backgroundColor = [UIColor greenColor].CGColor;
        _newPoint.bounds = CGRectMake(0, 0, 4, 4);
        _newPoint.cornerRadius = 2;
        _newPoint.masksToBounds = YES;
    }
    return _newPoint;
}

@end
