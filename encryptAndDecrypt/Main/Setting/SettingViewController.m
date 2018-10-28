//
//  SettingViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "SettingViewController.h"
#import "MCFontSettingViewController.h"
#import "MCSkipSwitchViewController.h"
#import "MCChangePasswordViewController.h"
#import "MCAboutViewController.h"
#import "MCFeedbackViewController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrayDS;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.handelNavBarState) {
        self.handelNavBarState(NO);
    }
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if (self.handelNavBarState) {
        self.handelNavBarState(YES);
    }
}

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /**
     *  表格视图样式
     *  UITableViewStylePlain //无分区样式
     UITableViewStyleGrouped //分区样式
     */
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-50-64) style:UITableViewStylePlain];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * str = @"cellStr";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        //副标题样式
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:[MCThemeManage shareInstance].fontSize];
    ///<4.>设置单元格上显示的文字信息
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"字体设置";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"皮肤切换";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"修改密码";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"一键生成密码";
        }
        
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关于我们";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"留言反馈";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"退出登录";
        }
    }
    
    cell.detailTextLabel.text = @">";
    
    return cell;
}

//添加标头中的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
    }
    headerView.contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    
    return headerView;
}

//设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}


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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *ctrl = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ctrl = [[MCFontSettingViewController alloc] init];
        } else if (indexPath.row == 1) {
            ctrl = [[MCSkipSwitchViewController alloc] init];
        } else if (indexPath.row == 2) {
            ctrl = [[MCChangePasswordViewController alloc] init];
        } else if (indexPath.row == 3) {
            // 一键生成密码
            return;
        }
        
    } else {
        if (indexPath.row == 0) {
            ctrl = [[MCAboutViewController alloc] init];
        } else if (indexPath.row == 1) {
            ctrl = [[MCFeedbackViewController alloc] init];
        } else if (indexPath.row == 2) { // 退出登录
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            NSString *selectCellStr = cell.textLabel.text;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:selectCellStr preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                if (self.handelPopRootView) {
                    self.handelPopRootView();
                }
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:sureAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
    }
    
    if (ctrl) {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}



@end
