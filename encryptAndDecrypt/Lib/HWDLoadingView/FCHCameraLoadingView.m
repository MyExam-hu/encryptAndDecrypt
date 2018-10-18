//
//  FCHCameraLoadingView.m
//  Facechat
//
//  Created by 胡伟东 on 20/4/18.
//  Copyright © 2018年 广州美人信息技术有限公司. All rights reserved.
//

#import "FCHCameraLoadingView.h"
#import "FCHLoadingView.h"

@interface FCHCameraLoadingView()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) FCHLoadingView *loadingView;
@property (nonatomic, strong) NSTimer *timeoutTimer;

@end

@implementation FCHCameraLoadingView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.contentView = [[UIView alloc] init];
        self.contentView.layer.cornerRadius = 10/2;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.5];
        [self addSubview:self.contentView];
        
        self.titleButton = [[UIButton alloc] init];
        [self.titleButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:11.0]];
        [self.titleButton.titleLabel setTextColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.5]];
        [self.titleButton addTarget:self action:@selector(pressedCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.titleButton];
        
        self.loadingView = [[FCHLoadingView alloc] initWithFrame:CGRectMake(Screen_Width/2 - 14, 501 * Screen_Height/667, 28, 28)];
        self.loadingView.backgroundColor = [UIColor clearColor];
        self.loadingView.alpha = 0.0;
        [self.contentView addSubview:self.loadingView];
    }
    return self;
}

- (void)layoutSubviews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.width.mas_offset(246/2.0);
        make.height.mas_offset(180/2.0);
    }];
    
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-28/2.0);
        make.centerX.mas_offset(0);
        make.width.mas_offset(50/2.0);
    }];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(46/2.0 - 6/2.0);
        make.centerX.mas_offset(0);
        make.width.height.mas_offset(28);
    }];
    
}

- (void)showAnimation {
    [self.loadingView show];
    
    if (_timeoutTimer) {
        [_timeoutTimer invalidate];
        _timeoutTimer = nil;
    }
    
    _timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:_timeout target:self selector:@selector(timeoutAction) userInfo:nil repeats:NO];
}

- (void)removeAnimation {
    [self.loadingView hide];
    
    if (_timeoutTimer) {
        [_timeoutTimer invalidate];
        _timeoutTimer = nil;
    }
}

- (void)pressedCancelButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(loadingView:cancelClickButton:)]) {
        [self.delegate loadingView:self cancelClickButton:sender];
    }
}

- (void)timeoutAction {
    if ([self.delegate respondsToSelector:@selector(timeoutForLoadingView:)]) {
        [self.delegate timeoutForLoadingView:self];
    }
    if (_timeoutTimer) {
        [_timeoutTimer invalidate];
        _timeoutTimer = nil;
    }
}

@end
