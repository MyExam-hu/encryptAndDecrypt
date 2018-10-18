//
//  FCHVarietyStyleLoadingView.m
//  Facechat
//
//  Created by 胡伟东 on 7/12/17.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import "FCHVarietyStyleLoadingView.h"
#import "FCHActivityCeterLoadingView.h"
#import "FCHLoadingView.h"

@interface FCHVarietyStyleLoadingView()

@property (nonatomic, strong) FCHActivityCeterLoadingView *activityViewTypeOne;
@property (nonatomic, strong) FCHLoadingView *activityViewTypeTwo;

@end

@implementation FCHVarietyStyleLoadingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.activityViewTypeOne];
        [self addSubview:self.activityViewTypeTwo];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.loadingType == FCHVarietyStyleLoadingViewType1) {
        [self.activityViewTypeOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_offset(0);
        }];
    }else {
        [self.activityViewTypeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_offset(0);
            make.width.height.mas_offset(26);
        }];
    }
}


-(void)stopAnimating {
    if (self.loadingType == FCHVarietyStyleLoadingViewType1) {
        [self.activityViewTypeOne stopAnimating];
    }else {
        [self.activityViewTypeTwo hide];
    }
}

-(void)startAnimating {
    if (self.loadingType == FCHVarietyStyleLoadingViewType1) {
        [self.activityViewTypeOne startAnimating];
    }else {
        [self.activityViewTypeTwo show];
    }
}

-(FCHActivityCeterLoadingView *)activityViewTypeOne {
    if (!_activityViewTypeOne) {
        _activityViewTypeOne = [[FCHActivityCeterLoadingView alloc] init];
    }
    return _activityViewTypeOne;
}

-(FCHLoadingView *)activityViewTypeTwo {
    if (!_activityViewTypeTwo) {
        CGFloat activityViewTWH = 26;
        _activityViewTypeTwo = [[FCHLoadingView alloc] initWithFrame:CGRectMake(0, 0, activityViewTWH, activityViewTWH) lineColor:nil iconViewWH:activityViewTWH imageWH:activityViewTWH drawLineWidth:4.0];
        _activityViewTypeTwo.hidden = YES;
        _activityViewTypeTwo.alpha = 0.0;
    }
    return _activityViewTypeTwo;
}

-(void)setLoadingType:(FCHVarietyStyleLoadingViewType)loadingType {
    _loadingType = loadingType;
    if (_loadingType == FCHVarietyStyleLoadingViewType1) {
        [self.activityViewTypeOne startAnimating];
        self.activityViewTypeOne.hidden = NO;
        self.activityViewTypeTwo.hidden = YES;
    }else {
        self.activityViewTypeOne.hidden = YES;
        self.activityViewTypeTwo.hidden = NO;
        [self.activityViewTypeTwo show];
    }
}

@end
