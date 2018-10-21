//
//  clsResponseResult.m
//  Eateraction
//
//  Created by canduo on 18/8/2015.
//  Copyright (c) 2015年 zxd. All rights reserved.
//

#import "clsResponseResult.h"
#import "clsOtherFun.h"


@implementation clsResponseResult

@synthesize verson;
@synthesize requestType;
@synthesize requestId;
@synthesize respCode;
@synthesize respMessage;
@synthesize context;

- (instancetype)init
{
    self = [super init];
    if (self) {
        verson=@"";
        requestType=@"";
        requestId=@"";
        respCode=@"";
        respMessage=@"";
        context=nil;
    }
    return self;
}

+ (clsResponseResult *)deSerializeObj:(NSDictionary *)obj{
    
//    NSDictionary * head=obj[@"head"];
//    clsResponseResult *objinstance=[[clsResponseResult alloc] init];
//    for (int i=0; i<head.allKeys.count; i++) {
//        if ([objinstance respondsToSelector: [clsOtherFun selectorForColumnName:head.allKeys[i]]]) {
//            [clsOtherFun objectSetValue:objinstance :head.allKeys[i] :head.allValues[i]];
//        }
//    }
//    objinstance.respMessage=[objinstance.respMessage stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary * obdy=obj[@"body"];
////    NSLog(@"1111 %@",obdy);
//    objinstance.context = obdy;
//    return objinstance;
    return nil;
}

@end
