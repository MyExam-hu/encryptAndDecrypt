//
//  MCFeedbackViewController.m
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import "MCFeedbackViewController.h"
#import "MCCustomTopBar.h"

@interface MCFeedbackViewController ()<MCCustomTopBarDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation MCFeedbackViewController

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
    backBtn.title = @"留言反馈";
    backBtn.delegate = self;
    
    UITextView *textview =  [[UITextView alloc] initWithFrame:CGRectMake(15, 100, Screen_Width-30, 150)];
    textview.backgroundColor=[UIColor whiteColor]; //设置背景色
    textview.scrollEnabled = NO;    //设置当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //设置是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDefault;//设置return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//设置键盘类型一般为默认
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor blackColor];// 设置显示文字颜色
    textview.text = @"留言：";//设置显示的文本内容
    [self.view addSubview:textview];
    self.textView = textview;
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:submitBtn];
    self.submitBtn = submitBtn;
    submitBtn.enabled = NO;
    submitBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    [submitBtn setFrame:CGRectMake(30, CGRectGetMaxY(textview.frame)+20, Screen_Width-60, 50)];
    submitBtn.layer.cornerRadius = 25;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateSelected];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self dismissKeyBoard];
        return NO;
    }

    if (textView.text && textView.text.length > 0) {
        self.submitBtn.enabled = YES;
        self.submitBtn.backgroundColor = [MCThemeManage shareInstance].bgColor;
    } else {
        self.submitBtn.enabled = NO;
        self.submitBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissKeyBoard];
}

- (void)dismissKeyBoard {
    [self.textView resignFirstResponder];
}

- (void)submitBtnAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
