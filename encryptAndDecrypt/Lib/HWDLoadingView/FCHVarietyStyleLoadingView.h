//
//  FCHVarietyStyleLoadingView.h
//  Facechat
//
//  Created by 胡伟东 on 7/12/17.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FCHVarietyStyleLoadingViewType) {
    FCHVarietyStyleLoadingViewType1 = 0,
    FCHVarietyStyleLoadingViewType2,
};

@interface FCHVarietyStyleLoadingView : UIView

@property (nonatomic, assign) FCHVarietyStyleLoadingViewType loadingType;

-(void)startAnimating;

-(void)stopAnimating;

@end
