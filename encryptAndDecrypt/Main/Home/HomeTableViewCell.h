//
//  HomeTableViewCell.h
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class clsUserEncryptInfo;

@protocol homeTableViewCellDelegate <NSObject>

@optional
- (void)DelCellAtList:(clsUserEncryptInfo *)ocls;

@end

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) clsUserEncryptInfo *cls;
@property (nonatomic, assign) id<homeTableViewCellDelegate> delegate;

-(void)loadData;

@end
