//
//  ContentDetailViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 5/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "ContentDetailViewController.h"
#import "clsUserEncryptInfo.h"
#import "AES.h"
#import "clsOtherFun.h"
#import "NoteViewController.h"

@interface ContentDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *btnEncryp;
@property (weak, nonatomic) IBOutlet UIImageView *goImageView;

@property (assign, nonatomic) BOOL isEditorStatus;

@end

@implementation ContentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.firstView.layer.borderWidth=0.5;
    self.firstView.layer.borderColor=[UIColor blackColor].CGColor;
    self.firstView.layer.cornerRadius=5;
    
    self.secondView.layer.borderWidth=0.5;
    self.secondView.layer.borderColor=[UIColor blackColor].CGColor;
    self.secondView.layer.cornerRadius=5;
    
    self.btnEncryp.layer.borderWidth=0.5;
    self.btnEncryp.layer.borderColor=[UIColor blackColor].CGColor;
    self.btnEncryp.layer.cornerRadius=5;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editorContent)];
    tap.numberOfTapsRequired = 1;
    [self.secondView addGestureRecognizer:tap];
    self.isEditorStatus=NO;
    self.btnEncryp.hidden=self.goImageView.hidden=YES;
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editorContent{
    if (self.isEditorStatus) {
        NoteViewController *vc=[[NoteViewController alloc] initWithNibName:@"NoteViewController" bundle:nil];
        vc.ocls=self.ocls;
        vc.complite=^(NSString *result){
            self.lbContent.text=result;
            self.ocls.Content=[AES encrypt:result password:[clsOtherFun getAESPassword]];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)loadData{
    self.titleTextField.text=self.ocls.Title;
    self.accountTextField.text=self.ocls.EncryptAccount;
    self.passwordTextField.text=self.ocls.EncryptPasswork;
    self.lbContent.text=self.ocls.Content;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTheTableView" object:nil];
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    if (!self.isEditorStatus) {
        self.accountTextField.text=[AES decrypt:self.accountTextField.text password:[clsOtherFun getAESPassword]];
        self.passwordTextField.text=[AES decrypt:self.passwordTextField.text password:[clsOtherFun getAESPassword]];
        self.lbContent.text=[AES decrypt:self.lbContent.text password:[clsOtherFun getAESPassword]];
        [self.btnRight setTitle:@"保存" forState:UIControlStateNormal];
        
        self.isEditorStatus=YES;
        [self editorStatus:self.isEditorStatus];
        self.btnEncryp.hidden=self.goImageView.hidden=NO;
    }else{
        self.ocls.Title=self.titleTextField.text;
        self.ocls.EncryptAccount=[AES encrypt:self.accountTextField.text password:[clsOtherFun getAESPassword]];
        self.ocls.EncryptPasswork=[AES encrypt:self.passwordTextField.text password:[clsOtherFun getAESPassword]];
        self.ocls.Content=[AES encrypt:self.lbContent.text password:[clsOtherFun getAESPassword]];
        [clsOtherFun showLoadingView:@"保存中......"];
        [self performSelector:@selector(saveTheData:) withObject:self.ocls afterDelay:1.0f];
    }
}

-(void)saveTheData :(clsUserEncryptInfo *)ocl{
    [self.view endEditing:YES];
    [clsOtherFun hideLoadingView];
    if ([clsUserEncryptInfo upDataTheOcl:ocl]) {
        [clsOtherFun showMessageByHUD:@"保存成功！"];
    }else{
        [clsOtherFun showMessageByHUD:@"保存失败！"];
    }
    
}

-(void)editorStatus :(BOOL )Status{
    [self.titleTextField setUserInteractionEnabled:Status];
    [self.accountTextField setUserInteractionEnabled:Status];
    [self.passwordTextField setUserInteractionEnabled:Status];
    [self.lbContent setUserInteractionEnabled:Status];
}

- (IBAction)btnEncrypClick:(id)sender {
    [self.btnRight setTitle:@"解密" forState:UIControlStateNormal];
    self.btnEncryp.hidden=self.goImageView.hidden=YES;
    self.isEditorStatus=NO;
    [self editorStatus:self.isEditorStatus];
    
    self.titleTextField.text=self.titleTextField.text;
    self.accountTextField.text=[AES encrypt:self.accountTextField.text password:[clsOtherFun getAESPassword]];
    self.passwordTextField.text=[AES encrypt:self.passwordTextField.text password:[clsOtherFun getAESPassword]];
    self.lbContent.text=[AES encrypt:self.lbContent.text password:[clsOtherFun getAESPassword]];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
