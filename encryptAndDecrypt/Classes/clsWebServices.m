//
//  clsWebServices.m
//  SummaryPro
//
//  Created by huweidong on 28/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsWebServices.h"
#import <AFNetworking.h>
#import "clsOtherFun.h"


@interface clsWebServices(){
    struct{
        unsigned int webService_Success :1;
        unsigned int webService_Fail :1;
    }_delegateFlags;
}

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation clsWebServices

-(void)dealloc{
    self.manager=nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager=[AFHTTPSessionManager manager];
//        self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
//        self.manager.requestSerializer.timeoutInterval=30;
//        self.manager.responseSerializer=[AFJSONResponseSerializer serializer];
//        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    }
    return self;
}

-(void)setDelegate:(id<clsWebServiceDelegate>)delegate{
    _delegate=delegate;
    _delegateFlags.webService_Success=delegate && [delegate respondsToSelector:@selector(WebService_Success::)];
     _delegateFlags.webService_Fail=delegate && [delegate respondsToSelector:@selector(WebService_Fail:)];
}

-(void)controlSDKSwitch {
    NSMutableDictionary * para = [NSMutableDictionary dictionary] ;
    [self get:@"control_sdk_switch" :SDKSwitch :para];
}

-(void)post:(NSString *)method :(WebServiceType)type :(NSDictionary *)para{
    NSString * url=[clsOtherFun getWSURL:method];
    
    [self.manager POST:url parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self deSerializeClass:type :responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code!=-999){
            if(self.delegate && [self.delegate respondsToSelector:@selector(WebService_Fail:)]){
                [self.delegate WebService_Fail:type];
            }
        }
    }];
    
    
}

-(void)get:(NSString *)method :(WebServiceType)type :(NSDictionary *)para{
    NSString * ulr=[clsOtherFun getWSURL:method];
    [self.manager GET:ulr parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self deSerializeClass:type :responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@",error);
        //        NSHTTPURLResponse *response=(NSHTTPURLResponse *)task.response;
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSLog(@"Response Body:%@",[[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding]);
        if(errorData){
            NSError * perror=nil;
            id obj=[NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingAllowFragments error:&perror];
            if (!perror) {
                if([obj isKindOfClass:[NSDictionary class]]){
                    NSDictionary * data=(NSDictionary *) obj;
                    if ([data[@"error"] isEqualToString:@"invalid_token"]) {
                        return;
                    }
                }
            }
        }
        if(error.code!=-999){
            if(self.delegate && [self.delegate respondsToSelector:@selector(WebService_Fail:)]){
                [self.delegate WebService_Fail:type];
            }
        }
    }];
    
}

-(void)deSerializeClass:(WebServiceType)type :(id)obj{
    if(obj && [obj isKindOfClass:[NSDictionary class]])
    {
        clsResponseResult * cls=[clsResponseResult deSerializeObj:obj];
        switch (type)
        {
            case SDKSwitch:
                break;
            default:
                break;
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(WebService_Success::)])
        {
            [self.delegate WebService_Success:type :cls];
        }
    }else
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(WebService_Fail:)])
        {
            [self.delegate WebService_Fail:type];
        }
    }
}



-(void)cancel {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager.operationQueue cancelAllOperations];
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
