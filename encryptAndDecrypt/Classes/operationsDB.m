//
//  operationsDB.m
//  encryptAndDecrypt
//
//  Created by huweidong on 13/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "operationsDB.h"
#import "FMDB.h"

#define USERINFO_TABLE @"UserInfo"

@implementation operationsDB

+(void)createDB{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"create table %@ (Account text, Password text, Status bool, Email text, MobilePhone text)",USERINFO_TABLE];
        BOOL result = [db executeUpdate:sqlStr];
        if (result)
        {
            NSLog(@"创建表成功");
        }
    }
    [db close];
}

+(void)insertData{
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"insert into %@ (Account,Password) values ('blue','Aa123456')",USERINFO_TABLE];
        BOOL result = [db executeUpdate:sqlStr];
        if (result){
            NSLog(@"插入数据成功");
        }
    }
    [db close];
}

+(void)selectData{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    NSMutableArray *results = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"select * from %@",USERINFO_TABLE];
        FMResultSet *resultSet = [db executeQuery:sqlStr];
        while ([resultSet  next]){
            NSString *acount=[resultSet stringForColumn:@"Account"];
            NSString *password=[resultSet stringForColumn:@"Password"];
            NSLog(@"acount=%@",acount);
            NSLog(@"password=%@",password);
            [results addObject:[resultSet resultDictionary]];
        }
    }
    [db close];
}

// 判断是否存在表
+ (BOOL) isTableOK{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = 'UserInfo'"];
        while ([rs next])
        {
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
@end
