//
//  MCChangePasswordViewController.m
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import "MCChangePasswordViewController.h"
#import "MCCustomTopBar.h"

@interface MCChangePasswordViewController ()<MCCustomTopBarDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation MCChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupSubviews];
}

- (void)setupDatas {
    
}

- (void)setupSubviews {
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
    MCCustomTopBar *backBtn = [[MCCustomTopBar alloc] initWithFrame:CGRectMake(0, StatusBarHeight, Screen_Width, TopBarHeight)];
    [self.view addSubview:backBtn];
    backBtn.title = @"修改密码";
    backBtn.delegate = self;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, Screen_Width-30, 35)];
    textField.backgroundColor=[UIColor whiteColor]; //设置背景色
    [self.view addSubview:textField];
    self.textField = textField;
    textField.layer.cornerRadius = 10;
    textField.layer.masksToBounds = YES;
    textField.delegate = self;
    textField.placeholder = @"请输入密码";
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.returnKeyType = UIReturnKeyDefault;//设置return键的类型
    textField.keyboardType = UIKeyboardTypeDefault;//设置键盘类型一般为默认

    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:submitBtn];
    self.submitBtn = submitBtn;
    submitBtn.enabled = NO;
    submitBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    [submitBtn setFrame:CGRectMake(30, CGRectGetMaxY(textField.frame)+20, Screen_Width-60, 50)];
    submitBtn.layer.cornerRadius = 25;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateSelected];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [self dismissKeyBoard];
        return NO;
    }
   
    if (textField.text && textField.text.length > 0) {
        if (textField.text.length == 1 && !string.length) {
            self.submitBtn.enabled = NO;
            self.submitBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        } else {
            self.submitBtn.enabled = YES;
            self.submitBtn.backgroundColor = [MCThemeManage shareInstance].bgColor;
        }
    } else {
        if (!textField.text.length && string.length) {
            self.submitBtn.enabled = YES;
            self.submitBtn.backgroundColor = [MCThemeManage shareInstance].bgColor;
        } else {
            self.submitBtn.enabled = NO;
            self.submitBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        }
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissKeyBoard];
}

- (void)dismissKeyBoard {
    [self.textField resignFirstResponder];
}

- (void)submitBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
