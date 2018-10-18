//
//  FCHLoadingView.m
//  Facechat
//
//  Created by 许孝泳 on 2017/6/30.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import "FCHLoadingView.h"
#import "FCHRefreshIconView.h"
#import "UIImage+FCHRotateFlip.h"

@interface FCHLoadingView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation FCHLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame lineColor:nil];;
}

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 1.5;
        
        FCHRefreshIconView *view = [[FCHRefreshIconView alloc] initWithFrame:CGRectMake(0, 0, 36/sqrt(2), 36/sqrt(2))];
        view.drawLineWidth = 6;
        if (lineColor) {
            view.lineColor = lineColor;
        }
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13/sqrt(2)*2, 13/sqrt(2)*2)];
        _imageView.image = [view createViewImageWith:M_PI_4];
        _imageView.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        _imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor iconViewWH:(CGFloat)iconViewWH imageWH:(CGFloat)imageWH drawLineWidth:(CGFloat)drawLineWidth {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 1.5;
        
        FCHRefreshIconView *view = [[FCHRefreshIconView alloc] initWithFrame:CGRectMake(0, 0, iconViewWH, iconViewWH)];
        view.drawLineWidth = drawLineWidth;
        if (lineColor) {
            view.lineColor = lineColor;
        }
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWH, imageWH)];
        _imageView.image = [view createViewImageWith:M_PI_4];
        _imageView.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        _imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
    }
    return self;
}


- (void)show
{
    if (self.alpha < 0.1) {
        self.alpha = 1.0;
        
        if ([_imageView.layer animationForKey:@"animationFallingRotate"]) {
            return;
        }
        
        CGFloat stopTime = 0.2;
        CGFloat rotateTime = 0.3;
        CAAnimation* animationRotate45 = [self animationRotate:-M_PI_4 beginTime:0.0 duration:rotateTime];
        CAAnimation* animationRotate90 = [self animationRotate:-M_PI_2 beginTime:stopTime+rotateTime duration:rotateTime];
        
        CAAnimationGroup *pGroupAnimation    = [CAAnimationGroup animation];
        pGroupAnimation.removedOnCompletion = NO;
        pGroupAnimation.duration            = 1.0;
        pGroupAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pGroupAnimation.repeatCount         = FLT_MAX;//"forever"
        pGroupAnimation.fillMode            = kCAFillModeForwards;
        pGroupAnimation.animations            = [NSArray arrayWithObjects:animationRotate45,animationRotate90,
                                                 nil];
        //对视图自身的层添加组动画
        [_imageView.layer addAnimation:pGroupAnimation forKey:@"animationFallingRotate"];
    }
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [_imageView.layer removeAnimationForKey:@"animationFallingRotate"];
        
//        [self removeFromSuperview];
    }];
}

- (CAAnimation *)animationRotate :(CGFloat)angle beginTime:(CFTimeInterval)beginTime duration:(CFTimeInterval)duration
{
    // rotate animation
    CATransform3D rotationTransform  = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
    
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue		= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration		= duration;
    animation.autoreverses	= NO;
    animation.cumulative	= YES;
    animation.repeatCount	= 1;
    //设置开始时间，能够连续播放多组动画
    animation.beginTime		= beginTime;
    animation.fillMode      = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    return animation;
}

@end
