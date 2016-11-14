//
//  SearchResultViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 18/5/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "SearchResultViewController.h"
#import "clsUserEncryptInfo.h"
#import "HomeTableViewCell.h"
#import "clsOtherFun.h"
#import "ContentDetailViewController.h"
#import "SearchView.h"

static NSString *identifier=@"HomeTableViewCell";

@interface SearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,homeTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchKeyWordTextFile;
@property (strong, nonatomic) NSMutableArray *list;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchKeyWordTextFile.text=self.keyword;
    self.list=[clsUserEncryptInfo selectDataFrom:self.keyword];
    
    UIView *view=[[UIView alloc] init];
    [self.tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)searchClick:(id)sender {
    SearchView *searchView=[[SearchView alloc] initWithFrame:self.view.bounds];
    searchView.parentVC=self;
    searchView.alpha=0;
    [self.view addSubview:searchView];
    [UIView animateWithDuration:0.25 animations:^{
        searchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        searchView.alpha=1;
        [self.view bringSubviewToFront:searchView];
    }];
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
        [self.navigationController presentViewController:nav animated:YES completion:^{
            NSLog(@"11111111");
        }];
    });
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
