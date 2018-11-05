//
//  JPUserViewController.m
//  encryptAndDecrypt
//
//  Created by LJP on 2018/10/21.
//  Copyright © 2018 huweidong. All rights reserved.
//

//宽
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
//高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#import "JPUserViewController.h"
#import "userTableViewCell.h"
#import "userHeadView.h"
#import "JPSetNewNameOrSignatureVC.h"

@interface JPUserViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) userHeadView * headView;

@property(nonatomic,strong)UIImagePickerController *imagePickerVC;

@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation JPUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    
    //把tabelview加进来
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    //给值给头像
    UIImage *userimage = [[UIImage alloc]initWithContentsOfFile:UserImagePath];
    
    self.headView.imageV.image = userimage;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initData];
    [self.tableView reloadData];
}

- (void)initData {
    
    self.dataArr = [[NSMutableArray alloc]init];
    [self.dataArr removeAllObjects];
    
    NSArray *tmpSelectArr = [NSArray arrayWithArray:[clsUserInfo selectData]];
    clsUserInfo *tmpInfo = [tmpSelectArr lastObject];
    
//    [clsUserInfo updateData:updateInfo];
    
    userModel * model1 = [[userModel alloc]init];
    model1.name = @"昵称:";
        
    model1.content = tmpInfo.name;
    [self.dataArr addObject:model1];
    
    userModel * model2 = [[userModel alloc]init];
    model2.name = @"签名:";
    model2.content = tmpInfo.gxqm;
    [self.dataArr addObject:model2];
    
}

#pragma mark ============================== 代理方法 ==============================
#pragma mark - tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//设置组头高度
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    if (section == 0) {
        v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.01);
    }
    
    return v;
}

//每一个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

//点击cell的时候改变透明度
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    userTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.alpha = 0.5;
}

//恢复透明度
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    userTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.alpha = 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    userTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"userTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArr[indexPath.row];
    
    if (indexPath.row != 0) {
        cell.lineView1.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%zd组，第%zd个",indexPath.section,indexPath.row);
    
    JPSetNewNameOrSignatureVC *vc = [JPSetNewNameOrSignatureVC new];

    if (indexPath.row == 0) {
        vc.titleTag = 0;
        
    }else {
        vc.titleTag = 1;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.headView.m_image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //把图片存在沙盒里
    [UIImageJPEGRepresentation(self.headView.m_image, 1) writeToFile:UserImagePath  atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark ============================== 事件处理 ==============================

//选择头像
- (void)changeImage {
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}


#pragma mark ============================== 访问器方法 ==============================

- (UITableView *)tableView {
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        //取消分割线
        _tableView.separatorStyle = NO;
        
        //设置头像
        _tableView.tableHeaderView = self.headView;
        
        [_tableView registerClass:[userTableViewCell class] forCellReuseIdentifier:@"userTableViewCell"];
        
    }
    return _tableView;
}

- (userHeadView *)headView {
    if (_headView == nil) {
        _headView = [[userHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _headView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage)];
        [_headView addGestureRecognizer:tap];
    }
    return _headView;
}


- (UIImagePickerController *)imagePickerVC{
    if(_imagePickerVC == nil){
        _imagePickerVC = [[UIImagePickerController alloc]init];
        _imagePickerVC.delegate = self;
        [_imagePickerVC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    return _imagePickerVC;
}

@end
