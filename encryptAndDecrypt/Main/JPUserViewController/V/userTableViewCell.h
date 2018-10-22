//
//  userTableViewCell.h
//  xiaoyuanlingshou
//
//  Created by MJW on 21/3/18.
//  Copyright © 2018年 mjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userModel.h"

@interface userTableViewCell : UITableViewCell

@property (nonatomic, strong) userModel * model;

@property (nonatomic, strong) UIView * lineView1;


@end
