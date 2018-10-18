//
//  SLFitHeader.h
//  SLControl
//
//  Created by chenjm on 15/6/1.
//  Copyright (c) 2015年 poco. All rights reserved.
//

#ifndef SLControl_SLFitHeader_h
#define SLControl_SLFitHeader_h

#import <Foundation/Foundation.h>

//屏幕的参数
#define SL_SCREEN_SCALE        ([[UIScreen mainScreen] scale])
#define SL_SCREEN_BOUNDS       ([[UIScreen mainScreen] bounds])
#define SL_SCREEN_FRAME        ([[UIScreen mainScreen] applicationFrame])
#define SL_SCREEN_SIZE         ([[UIScreen mainScreen] bounds].size)
#define SL_SCREEN_SIZE_F       ([[UIScreen mainScreen] applicationFrame].size)
#define SL_SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SL_SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define SL_SCREEN_HEIGHT_F     ([[UIScreen mainScreen] applicationFrame].size.height)

#define SL_WIDTH_320_RATE      ([[UIScreen mainScreen] bounds].size.width / 320.0)
#define SL_HIGHT_480_RATE      ([[UIScreen mainScreen] bounds].size.height / 480.0)


//获取UIView的参数
//view.frame
#define SL_VIEW_H(view)        CGRectGetHeight(view.frame)
#define SL_VIEW_W(view)        CGRectGetWidth(view.frame)
#define SL_VIEW_MIN_X(view)    CGRectGetMinX(view.frame)
#define SL_VIEW_MAX_X(view)    CGRectGetMaxX(view.frame)
#define SL_VIEW_MID_X(view)    CGRectGetMidX(view.frame)
#define SL_VIEW_MIN_Y(view)    CGRectGetMinY(view.frame)
#define SL_VIEW_MAX_Y(view)    CGRectGetMaxY(view.frame)
#define SL_VIEW_MID_Y(view)    CGRectGetMidY(view.frame)

//view.bounds
#define SL_VIEW_B_H(view)           CGRectGetHeight(view.bounds)
#define SL_VIEW_B_W(view)           CGRectGetWidth(view.bounds)
#define SL_VIEW_B_MIN_X(view)       CGRectGetMinX(view.bounds)
#define SL_VIEW_B_MAX_X(view)       CGRectGetMaxX(view.bounds)
#define SL_VIEW_B_MID_X(view)       CGRectGetMidX(view.bounds)
#define SL_VIEW_B_MIN_Y(view)       CGRectGetMinY(view.bounds)
#define SL_VIEW_B_MAX_Y(view)       CGRectGetMaxY(view.bounds)
#define SL_VIEW_B_MID_Y(view)       CGRectGetMidY(view.bounds)
#define SL_VIEW_LEFT_UP(view)       (view.frame.origin)
#define SL_VIEW_RIGHT_UP(view)      (CGPointMake(CGRectGetMaxX(view.frame), CGRectGetMinY(view.frame)))
#define SL_VIEW_LEFT_DOWN(view)     (CGPointMake(CGRectGetMinX(view.frame), CGRectGetMaxY(view.frame)))
#define SL_VIEW_RIGHT_DOWN(view)    (CGPointMake(CGRectGetMaxX(view.frame), CGRectGetMaxY(view.frame)))

//frame
#define SL_RECT_H(rect)             CGRectGetHeight(rect)
#define SL_RECT_W(rect)             CGRectGetWidth(rect)
#define SL_RECT_MIN_X(rect)         CGRectGetMinX(rect)
#define SL_RECT_MAX_X(rect)         CGRectGetMaxX(rect)
#define SL_RECT_MID_X(rect)         CGRectGetMidX(rect)
#define SL_RECT_MIN_Y(rect)         CGRectGetMinY(rect)
#define SL_RECT_MAX_Y(rect)         CGRectGetMaxY(rect)
#define SL_RECT_MID_Y(rect)         CGRectGetMidY(rect)
#define SL_RECT_LEFT_UP(rect)       (rect.origin)
#define SL_RECT_RIGHT_UP(rect)      (CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect)))
#define SL_RECT_LEFT_DOWN(rect)     (CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect)))
#define SL_RECT_RIGHT_DOWN(rect)    (CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect)))

//image
#define SL_IMAGE_W(image)           (image.size.width)
#define SL_IMAGE_H(image)           (image.size.height)
#define SL_IMAGE_BOUNDS(image)      (CGRectMake(0, 0, SL_IMAGE_W(image), SL_IMAGE_H(image)))
#define SL_IMAGE_FRAME(image, x, y, scale) (CGRectMake(x, y, SL_IMAGE_W(image) * scale, SL_IMAGE_H(image) * scale))

//按分辨率手动适配
//iphone4
#define SL_isIphone320_480     (SL_SCREEN_WIDTH > 319 && SL_SCREEN_WIDTH < 321 && SL_SCREEN_HEIGHT > 479 && SL_SCREEN_HEIGHT < 481)
//iphone5, iphone6放大版
#define SL_isIphone320_568     (SL_SCREEN_WIDTH > 319 && SL_SCREEN_WIDTH < 321 && SL_SCREEN_HEIGHT > 567 && SL_SCREEN_HEIGHT < 569)
//iphone6, iphone6+放大版
#define SL_isIphone375_667     (SL_SCREEN_WIDTH > 374 && SL_SCREEN_WIDTH < 376 && SL_SCREEN_HEIGHT > 666 && SL_SCREEN_HEIGHT < 668)
//iphone6+
#define SL_isIphone414_736     (SL_SCREEN_WIDTH > 413 && SL_SCREEN_WIDTH < 415 && SL_SCREEN_HEIGHT > 735 && SL_SCREEN_HEIGHT < 737)

//iPhoneX
#define SL_isIphone375_812     (SL_SCREEN_WIDTH > 374 && SL_SCREEN_WIDTH < 376 && SL_SCREEN_HEIGHT > 811 && SL_SCREEN_HEIGHT < 813)


#endif
