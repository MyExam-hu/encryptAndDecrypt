//
//  AddDataView.h
//  encryptAndDecrypt
//
//  Created by huweidong on 16/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PaymentCallBack)(NSString *code);

@interface AddDataView : UIView

- (void)show:(PaymentCallBack)compite;

@end
