//
//  clsUserEncryptInfo.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "FMDB.h"
#import "clsUserEncryptInfo.h"
#import "clsOtherFun.h"
#import "MJExtension.h"
#import "clsTableInfo.h"

@implementation clsUserEncryptInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Title=@"";
        self.Content=@"";
        self.UserID=0;
        self.Status=false;
        self.EncryptAccount=@"";
        self.EncryptPasswork=@"";
        self.createDate=@"";
        self.updateDate=@"";
    }
    return self;
}

+(void)createTable{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"create table %@ (id integer primary key AutoIncrement,Title text not null, Content text, Status bool not null, UserID integer, EncryptAccount text, EncryptPasswork text, createDate text, updateDate text)",USER_ENCRYPTINFO_TABLE];
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
    objTableInfo.TableName=USER_ENCRYPTINFO_TABLE;
    [clsTableInfo insertData:objTableInfo];
}

+(BOOL)insertData :(clsUserEncryptInfo *)obj{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    BOOL result;
    
    NSDate *nowDate=[NSDate new];
    NSString *nowDateStr=[clsOtherFun dateFormatToString:nowDate];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"insert into %@ (Title,Content,UserID,Status,EncryptAccount,EncryptPasswork,createDate) values ('%@','%@',%i,%i,'%@','%@','%@')",USER_ENCRYPTINFO_TABLE,obj.Title ,obj.Content ,obj.UserID ,obj.Status ,obj.EncryptAccount ,obj.EncryptPasswork, nowDateStr];
        result = [db executeUpdate:sqlStr];
        if (result){
            NSLog(@"插入数据成功");
        }
    }
    [db close];
    return result;
}

+(BOOL)upDataTheOcl :(clsUserEncryptInfo *)obj{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    BOOL result;
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"update %@ set Title='%@',Content='%@',UserID=%i,EncryptAccount='%@',EncryptPasswork='%@' where id=%i",USER_ENCRYPTINFO_TABLE,obj.Title ,obj.Content ,obj.UserID ,obj.EncryptAccount ,obj.EncryptPasswork,obj.id];
        result = [db executeUpdate:sqlStr];
        if (result){
            NSLog(@"更新数据成功");
        }
    }
    [db close];
    return result;
}

+(BOOL)upDadaStatus :(int)delId{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    BOOL result;
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"update %@ set Status=0 where id=%i",USER_ENCRYPTINFO_TABLE,delId];
        result = [db executeUpdate:sqlStr];
        if (result){
            NSLog(@"更新数据成功");
        }
    }
    [db close];
    return result;
}

+(NSMutableArray *)selectData{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    NSMutableArray *results = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"select * from %@ where Status=1 order by createDate desc",USER_ENCRYPTINFO_TABLE];
        FMResultSet *resultSet = [db executeQuery:sqlStr];
        while ([resultSet  next]){
            clsUserEncryptInfo *obj=[clsUserEncryptInfo mj_objectWithKeyValues:[resultSet resultDictionary]];
            [results addObject:obj];
        }
    }
    [db close];
    return results;
}

+(NSMutableArray *)selectDataFrom :(NSString *)keyword{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    NSMutableArray *results = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"select * from %@ where Status=1 and Title LIKE '%%%@%%'  order by createDate desc",USER_ENCRYPTINFO_TABLE,keyword];
        FMResultSet *resultSet = [db executeQuery:sqlStr];
        while ([resultSet  next]){
            clsUserEncryptInfo *obj=[clsUserEncryptInfo mj_objectWithKeyValues:[resultSet resultDictionary]];
            [results addObject:obj];
        }
    }
    [db close];
    return results;
}

@end
