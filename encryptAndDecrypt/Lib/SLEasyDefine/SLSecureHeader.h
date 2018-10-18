//
//  SLSecureHeader.h
//  SLControl
//
//  Description：类型安全判断
//
//  Created by chenjm on 15/5/29.
//  Copyright (c) 2015年 poco. All rights reserved.
//

#ifndef SLControl_SLSecureHeader_h
#define SLControl_SLSecureHeader_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


static inline bool isUsableArray(id array, NSInteger index) {
    if (array && [array isKindOfClass:[NSArray class]] && (NSInteger)((NSArray *)array).count > index && index >= 0) {
        return YES;
    }
    
    return NO;
}

static inline bool isUsableDictionary(id dic) {
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    
    return NO;
}

static inline bool isUsableNSString(id aString, NSString *inequalString) {
    if (inequalString == nil) {
        if (aString && [aString isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    else {
        if (aString && [aString isKindOfClass:[NSString class]] && ![(NSString *)aString isEqualToString:inequalString]) {
            return YES;
        }
    }
    return NO;
}

static inline bool isUsable(NSObject *object, Class aClass) {
    if (object && [object isKindOfClass:aClass]) {
        return YES;
    }
    
    return NO;
}




#endif
