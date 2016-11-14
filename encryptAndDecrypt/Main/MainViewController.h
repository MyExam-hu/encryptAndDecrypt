//
//  MainViewController.h
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property(nonatomic, strong)UINavigationController* currentController;
@property(nonatomic, assign) NSInteger selectIndex;
@property (strong, nonatomic) UIView * contentView;

@end
