//
//  UIImage+FCHRotateFlip.h
//  SummaryPro
//
//  Created by echo_hu on 19/6/17.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FCHRotateFlip)

typedef NS_ENUM(NSUInteger, FCHSvCropMode) {
    FCHCropClip = 1,//保持原来图片大小并剪裁
    FCHCropExpand = 2,//不剪裁
};


/**
 旋转图片

 @param radian 旋转角度
 @param cropMode 旋转模式
 @return 旋转后的图片
 */
- (UIImage*)rotateImageWithRadian:(CGFloat)radian cropMode:(FCHSvCropMode)cropMode;

@end
