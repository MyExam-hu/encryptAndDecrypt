//
//  FCHRefreshIconView.m
//  SummaryPro
//
//  Created by echo_hu on 19/6/17.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import "FCHRefreshIconView.h"

#import "UIImage+FCHRotateFlip.h"

@implementation FCHRefreshIconView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.drawLineWidth = 6.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //获取ctx
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, self.drawLineWidth);
    if (self.lineColor) {
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    }else{
        CGContextSetStrokeColorWithColor(context, [SLUIColor colorWithHexString:@"196eff"].CGColor);
    }
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextStrokePath(context);
    
}

- (UIImage *)createViewImageWith:(CGFloat)radian {
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image rotateImageWithRadian:radian cropMode:FCHCropExpand];
}

@end
