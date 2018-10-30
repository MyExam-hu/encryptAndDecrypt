//
//  clsUserInfo.h
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clsUserInfo : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *Account;
@property (nonatomic, copy) NSString *Password;
@property (nonatomic, assign) BOOL Status;
@property (nonatomic, copy) NSString *Email;
@property (nonatomic, copy) NSString *MobilePhone;

+(void)createTable;
+(NSMutableArray *)selectData;
+(NSMutableArray *)selectDataWhere :(NSString *)accountStr :(NSString *)passwordStr;
+(void)insertData :(clsUserInfo *)obj;
+(BOOL)updatePwdWith:(clsUserInfo *)changeObj checkObj:(clsUserInfo *)checkObj;

@end
