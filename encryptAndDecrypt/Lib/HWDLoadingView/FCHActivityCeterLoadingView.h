//
//  FCHActivityCeterLoadingView.h
//  Facechat
//
//  Created by echo_hu on 1/11/17.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCHActivityCeterLoadingView : UIView

/**
 根据缩放倍数初始化

 @param scale 缩放倍数（0-1）
 @return 初始化对象
 */
- (instancetype)initWithScale:(CGFloat)scale;

-(void)startAnimating;

-(void)stopAnimating;

@end
