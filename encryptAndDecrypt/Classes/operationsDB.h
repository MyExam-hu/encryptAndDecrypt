//
//  operationsDB.h
//  encryptAndDecrypt
//
//  Created by huweidong on 13/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface operationsDB : NSObject

+(void)createDB;
+(void)insertData;
+(void)selectData;
+ (BOOL) isTableOK;

@end
