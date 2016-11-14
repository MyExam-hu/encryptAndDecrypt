//
//  clsTableInfo.m
//  encryptAndDecrypt
//
//  Created by huweidong on 17/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsTableInfo.h"
#import "FMDB.h"
#import "clsOtherFun.h"

@implementation clsTableInfo

-(instancetype)init{
    self=[super init];
    if (self) {
        self.CreateTime=nil;
        self.TableName=nil;
    }
    return self;
}

+(void)createTable{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"create table %@ (id integer primary key AutoIncrement,TableName text not null, CreateTime text not null)",TABLEINFO_TABLE];
        BOOL result = [db executeUpdate:sqlStr];
        if (result)
        {
            NSLog(@"创建表成功");
        }
    }
    [db close];
}

+(void)insertData :(clsTableInfo *)obj{
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"Data.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        NSString *sqlStr=[NSString stringWithFormat:@"insert into %@ (TableName,CreateTime) values ('%@','%@')",TABLEINFO_TABLE,obj.TableName,obj.CreateTime];
        BOOL result = [db executeUpdate:sqlStr];
        if (result){
            NSLog(@"插入数据成功");
        }
    }
    [db close];
}

@end
