//
//  HomeViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "clsUserEncryptInfo.h"
#import "ContentDetailViewController.h"
#import "clsOtherFun.h"

static NSString *identifier=@"HomeTableViewCell";

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,homeTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *list;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *view=[[UIView alloc] init];
    [self.tableView setTableFooterView:view];
    self.list=[clsUserEncryptInfo selectData];
    //点击状态栏回到tableview顶部
    self.tableView.scrollsToTop=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheTableView) name:@"updateTheTableView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCellToTableView:) name:@"addCellToTableView" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.list=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addCellToTableView :(NSNotification *)sender{
    [self.view endEditing:YES];
    
    clsUserEncryptInfo *ocls=sender.object;
    [self.list insertObject:ocls atIndex:0];
    NSMutableArray *indexList=[[NSMutableArray alloc] init];
    NSIndexPath *index=[NSIndexPath indexPathForRow:0  inSection:0];
    [indexList addObject:index];
    [self.tableView insertRowsAtIndexPaths:indexList withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)updateTheTableView{
    self.list=[clsUserEncryptInfo selectData];
    [self.tableView reloadData];
}

#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    clsUserEncryptInfo *ocls = self.list[indexPath.row];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        if([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.cls=ocls;
    cell.delegate=self;
    [cell loadData];
    return cell;
}

#pragma mark-UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    clsUserEncryptInfo *ocls = self.list[indexPath.row];
    
    static HomeTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!sizingCell) {
            sizingCell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        }
    });
    sizingCell.cls = ocls;
    [sizingCell loadData];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    clsUserEncryptInfo *ocls = self.list[indexPath.row];
    ContentDetailViewController *vc=[[ContentDetailViewController alloc] initWithNibName:@"ContentDetailViewController" bundle:nil];
    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    vc.ocls=ocls;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBarHidden=YES;
    //[self.parentViewController.navigationController pushViewController:vc animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.parentViewController.navigationController presentViewController:nav animated:YES completion:^{
            NSLog(@"11111111");
        }];
    });
    
    
}

#pragma mark-homeTableViewCellDelegate
- (void)DelCellAtList:(clsUserEncryptInfo *)ocls{
    NSIndexPath *indexPath;
    for (int i=0; self.list.count; i++) {
        clsUserEncryptInfo *oclUserEncryptInfo=self.list[i];
        if (oclUserEncryptInfo.id==ocls.id) {
            indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            break;
        }
    }
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.list removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    if ([clsUserEncryptInfo upDadaStatus:ocls.id]) {
        [clsOtherFun showMessageByHUD:@"删除成功！"];
    }else{
        [clsOtherFun showMessageByHUD:@"删除失败,请重新尝试！"];
    }
}

@end
