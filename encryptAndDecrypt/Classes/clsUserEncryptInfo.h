//
//  clsUserEncryptInfo.h
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clsUserEncryptInfo : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Content;
@property (nonatomic, assign) int UserID;
@property (nonatomic, assign) BOOL Status;
@property (nonatomic, copy) NSString *EncryptAccount;
@property (nonatomic, copy) NSString *EncryptPasswork;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *updateDate;

+(void)createTable;
+(BOOL)insertData :(clsUserEncryptInfo *)obj;
+(NSMutableArray *)selectData;
+(NSMutableArray *)selectDataFrom :(NSString *)keyword;
+(BOOL)upDataTheOcl :(clsUserEncryptInfo *)obj;
+(BOOL)upDadaStatus :(int)delId;

@end
