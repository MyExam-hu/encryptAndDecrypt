//
//  FCHRefreshIconView.h
//  SummaryPro
//
//  Created by echo_hu on 19/6/17.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCHRefreshIconView : UIView

@property (nonatomic, assign) CGFloat drawLineWidth;//默认6.0
@property (nonatomic, strong) UIColor *lineColor;

- (UIImage *)createViewImageWith:(CGFloat)radian;

@end
