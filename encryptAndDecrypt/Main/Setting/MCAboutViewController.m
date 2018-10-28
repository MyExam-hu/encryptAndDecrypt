//
//  MCAboutViewController.m
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import "MCAboutViewController.h"
#import "MCCustomTopBar.h"

@interface MCAboutViewController ()<MCCustomTopBarDelegate>

@end

@implementation MCAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupSubviews];
}

- (void)setupDatas {
    
}

- (void)setupSubviews {
    
    MCCustomTopBar *backBtn = [[MCCustomTopBar alloc] initWithFrame:CGRectMake(0, StatusBarHeight, Screen_Width, TopBarHeight)];
    [self.view addSubview:backBtn];
    backBtn.title = @"关于我们";
    backBtn.delegate = self;
    
    UIImageView *tmpImageView = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-100)/2.0, 200, 100, 100)];
    [self.view addSubview:tmpImageView];
    tmpImageView.image = [UIImage imageNamed:@"AppIcon"];
    tmpImageView.backgroundColor = [MCThemeManage shareInstance].bgColor;

    UILabel *vesionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tmpImageView.frame)+15, Screen_Width, 17)];
    [self.view addSubview:vesionLab];
    vesionLab.text = @"1.0.0";
    vesionLab.font = [UIFont systemFontOfSize:17.0];
    vesionLab.textAlignment = NSTextAlignmentCenter;
    
    UILabel *appNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(vesionLab.frame)+5, Screen_Width, 20)];
    [self.view addSubview:appNameLab];
    appNameLab.text = @"55加密";
    appNameLab.font = [UIFont systemFontOfSize:20.0];
    appNameLab.textAlignment = NSTextAlignmentCenter;
    
}

- (void)topBarBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
