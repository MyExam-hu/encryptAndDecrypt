//
//  JPSetNewNameOrSignatureVC.m
//  encryptAndDecrypt
//
//  Created by LJP on 2018/10/21.
//  Copyright © 2018 huweidong. All rights reserved.
//

#import "JPSetNewNameOrSignatureVC.h"

@interface JPSetNewNameOrSignatureVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textV;

@property (nonatomic, strong) UILabel *qdLabel;


@end

@implementation JPSetNewNameOrSignatureVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

- (void)initUI {
    
    if (_textV == nil) {
        
        _textV = [[UITextView alloc]initWithFrame:CGRectMake(16, 66, SCREEN_WIDTH-32, 28)];
        _textV.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:0.9];
        _textV.delegate = self;
        
        [self.view addSubview:_textV];
    }
    
    if (_qdLabel == nil) {
        
        _qdLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, SCREEN_HEIGHT-260, SCREEN_WIDTH-160, 80)];
        
        _qdLabel.text = @"确定";
        
        _qdLabel.backgroundColor = [UIColor blueColor];
        
        _qdLabel.textAlignment = NSTextAlignmentCenter;
        
        //画圆 圆角
        _qdLabel.layer.cornerRadius = _qdLabel.bounds.size.height/2.0;
        
        _qdLabel.layer.masksToBounds = YES;
        
        //创建手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickQD)];
        
        _qdLabel.userInteractionEnabled = YES;
        
        [_qdLabel addGestureRecognizer:tap];
        
        [self.view addSubview:_qdLabel];
        

        
        //创建手势
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
        
        self.view.userInteractionEnabled = YES;
        
        [self.view addGestureRecognizer:tap1];
        
        
        [self.textV becomeFirstResponder];;
        
    }
    
}

- (void)clickView {
    
    [self.textV resignFirstResponder];
}

- (void)clickQD {
    
    if (self.titleTag == 0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.textV.text forKey:@"kUserName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else if (self.titleTag == 1){
        
        [[NSUserDefaults standardUserDefaults] setObject:self.textV.text forKey:@"kUserQM"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    NSLog(@"a");
    
    if (textView.text.length>7) {
        
        textView.text = [textView.text substringToIndex:7];
        
    }
    
}


@end
