//
//  MCSkipSwitchViewController.m
//  encryptAndDecrypt
//
//  Created by 南宫玄涵 on 18/10/20.
//  Copyright © 2018年 huweidong. All rights reserved.
//

#import "MCSkipSwitchViewController.h"
#import "MCCustomTopBar.h"

@interface MCSkipSwitchViewController ()<UITableViewDelegate, UITableViewDataSource, MCCustomTopBarDelegate>
@property (nonatomic, strong) NSMutableArray *arrayDS;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MCSkipSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupSubviews];
}

- (void)setupDatas {
    
    self.arrayDS = [NSMutableArray arrayWithObjects:[[UIColor redColor] colorWithAlphaComponent:0.5], [[UIColor blueColor] colorWithAlphaComponent:0.5],[[UIColor orangeColor] colorWithAlphaComponent:0.5],[[UIColor purpleColor] colorWithAlphaComponent:0.5],[[UIColor blackColor] colorWithAlphaComponent:0.5],PLACE_COLOR, nil];
}

- (void)setupSubviews {
    
    MCCustomTopBar *backBtn = [[MCCustomTopBar alloc] initWithFrame:CGRectMake(0, StatusBarHeight, Screen_Width, TopBarHeight)];
    [self.view addSubview:backBtn];
    backBtn.title = @"皮肤切换";
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
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayDS count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * str = @"cellStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        //副标题样式
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    
    UIView *tmpContent = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 180)];
    tmpContent.backgroundColor = self.arrayDS[indexPath.row];
    tmpContent.layer.cornerRadius = 10.0;
    tmpContent.layer.masksToBounds = YES;
    [cell.contentView addSubview:tmpContent];
//    cell.contentInset = UIEdgeInsetsMake(10, 10, 10, 10); //CGRectMake(10, 10, SCREEN_WIDTH-20, 180);
   
    return cell;
}

//设置表头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 15.0f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MCThemeManage shareInstance].bgColor = self.arrayDS[indexPath.row];
    [self topBarBack:nil];
}


- (void)topBarBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
