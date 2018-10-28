//
//  MCFontSettingViewController.m
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import "MCFontSettingViewController.h"
#import "MCCustomTopBar.h"

@interface MCFontSettingViewController ()<UITableViewDelegate, UITableViewDataSource, MCCustomTopBarDelegate>
@property (nonatomic, strong) NSMutableArray *arrayDS;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MCFontSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupSubviews];
}

- (void)setupDatas {
    self.arrayDS = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        NSString * str = [NSString stringWithFormat:@"iOS开发工程师%d",i];
        [self.arrayDS addObject:str];
    }
}

- (void)setupSubviews {
    
    MCCustomTopBar *backBtn = [[MCCustomTopBar alloc] initWithFrame:CGRectMake(0, StatusBarHeight, Screen_Width, TopBarHeight)];
    [self.view addSubview:backBtn];
    backBtn.title = @"字体设置";
    backBtn.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /**
     *  表格视图样式
     *  UITableViewStylePlain //无分区样式
     UITableViewStyleGrouped //分区样式
     */
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backBtn.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetHeight(backBtn.bounds)) style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor redColor];
    /**
     *  设置代理
     */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * str = @"cellStr";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        //副标题样式
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    ///<4.>设置单元格上显示的文字信息
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"小号字体";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"标准字体";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"大号字体";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"特大号字体";
        }
        
    }
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"字体大小";
//}

//设置表头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20.0f;
//}


/**
 *  设置单元格的高度
 *  单元格默认高度44像素
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.0f;
}

/**
 *  UITableViewDelegate协议中所有方法，用来对单元格自身进行操作(比如单元格的删除、添加、移动...)
 */
#pragma UITableViewDelegate

/**
 *  点击单元格触发该方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat fontSize = 17.0;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            fontSize = 15.0;
        } else if (indexPath.row == 1) {
            fontSize = 17.0;
        } else if (indexPath.row == 2) {
            fontSize = 19.0;
        } else if (indexPath.row == 3) {
            fontSize = 21.0;
        }
    }
    
    [MCThemeManage shareInstance].fontSize = fontSize;
}


- (void)topBarBack:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
