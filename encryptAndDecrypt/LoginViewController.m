//
//  LoginViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 13/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "operationsDB.h"
#import "LoginViewController.h"
#import "clsUserInfo.h"
#import "clsUserEncryptInfo.h"
#import "clsOtherFun.h"
#import "MainViewController.h"
#import "AES.h"
#import "clsTableInfo.h"
#import "clsWebServices.h"

@interface LoginViewController ()

@property (copy, nonatomic) NSString *password;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginWithFacebookBtn;

@property (strong, nonatomic) clsWebServices *webServices;

@end

@implementation LoginViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.passwordTextField.text = nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.password = [clsOtherFun getAESPassword];
    
    [self.bgView.layer addSublayer:[self shadowAsInverse1]];
    [self.view sendSubviewToBack:self.bgView];
    [self.userNameTextField setValue:PLACE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    self.userNameView.layer.cornerRadius=4.5;
    self.userNameTextField.clearButtonMode=UITextFieldViewModeWhileEditing;    
    
    [self.passwordTextField setValue:PLACE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordView.layer.cornerRadius=4.5;
    self.passwordTextField.secureTextEntry=YES;
    self.passwordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    self.loginBtn.layer.cornerRadius=4.5;
    self.loginWithFacebookBtn.layer.cornerRadius=4.5;
    
    if (![clsOtherFun theTableIsExist:TABLEINFO_TABLE]) {
        [clsTableInfo createTable];
    }
    
    if (![clsOtherFun theTableIsExist:USER_INFO_TABLE]) {
        [clsUserInfo createTable];
        clsUserInfo *obj=[[clsUserInfo alloc] init];
        obj.Status=true;
        obj.Account=@"blue";
        obj.Password=[clsOtherFun md5Encrypt:@"Aa123456"];
        [clsUserInfo insertData:obj];
    }
    
    if (![clsOtherFun theTableIsExist:USER_ENCRYPTINFO_TABLE]) {
        [clsUserEncryptInfo createTable];
//        for (int i=0; i<5; i++) {
//            clsUserEncryptInfo *obj=[[clsUserEncryptInfo alloc] init];
//            obj.Title=[NSString stringWithFormat:@"qq%i",i];
//            obj.Content=[AES encrypt:@"23333asdjawsklfhjdsjkhufjjdsfdstnrbrtertfhjrthedrfgdfger" password:self.password];
//            obj.UserID=1;
//            obj.Status=true;
//            obj.EncryptAccount=[AES encrypt:@"407475190" password:self.password];
//            obj.EncryptPasswork=[AES encrypt:@"Aa123456" password:self.password];
//            [clsUserEncryptInfo insertData:obj];
//        }
    }
    [clsUserEncryptInfo selectData];
    
    self.webServices = [[clsWebServices alloc] init];
    [self.webServices controlSDKSwitch];
}

- (IBAction)signinBtnClick:(id)sender {
    [clsOtherFun showLoadingView:@"loading......"];
    NSString *accountStr=self.userNameTextField.text;
    NSString *passwordStr=[clsOtherFun md5Encrypt:self.passwordTextField.text];
    if (accountStr.length && passwordStr.length) { // 注册登录
        clsUserInfo *obj=[[clsUserInfo alloc] init];
        obj.Status=true;
        obj.Account=accountStr;
        obj.Password=passwordStr;
        [clsUserInfo insertData:obj];
        
        MainViewController *mainVC=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        [self.navigationController pushViewController:mainVC animated:YES];
    } else {
        NSLog(@"注册失败");
    }
    [clsOtherFun hideLoadingView];
    
}


- (IBAction)loginBtnClick:(id)sender {
    [self.view endEditing:YES];
    
//    if ([[self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""]) {
//        [clsOtherFun showMessageByHUD:@"Please enter your UserName!"];
//        return;
//    }else if ([[self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""]){
//        [clsOtherFun showMessageByHUD:@"Please enter your Password!"];
//        return;
//    }
    
    [clsOtherFun showLoadingView:@"loading......"];
//    NSString *accountStr=self.userNameTextField.text;
//    NSString *passwordStr=[clsOtherFun md5Encrypt:self.passwordTextField.text];
    NSString *accountStr=@"blue";
    NSString *passwordStr=[clsOtherFun md5Encrypt:@"Aa123456"];
    NSMutableArray *array=[clsUserInfo selectDataWhere:accountStr :passwordStr];
    if ([array count]>0) { // 登录
        NSLog(@"登录成功");
        [clsOtherFun hideLoadingView];
        MainViewController *mainVC=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        [self.navigationController pushViewController:mainVC animated:YES];
    } else {
        NSLog(@"登录失败");
        [clsOtherFun hideLoadingView];
    }
}


- (CAGradientLayer *)shadowAsInverse1
{
    CGRect rect=[UIScreen mainScreen].bounds;
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    CGRect newGradientLayerFrame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    gradientLayer.frame = newGradientLayerFrame;
    
    UIColor *color1=[[UIColor alloc] initWithRed:32/255.0 green:13/255.0 blue:41/255.0 alpha:1];
    UIColor *color2=[[UIColor alloc] initWithRed:45/255.0 green:25/255.0 blue:60/255.0 alpha:1];
    UIColor *color3=[[UIColor alloc] initWithRed:59/255.0 green:36/255.0 blue:78/255.0 alpha:1];
    UIColor *color4=[[UIColor alloc] initWithRed:45/255.0 green:25/255.0 blue:60/255.0 alpha:1];
    UIColor *color5=[[UIColor alloc] initWithRed:32/255.0 green:13/255.0 blue:41/255.0 alpha:1];
    //添加渐变的颜色组合
    gradientLayer.colors = [NSArray arrayWithObjects:(id)color1.CGColor,
                            (id)color2.CGColor,
                            (id)color3.CGColor,
                            (id)color4.CGColor,
                            (id)color5.CGColor,
                            nil];
    
    gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.1],
                               [NSNumber numberWithFloat:0.3],
                               [NSNumber numberWithFloat:0.5],
                               [NSNumber numberWithFloat:0.7],
                               [NSNumber numberWithFloat:0.9],
                               nil];
    
    gradientLayer.startPoint = CGPointMake(0,0);
    gradientLayer.endPoint = CGPointMake(0,1);
    return gradientLayer;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
