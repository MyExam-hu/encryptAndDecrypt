//
//  clsWebServices.h
//  SummaryPro
//
//  Created by huweidong on 28/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "clsResponseResult.h"

typedef NS_OPTIONS(NSUInteger, MyOptions) {
    MySDWebImageDownloaderLowPriority = 1 << 0,
    MySDWebImageDownloaderProgressiveDownload = 1 << 1
};

typedef NS_ENUM(NSUInteger, WebServiceType) {
    SDKSwitch
};

@protocol clsWebServiceDelegate <NSObject>

@optional

- (void)WebService_Success:(WebServiceType)pserviceType :(clsResponseResult *)result;
- (void)WebService_Fail:(WebServiceType)pserviceType;

@end

typedef void(^webServiceSuccessBlock) (NSString *result);
typedef void(^webService_FailBlock) (NSError *error);
typedef void(^webServiceFinish) (NSData *result,NSError *error);

@interface clsWebServices : NSObject

@property (nonatomic, weak) id<clsWebServiceDelegate> delegate;

-(void)controlSDKSwitch;

@end
