//
//  FCHLoadingStateView.m
//  Facechat
//
//  Created by echo_hu on 8/9/17.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import "FCHLoadingStateView.h"

@interface FCHLoadingStateView()

@property (nonatomic, strong) FCHVarietyStyleLoadingView *activityView;
@property (nonatomic, strong) UIView *failuerView;
@property (nonatomic, strong) UIImageView *failuerImageView;
@property (nonatomic, strong) UILabel *failuerTitleLb;
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UIImageView *noDataImageView;
@property (nonatomic, strong) UILabel *noDataLb;

@end

@implementation FCHLoadingStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.successAfterRemoveView = YES;
        
        [self addSubview:self.activityView];
        [self addSubview:self.failuerView];
        [self addSubview:self.noDataView];
        
        self.loadingStatus = FCHLoadingStateViewStatusLoading;
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
    }];
    
    [self.failuerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
    }];
    
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
    }];
}

-(FCHVarietyStyleLoadingView *)activityView {
    if (!_activityView) {
        _activityView = [[FCHVarietyStyleLoadingView alloc] init];
    }
    return _activityView;
}

-(UIView *)failuerView {
    if (!_failuerView) {
        _failuerView = [[UIView alloc] init];
        _failuerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.failuerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"material_loading_failuer"]];
        [_failuerView addSubview:self.failuerImageView];
        [self.failuerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.centerX.mas_offset(0);
        }];
        
        self.failuerTitleLb = [[UILabel alloc] init];
        self.failuerTitleLb.text = @"加载失败，请检查网络设置";
        self.failuerTitleLb.font = [UIFont systemFontOfSize:14.0];
        self.failuerTitleLb.textColor = [SLUIColor colorWithHexString:@"8c8c8c"];
        [_failuerView addSubview:self.failuerTitleLb];
        [self.failuerTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.failuerImageView.mas_bottom).offset(42.0/2);
            make.left.right.mas_offset(0);
        }];
        
        UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [reloadButton setTitleColor:[SLUIColor colorWithHexString:@"196eff"] forState:UIControlStateNormal];
        [reloadButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [reloadButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_failuerView addSubview:reloadButton];
        [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.equalTo(self.failuerTitleLb.mas_bottom).offset(76/2.0);
            make.bottom.mas_offset(0);
        }];
        
    }
    return _failuerView;
}

-(UIView *)noDataView {
    if (!_noDataView) {
        _noDataView = [UIView new];
        _noDataView.backgroundColor = [UIColor clearColor];
        _noDataView.hidden = YES;
        
        UIView *noDataContentView = [UIView new];
        [_noDataView addSubview:noDataContentView];
        self.noDataImageView = [[UIImageView alloc] init];
        self.noDataImageView.image = [UIImage imageNamed:@"material_nodata_icon"];
        [noDataContentView addSubview:self.noDataImageView];
        [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.mas_offset(0);
        }];
        
        self.noDataLb = [UILabel new];
        self.noDataLb.text = @"此分类没有素材";
        self.noDataLb.font = [UIFont systemFontOfSize:14.0f];
        self.noDataLb.textColor = [SLUIColor colorWithHexString:@"8c8c8c"];
        [noDataContentView addSubview:self.noDataLb];
        [self.noDataLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.noDataImageView.mas_bottom).offset(46/2.0);
            make.left.mas_offset(8);
            make.right.mas_offset(-8);
            make.bottom.mas_offset(0);
        }];
        
        [noDataContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_offset(0);
        }];
    }
    return _noDataView;
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(reloadData)]) {
        [self.delegate reloadData];
    }
}

#pragma mark -- about set method

-(void)setLoadingStatus:(FCHLoadingStateViewStatus)loadingStatus {
    _loadingStatus = loadingStatus;
    if (loadingStatus == FCHLoadingStateViewStatusLoading) {
        [self.activityView startAnimating];
        [UIView animateWithDuration:0.35 animations:^{
            self.activityView.hidden = NO;
            self.failuerView.hidden = YES;
            self.noDataView.hidden = YES;
            self.alpha = 1;
        }];
        
    }else if (loadingStatus == FCHLoadingStateViewStatusFailure){
        [UIView animateWithDuration:0.35 animations:^{
            [self.activityView stopAnimating];
            self.activityView.hidden = YES;
            self.failuerView.hidden = NO;
            self.noDataView.hidden = YES;
            self.alpha = 1;
        }];
        
    }else if (loadingStatus == FCHLoadingStateViewStatusSuccess){
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
            [self.activityView stopAnimating];
        } completion:^(BOOL finished) {
            if (self.successAfterRemoveView) {
//                [self removeFromSuperview];
            }
        }];
    }else if (loadingStatus == FCHLoadingStateViewStatusNoData){
        [self.activityView stopAnimating];
        [UIView animateWithDuration:0.35 animations:^{
            self.activityView.hidden = YES;
            self.failuerView.hidden = YES;
            self.noDataView.hidden = NO;
            self.alpha = 1;
        }];
        
    } else {
        [self removeFromSuperview];
    }
}

-(void)setHiddenLogo:(BOOL)hiddenLogo {
    _hiddenLogo = hiddenLogo;
    self.failuerImageView.hidden = hiddenLogo;
}

-(void)setNoDataStr:(NSString *)noDataStr {
    _noDataStr = noDataStr;
    self.noDataLb.text = _noDataStr;
    [self.noDataView setNeedsLayout];
}

-(void)setNoDataImage:(UIImage *)noDataImage {
    _noDataImage = noDataImage;
    self.noDataImageView.image = _noDataImage;
    [self.noDataView setNeedsLayout];
}

-(void)setLoadingType:(FCHVarietyStyleLoadingViewType)loadingType {
    _loadingType = loadingType;
    self.activityView.loadingType = _loadingType;
}

@end
