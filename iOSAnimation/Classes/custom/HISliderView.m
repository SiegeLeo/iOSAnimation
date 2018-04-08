//
//  HISliderView.m
//  iOSAnimation
//
//  Created by h_n on 2018/4/4.
//  Copyright © 2018年 h_nChen. All rights reserved.
//

#import "HISliderView.h"

@interface HISliderView()

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

/** 标题*/
@property (nonatomic, strong) IBInspectable NSString *title;


@end

@implementation HISliderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSBundle mainBundle] loadNibNamed:@"HISliderView" owner:self options:nil];
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = [NSString stringWithFormat:@"%@: ", title];
}

- (IBAction)sliderChange:(id)sender {
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.slider.value);
    }
}

@end
