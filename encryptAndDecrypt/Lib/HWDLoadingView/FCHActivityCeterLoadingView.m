//
//  FCHActivityCeterLoadingView.m
//  Facechat
//
//  Created by echo_hu on 1/11/17.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import "FCHActivityCeterLoadingView.h"

@interface FCHActivityCeterLoadingView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat scale;

@end

@implementation FCHActivityCeterLoadingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scale = 1.0;
        UIImage *image = [UIImage imageNamed:@"activity_loading"];
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        [self startAnimating];
    }
    return self;
}

- (instancetype)initWithScale:(CGFloat)scale
{
    self = [super init];
    if (self) {
        self.scale = scale;
        UIImage *image = [UIImage imageNamed:@"activity_loading"];
        self.frame = CGRectMake(0, 0, image.size.width * self.scale, image.size.height * self.scale);
        
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        [self startAnimating];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"activity_loading"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_offset(0);
        make.width.mas_offset(image.size.width * self.scale);
        make.height.mas_offset(image.size.height * self.scale);
    }];
}

-(void)stopAnimating {
    [self.imageView.layer removeAllAnimations];
}

-(void)startAnimating {
    [self stopAnimating];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = ULLONG_MAX;
    
    [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
