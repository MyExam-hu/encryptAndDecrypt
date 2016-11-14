//
//  clsTableInfo.h
//  encryptAndDecrypt
//
//  Created by huweidong on 17/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clsTableInfo : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *TableName;
@property (nonatomic, copy) NSString *CreateTime;

+(void)createTable;
+(void)insertData :(clsTableInfo *)obj;

@end
