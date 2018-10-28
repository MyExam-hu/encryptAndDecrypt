//
//  MCCustomTopBar.h
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  MCCustomTopBarDelegate <NSObject>
@optional

- (void)topBarBack:(UIButton *)sender;

@end

@interface MCCustomTopBar : UIView

@property (nonatomic, weak) id <MCCustomTopBarDelegate> delegate;
@property (nonatomic, copy) NSString *title;

@end
