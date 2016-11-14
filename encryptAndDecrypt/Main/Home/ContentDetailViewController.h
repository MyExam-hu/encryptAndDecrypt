//
//  ContentDetailViewController.h
//  encryptAndDecrypt
//
//  Created by huweidong on 5/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class clsUserEncryptInfo;

@interface ContentDetailViewController : UIViewController

@property (strong, nonatomic) clsUserEncryptInfo *ocls;

-(void)loadData;

@end
