//
//  clsResponseResult.h
//  Eateraction
//
//  Created by canduo on 18/8/2015.
//  Copyright (c) 2015年 zxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clsResponseResult : NSObject

@property (copy, nonatomic) NSString * verson;
@property (copy, nonatomic) NSString * requestType;
@property (copy, nonatomic) NSString * requestId;
@property (copy, nonatomic) NSString * respCode;
@property (copy, nonatomic) NSString * respMessage;
@property (strong, nonatomic) NSDictionary * context;

+ (clsResponseResult *)deSerializeObj:(NSDictionary *)obj;

@end
