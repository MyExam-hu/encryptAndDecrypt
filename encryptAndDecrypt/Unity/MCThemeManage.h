//
//  MCThemeManage.h
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCThemeManage : NSObject

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CGFloat fontSize;

+ (instancetype)shareInstance;

@end
