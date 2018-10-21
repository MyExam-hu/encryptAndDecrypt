//
//  userHeadView.m
//  xiaoyuanlingshou
//
//  Created by MJW on 26/3/18.
//  Copyright © 2018年 mjw. All rights reserved.
//

#import "userHeadView.h"

@implementation userHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0,frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
//        lineView.backgroundColor = [UIColor darkGrayColor];
//        [self addSubview:lineView];

        UIImageView * imageV = [[UIImageView alloc]init];
        imageV.frame = CGRectMake(0, 0, self.frame.size.height-6, self.frame.size.height-6);
        imageV.center = self.center;
        
        imageV.frame =CGRectMake(imageV.frame.origin.x, imageV.frame.origin.y+5, self.frame.size.height-6, self.frame.size.height-6);
        
        //画圆 圆角
        imageV.layer.cornerRadius = self.frame.size.height/2.0-3;
        
        imageV.layer.masksToBounds = YES;
        
        [imageV.layer setBorderWidth:0.5];
        
        [imageV.layer setBorderColor:[UIColor grayColor].CGColor];
        
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        
        self.imageV = imageV;
        
        [self addSubview:imageV];
        
        //先到沙盒里看看有没有对应的图片
        UIImage *userimage = [[UIImage alloc]initWithContentsOfFile:UserImagePath];

        if (userimage) {
            self.imageV.image = userimage;
        }
        
        
        
    }
    return self;
}

- (void)setM_image:(UIImage *)m_image {
    
    _m_image = m_image;
    
    self.imageV.image = m_image;
}

@end
