//
//  MCCustomTopBar.m
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import "MCCustomTopBar.h"

@interface MCCustomTopBar ()

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation MCCustomTopBar

- (void)layoutSubviews {

    [super layoutSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [MCThemeManage shareInstance].bgColor;
        [self creatUI];
    }
    return self;

}

- (void)creatUI {

    UIView *tmpStateBar = [[UIView alloc] initWithFrame:CGRectMake(0, -StatusBarHeight, Screen_Width, StatusBarHeight)];
    [self addSubview:tmpStateBar];
    tmpStateBar.backgroundColor = [MCThemeManage shareInstance].bgColor;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backBtn];
    [backBtn setFrame:CGRectMake(0, 0, 50, CGRectGetHeight(self.bounds))];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateSelected];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tmpLab = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-250)/2.0, 0, 250, CGRectGetHeight(self.bounds))];
    [self addSubview:tmpLab];
    self.titleLab = tmpLab;
    tmpLab.textAlignment = NSTextAlignmentCenter;
    tmpLab.font = [UIFont systemFontOfSize:20];
    tmpLab.textColor = [UIColor whiteColor];
}

- (void)setTitle:(NSString *)title {

    _title = title;
    self.titleLab.text = title;
}

- (void)backAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(topBarBack:)]) {
        [self.delegate topBarBack:sender];
    }
}

@end
