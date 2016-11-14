//
//  NoteViewController.h
//  encryptAndDecrypt
//
//  Created by huweidong on 5/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseCallBack)(NSString *result) ;

@class clsUserEncryptInfo;

@interface NoteViewController : UIViewController

@property (strong, nonatomic) clsUserEncryptInfo *ocls;
@property (strong, nonatomic) ChooseCallBack complite;

@end
