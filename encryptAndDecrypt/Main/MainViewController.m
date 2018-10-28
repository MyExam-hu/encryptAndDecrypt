//
//  MainViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "PersonalViewController.h"
#import "SettingViewController.h"
#import "AddDataView.h"
#import "SearchView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadViewControllerData];
    UINavigationController * nav=[self.childViewControllers firstObject];
    self.contentView=nav.view;
    [self.view addSubview: self.contentView];
    self.currentController=[self.childViewControllers firstObject];
    
//    self.bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, self.view.bounds.size.width, 50)];
//    self.bottomBar.backgroundColor = self.navBar.backgroundColor;
//    [self.view addSubview:self.bottomBar];
//    for (NSInteger i = 0; i < 3; i++) {
//        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.bottomBar addSubview:tmpBtn];
//        tmpBtn.tag = i;
//        tmpBtn.backgroundColor = [UIColor clearColor];
//        tmpBtn.frame = CGRectMake((SCREEN_WIDTH/3.0)*i, 0, SCREEN_WIDTH/3.0, 50);
//        [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [tmpBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
//        [tmpBtn addTarget:self action:@selector(TabItemClick:) forControlEvents:UIControlEventTouchUpInside];
//        if (i == 0) {
//            [tmpBtn setTitle:@"主页" forState:UIControlStateNormal];
//        } else if (i == 1) {
//            [tmpBtn setTitle:@"个人" forState:UIControlStateNormal];
//        } else {
//            [tmpBtn setTitle:@"设置" forState:UIControlStateNormal];
//        }
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadViewControllerData{
    CGRect rect=[UIScreen mainScreen].bounds;
    
    HomeViewController *homeVC=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    navVC.view.frame=CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-50-64);
    navVC.navigationBarHidden = YES;
    [self addChildViewController:navVC];
    
    PersonalViewController *marketVC=[[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:nil];
    navVC = [[UINavigationController alloc] initWithRootViewController:marketVC];
    navVC.view.frame=CGRectMake(0, 64, rect.size.width, rect.size.height-50-64);
    navVC.navigationBarHidden = YES;
    [self addChildViewController:navVC];
    
    __weak __typeof(self)weakSelf = self;
    SettingViewController *restaurantVC=[[SettingViewController alloc] init];
//    restaurantVC.handelNavBarState = ^(BOOL hidden){
//        if (weakSelf.selectIndex == 2) {
//            weakSelf.navBar.hidden = hidden;
//        }
//        weakSelf.navBar.backgroundColor = [MCThemeManage shareInstance].bgColor;
//        weakSelf.bottomBar.backgroundColor = [MCThemeManage shareInstance].bgColor;
//    };
    restaurantVC.handelPopRootView = ^(){
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
    navVC = [[UINavigationController alloc] initWithRootViewController:restaurantVC];
        navVC.view.frame=CGRectMake(0, 64, rect.size.width, rect.size.height-50-64);
    navVC.navigationBarHidden = YES;
    [self addChildViewController:navVC];
}

- (IBAction)TabItemClick:(UIButton *)sender {
    if(self.selectIndex==sender.tag){
        return;
    }
    
    self.selectIndex=sender.tag;
    [self.currentController popToRootViewControllerAnimated:NO];
    
    [self transitionFromViewController:self.currentController toViewController:self.childViewControllers[self.selectIndex] duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    }  completion:^(BOOL finished) {
        self.currentController=self.childViewControllers[self.selectIndex];
        self.contentView=self.currentController.view;
    }];
}
- (IBAction)btnAddClick:(id)sender {
    AddDataView *addView=[[AddDataView alloc] init];
    [addView show:^(NSString *code){
    }];
}
- (IBAction)btnSearchClick:(id)sender {
    SearchView *searchView=[[SearchView alloc] initWithFrame:self.view.bounds];
    searchView.parentVC=self;
    searchView.alpha=0;
    [self.view addSubview:searchView];
    [UIView animateWithDuration:0.25 animations:^{
        searchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        searchView.alpha=1;
        [self.view bringSubviewToFront:searchView];
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
