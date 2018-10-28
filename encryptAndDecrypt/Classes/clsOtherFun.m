//
//  clsOtherFun.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "FMDB.h"
#import "clsOtherFun.h"
#import "LoadingView.h"
#import "CommonCrypto/CommonDigest.h"
#import "MBProgressHUD.h"
#import "AES.h"

@implementation clsOtherFun

+(BOOL)theTableIsExist :(NSString *)tableName{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type ='table' and name = '%@'",tableName];
        FMResultSet *rs = [db executeQuery:sqlStr];
        while ([rs next]){
            // just print out what we've got in a number of formats.
            NSInteger count = [rs intForColumn:@"count"];
            NSLog(@"isTableOK %ld", (long)count);
            
            if (0 == count){
                [db close];
                return NO;
            }else{
                [db close];
                return YES;
            }
        }
    }
    [db close];
    return NO;
}

#pragma mark loadingView
static LoadingView *_newLoadingView = nil;
+ (void)showLoadingView:(NSString *)title {
    if (!_newLoadingView) {
        _newLoadingView =[[LoadingView alloc] initFullScreen:title];
    } else {
        [_newLoadingView setTitle:title];
    }
}

+ (void)hideLoadingView {
    if (_newLoadingView) {
        [_newLoadingView dismiss];
        _newLoadingView = nil;
    }
}

#pragma mark md5
+(NSString *) md5Encrypt: (NSString *) inPutText{
    inPutText=[self changeStr:inPutText];
    
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+(NSString *)changeStr :(NSString *)str{
    NSString *keyStr=[AES encrypt:@"kill_blue" password:@"%&^$^&$&^"];
    NSString *resultStr=[NSString stringWithFormat:@"%@%@",keyStr,str];
    return resultStr;
}

+(NSString *)getAESPassword{
    return @"%^$&^*&%%^&";
}

+(void) showMessageByHUD:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.detailsLabelFont =[UIFont systemFontOfSize:15];
    hud.margin = 12;
    //    hud.cornerRadius=4.0;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];
}

+(NSString *)dateFormatToString :(NSDate *)date{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    NSString *strdate = [dateFormat stringFromDate:date];
    return strdate;
}

+(NSDate *)stringFormatToDate:(NSString *)pDate{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:pDate];
    return date;
}

+(NSDate *)getNowDate{
    //获取的NSDate date时间与实际相差8个小时解决方案
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString*)getWSURL:(NSString *)url {
    if (url) {
        return [NSString stringWithFormat:@"http://localhost:8081/%@",url];
    }
    return [NSString stringWithFormat:@"http://localhost:8081"];
}

@end
