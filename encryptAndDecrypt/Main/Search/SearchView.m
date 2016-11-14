//
//  SearchView.m
//  encryptAndDecrypt
//
//  Created by huweidong on 18/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "SearchView.h"
#import "SearchResultViewController.h"

@interface SearchView()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textFieldV;
@property (nonatomic, strong) NSMutableArray* arrDict;
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation SearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self=[[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil] lastObject];
        self.frame=frame;
        [self loadData];
        [self loadingTableView];
        
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    self.tableView=nil;
    self.arrDict=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    CGRect rect=[UIScreen mainScreen].bounds;
    
    if (self.arrDict.count*44+44>rect.size.height-height-44-8) {
        self.tableView.frame=CGRectMake(8, 44 + 8 + 20, rect.size.width - 16,rect.size.height-height-44-8);
    }else{
        self.tableView.frame=CGRectMake(8, 44 + 8 + 20, [UIScreen mainScreen].bounds.size.width - 16, self.arrDict.count * 44 + 44);
    }
}

-(void)loadData{
    self.arrDict=[NSMutableArray array];
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"search.plist"];
    self.arrDict = [NSMutableArray arrayWithContentsOfFile:path];
    if (!_arrDict) {
        self.arrDict=[NSMutableArray array];
    }
}

-(void)loadingTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 44 + 8 + 20, [UIScreen mainScreen].bounds.size.width - 16, self.arrDict.count * 44 + 44) style:UITableViewStylePlain];
    
    [self.textFieldV becomeFirstResponder];
    [self loadData];
    if (self.arrDict.count) {
        [self addSubview:self.tableView];
    }
    
    self.textFieldV.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.sectionFooterHeight = 44;
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (IBAction)backBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        [self.textFieldV resignFirstResponder];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)searchBtnClick:(id)sender {
    if (self.textFieldV.text.length) {
        NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"search.plist"];
        BOOL haveSameList=NO;
        for (int i=0; i<self.arrDict.count; i++) {
            if ([self.arrDict[i] isEqualToString:self.textFieldV.text]) {
                haveSameList=YES;
            }
        }
        if (!haveSameList) {
            [self.arrDict addObject:self.textFieldV.text];
            [self.arrDict writeToFile:path atomically:YES];
        }
        [self backBtnClick:nil];
        SearchResultViewController *vc=[[SearchResultViewController alloc] init];
        vc.keyword=[self.textFieldV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self.parentVC.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    self.textFieldV.text = self.arrDict[indexPath.row];
    if (self.textFieldV.text.length) {
        //[self removeFromSuperview];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.arrDict.count);
    return self.arrDict.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    static NSString* ID = @"search";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    cell.textLabel.text = self.arrDict[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"ic_search_history1"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
    UIButton* clear = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [clear setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    [clear setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    clear.backgroundColor = [UIColor whiteColor];
    clear.titleLabel.textAlignment = NSTextAlignmentCenter;
    clear.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [clear addTarget:self action:@selector(clearClick:) forControlEvents:UIControlEventTouchUpInside];
    return clear;
}

- (void)clearClick:(UIButton*)btn{
    [self.arrDict removeAllObjects];
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"search.plist"];
    [self.arrDict writeToFile:path atomically:YES];
    [self.tableView reloadData];
    [self.tableView removeFromSuperview];
}

#pragma mark-UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchBtnClick:nil];
    return YES;
}

@end
