//
//  FCHCameraLoadingView.h
//  Facechat
//
//  Created by 胡伟东 on 20/4/18.
//  Copyright © 2018年 广州美人信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCHCameraLoadingView;

@protocol FCHCameraLoadingViewDelegate <NSObject>

- (void)loadingView:(FCHCameraLoadingView *)loadingView cancelClickButton:(UIButton *)cancenButton;
- (void)timeoutForLoadingView:(FCHCameraLoadingView *)loadingView;


@end

@interface FCHCameraLoadingView : UIView

@property (nonatomic, weak) id<FCHCameraLoadingViewDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval timeout;

- (void)showAnimation;
- (void)removeAnimation;

@end
