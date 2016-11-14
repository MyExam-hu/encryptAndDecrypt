//
//  NoteViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 5/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "NoteViewController.h"
#import "clsUserEncryptInfo.h"
#import "AES.h"
#import "clsOtherFun.h"

@interface NoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.contentTextView.text=[AES decrypt:self.ocls.Content password:[clsOtherFun getAESPassword]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackClick:(UIButton *)sender {
    self.complite(self.contentTextView.text);
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
