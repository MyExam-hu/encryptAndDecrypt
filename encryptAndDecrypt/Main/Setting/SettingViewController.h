//
//  SettingViewController.h
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MCHandelNavBarState)(BOOL hidden);

@interface SettingViewController : UIViewController

@property (nonatomic,copy) MCHandelNavBarState handelNavBarState;

@end
