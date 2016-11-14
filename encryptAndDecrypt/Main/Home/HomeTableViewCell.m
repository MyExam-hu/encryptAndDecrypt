//
//  HomeTableViewCell.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "RWLabel.h"
#import "clsUserEncryptInfo.h"
#import "HomeTableViewCell.h"
#import "clsOtherFun.h"

@interface HomeTableViewCell()

@property (weak, nonatomic) IBOutlet RWLabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbPassword;
@property (weak, nonatomic) IBOutlet RWLabel *lbContent;


@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadData{
    self.lbTitle.text=self.cls.Title;
    self.lbAccount.text=self.cls.EncryptAccount;
    self.lbPassword.text=self.cls.EncryptPasswork;
    self.lbContent.text=self.cls.Content;
}

- (IBAction)btnDelClick:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此条数据?"delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    alert.tag=100;
    [alert show];
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex && alertView.tag==100) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(DelCellAtList:)]) {
            [self.delegate DelCellAtList:self.cls];
        }
    }
}


@end
