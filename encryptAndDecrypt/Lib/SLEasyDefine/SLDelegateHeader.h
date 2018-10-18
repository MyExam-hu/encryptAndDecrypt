//
//  SLDelegateHeader.h
//  SLControl
//
//  Created by chenjm on 15/5/29.
//  Copyright (c) 2015年 poco. All rights reserved.
//

#ifndef SLControl_SLDelegateHeader_h
#define SLControl_SLDelegateHeader_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define SLSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


static inline void SLPerformSelectInDelegateWithSender0(id delegate, SEL sel) {
    if (delegate != nil && [delegate respondsToSelector:sel]) {
        SLSuppressPerformSelectorLeakWarning([delegate performSelector:sel]);
    }
}

static inline void SLPerformSelectInDelegateWithSender(id delegate, SEL sel,id sender) {
    if (delegate != nil && [delegate respondsToSelector:sel]) {
        SLSuppressPerformSelectorLeakWarning([delegate performSelector:sel withObject:sender]);
    }
}

static inline void SLPerformSelectInDelegateWithSender2(id delegate, SEL sel,id object1, id object2) {
    if (delegate != nil && [delegate respondsToSelector:sel]) {
        SLSuppressPerformSelectorLeakWarning([delegate performSelector:sel withObject:object1 withObject:object2]);
    }
}


#endif
