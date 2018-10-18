//
//  FCHLoadingView.h
//  Facechat
//
//  Created by 许孝泳 on 2017/6/30.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCHLoadingView : UIView

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor;

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor iconViewWH:(CGFloat)iconViewWH imageWH:(CGFloat)imageWH drawLineWidth:(CGFloat)drawLineWidth;

- (void)show;

- (void)hide;

@end
