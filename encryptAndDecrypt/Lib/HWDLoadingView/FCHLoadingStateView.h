//
//  FCHLoadingStateView.h
//  Facechat
//
//  Created by echo_hu on 8/9/17.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCHVarietyStyleLoadingView.h"

typedef NS_ENUM(NSUInteger, FCHLoadingStateViewStatus) {
    FCHLoadingStateViewStatusLoading = 0,      /**< 加载中 */
    FCHLoadingStateViewStatusNoData,           /**< 没有数据 */
    FCHLoadingStateViewStatusSuccess,          /**< 加载成功 */
    FCHLoadingStateViewStatusFailure,          /**< 加载失败 */
};



@protocol FCHLoadingStateViewDelegate <NSObject>

- (void)reloadData;

@end

@interface FCHLoadingStateView : UIView

@property (nonatomic, weak) id<FCHLoadingStateViewDelegate> delegate;

/**
 设置加载的状态
 */
@property (nonatomic, assign) FCHLoadingStateViewStatus loadingStatus;

/**
 是否隐藏图标
 */
@property (nonatomic, assign) BOOL hiddenLogo;

/**
 设置没有数据时的图片
 */
@property (nonatomic, strong) UIImage *noDataImage;

/**
 设置没有数据时的文案
 */
@property (nonatomic, copy) NSString *noDataStr;


/**
 设置加载成功后是否移除View(默认为YES)
 */
@property (nonatomic, assign) BOOL successAfterRemoveView;

@property (nonatomic, assign) FCHVarietyStyleLoadingViewType loadingType;

@end
