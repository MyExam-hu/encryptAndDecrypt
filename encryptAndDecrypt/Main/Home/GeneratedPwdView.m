//
//  GeneratedPwdView.m
//  encryptAndDecrypt
//
//  Created by huweidong on 16/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "GeneratedPwdView.h"
#import "AppDelegate.h"
#import "clsOtherFun.h"
#import "clsUserEncryptInfo.h"
#import "AES.h"

#define customBlue [UIColor colorWithRed:0 green:202/255.0 blue:198/255.0 alpha:1]

@interface GeneratedPwdView()

@property (strong, nonatomic) PaymentCallBack compite;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (weak, nonatomic) IBOutlet UITextField *titleTextFile;
@property (weak, nonatomic) IBOutlet UITextField *accountTextFile;
@property (weak, nonatomic) IBOutlet UITextField *passworkTextFile;

@end

@implementation GeneratedPwdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    self=[[[NSBundle mainBundle] loadNibNamed:@"GeneratedPwdView" owner:self options:nil] lastObject];
    if (self) {
        self.frame=frame;
    }
    UITapGestureRecognizer * singal=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clockAction:)];
    [self.bgView addGestureRecognizer:singal];
    
    CGRect rect=[UIScreen mainScreen].bounds;
    self.bgViewHeight.constant=rect.size.height;
    
    self.btnAdd.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.btnAdd.layer.borderWidth=1.0;
    
    NSString *randomGeneratedPwdStr = [clsUserEncryptInfo randomGeneratedPwd];
    self.passworkTextFile.text = randomGeneratedPwdStr;
    
    return self;
}

- (void)show:(PaymentCallBack)compite{
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.compite=compite;
    self.frame=delegate.window.bounds;
    self.ContentView.transform= CGAffineTransformScale(self.ContentView.transform, 1.3, 1.3);
    [delegate.window addSubview:self];
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.ContentView.transform = CGAffineTransformScale(self.ContentView.transform, 1/1.3, 1/1.3);
                     }
                     completion:^(BOOL finished){}];
    
}

- (void) dismiss{
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.ContentView.transform = CGAffineTransformScale(self.ContentView.transform, 0.5, 0.5);
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
    
}

- (IBAction)btnAddClick:(id)sender {
    [self endEditing:YES];
    
    if ([[self.titleTextFile.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""]) {
        [clsOtherFun showMessageByHUD:@"Please enter your Title!"];
        return;
    }else if ([[self.passworkTextFile.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""]){
        [clsOtherFun showMessageByHUD:@"Please enter your Passwork!"];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否添加?"delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    alert.tag=99;
    [alert show];
}

- (IBAction)clockAction:(id)sender {
    [self dismiss];
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex && alertView.tag==99) {
        
        clsUserEncryptInfo *ocls=[[clsUserEncryptInfo alloc] init];
        ocls.Title=self.titleTextFile.text;
        NSString *accountStr = self.accountTextFile.text;
        if (accountStr && ![accountStr isEqualToString:@""]) {
            ocls.EncryptAccount=[AES encrypt:accountStr password: [clsOtherFun getAESPassword]];
        }else {
            ocls.EncryptAccount=@"";
        }
        ocls.EncryptPasswork=[AES encrypt:self.passworkTextFile.text password:[clsOtherFun getAESPassword]];
        ocls.Content=@"";
        ocls.UserID=1;
        ocls.Status=true;
        if ([clsUserEncryptInfo insertData:ocls]) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.passworkTextFile.text;
            if (self.compite) {
                self.compite(self.passworkTextFile.text);
            }
            [self dismiss];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"updateTheTableView" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addCellToTableView" object:ocls];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
