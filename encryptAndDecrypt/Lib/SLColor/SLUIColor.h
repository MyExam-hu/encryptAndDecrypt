//
//  SLUIColor.h
//  Pods
//
//  版本：1.0.4 （build 1.0.4.0）
//
//  Created by chenjm on 2016/10/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define SL_COLOR_RGB(r, g, b)           [UIColor colorWithRed:r green:g blue:b alpha:1]
#define SL_COLOR_RGBA(r, g, b, a)       [UIColor colorWithRed:r green:g blue:b alpha:a]

#define SL_COLOR_RGB_255(r, g, b)       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define SL_COLOR_RGBA_255(r, g, b, a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define SL_COLOR_HEX_STR(hex, alpha)   [SLUIColor colorWithHex:hex alpha:alpha]

@interface SLUIColor : NSObject

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(NSInteger)hexValue ;
+ (NSString *)hexFromUIColor:(UIColor *)color;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
