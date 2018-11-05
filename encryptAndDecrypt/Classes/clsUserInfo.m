//
//  clsUserInfo.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsUserInfo.h"
#import "FMDB.h"
#import "MJExtension.h"
#import "clsOtherFun.h"
#import "clsTableInfo.h"

@implementation clsUserInfo

-(instancetype)init{
    self=[super init];
    if (self) {
        self.Account=@"";
        self.Password=@"";
        self.Status=false;
        self.Email=@"";
        self.MobilePhone=@"";
    }
    return self;
}

+(void)createTable{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"create table %@ (id integer primary key AutoIncrement,Account text not null, Password text not null, Status bool not null, Email text, MobilePhone text, name text, gxqm text)",USER_INFO_TABLE];
        BOOL result = [db executeUpdate:sqlStr];
        if (result)
        {
            NSLog(@"创建表成功");
        }
    }
    [db close];
    
    NSDate *nowDate=[NSDate new];
    NSString *nowDateStr=[clsOtherFun dateFormatToString:nowDate];
    clsTableInfo *objTableInfo=[[clsTableInfo alloc] init];
    objTableInfo.CreateTime=nowDateStr;
    objTableInfo.TableName=USER_INFO_TABLE;
    [clsTableInfo insertData:objTableInfo];
}

+(NSMutableArray *)selectData{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    NSMutableArray *results = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"select * from %@",USER_INFO_TABLE];
        FMResultSet *resultSet = [db executeQuery:sqlStr];
        while ([resultSet  next]){
            clsUserInfo *obj=[clsUserInfo mj_objectWithKeyValues:[resultSet resultDictionary]];
            [results addObject:obj];
        }
    }
    [db close];
    return results;
}

+(NSMutableArray *)selectDataWhere :(NSString *)accountStr :(NSString *)passwordStr{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    NSMutableArray *results = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"select * from %@ where Status=1 and Account='%@' and Password='%@'",USER_INFO_TABLE,accountStr,passwordStr];
        FMResultSet *resultSet = [db executeQuery:sqlStr];
        while ([resultSet  next]){
            clsUserInfo *obj=[clsUserInfo mj_objectWithKeyValues:[resultSet resultDictionary]];
            [results addObject:obj];
        }
    }
    [db close];
    return results;
}

+(void)insertData :(clsUserInfo *)obj{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"insert into %@ (Account,Password,Status) values ('%@','%@',%i)",USER_INFO_TABLE,obj.Account,obj.Password,obj.Status];
        BOOL result = [db executeUpdate:sqlStr];
        if (result){
            NSLog(@"插入数据成功");
        }
    }
    [db close];
}

+(BOOL)updatePwdWith:(clsUserInfo *)changeObj checkObj:(clsUserInfo *)checkObj {
    
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"update UserInfo set Account = '%@',Password = '%@' where Account = '%@' and Password = '%@'", changeObj.Account, changeObj.Password,checkObj.Account,checkObj.Password];
        BOOL result = [db executeUpdate:sqlStr];
        if (result){
            NSLog(@"更新数据成功");
            return YES;
        }
    }
    [db close];
    return NO;
}

@end
