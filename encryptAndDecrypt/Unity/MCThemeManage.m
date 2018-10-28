//
//  MCThemeManage.m
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import "MCThemeManage.h"

@implementation MCThemeManage

static MCThemeManage* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

- (instancetype)init {

    if (self=[super init]) {
        
        _bgColor = PLACE_COLOR;
        _textColor = [UIColor blackColor];
        _fontSize = 17.0;
        
    }
    return self;
}



@end
