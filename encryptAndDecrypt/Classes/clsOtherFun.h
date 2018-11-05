//
//  clsOtherFun.h
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_INFO_TABLE @"UserInfo"
#define USER_ENCRYPTINFO_TABLE @"UserEncryptInfo"
#define TABLEINFO_TABLE @"TableInfo"

@interface clsOtherFun : NSObject

+(NSString *) md5Encrypt: (NSString *) inPutText ;

+ (void)showLoadingView:(NSString *)title;
+ (void)hideLoadingView;

+(BOOL)theTableIsExist :(NSString *)tableName;

+(NSString *)getAESPassword;
+(void) showMessageByHUD:(NSString *)message;
+(void) showMessageByHUD:(NSString *)message delay:(NSTimeInterval)delay;

+(NSString *)dateFormatToString :(NSDate *)date;
+(NSDate *)stringFormatToDate:(NSString *)pDate;
+(NSDate *)getNowDate;

+(NSString*)getWSURL:(NSString *)url;

@end
