//
//  userTableViewCell.m
//  xiaoyuanlingshou
//
//  Created by MJW on 21/3/18.
//  Copyright © 2018年 mjw. All rights reserved.
//

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "userTableViewCell.h"

@interface userTableViewCell()

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) UIView * lineView;


@end

@implementation userTableViewCell

//创建cell会走的方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
    
}

- (void)initUI {
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.lineView1];
    
}

-(void)setModel:(userModel *)model {
    _model = model;
    
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.content;
}

//左边的内容 比如 姓名 地址 手机
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 16, 40, 32)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

//右边的内容 比如 姓名 地址 手机 等的具体内容
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(56+2, 16, SCREEN_WIDTH-58-16, 32)];
        _contentLabel.font = [UIFont systemFontOfSize:16];
    }
    return _contentLabel;
}

//分割线
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor = [UIColor darkGrayColor];
    }
    return _lineView;
}

- (UIView *)lineView1 {
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _lineView1.backgroundColor = [UIColor darkGrayColor];
    }
    return _lineView1;
}

@end
