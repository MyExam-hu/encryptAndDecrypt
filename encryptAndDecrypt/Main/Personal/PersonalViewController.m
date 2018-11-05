//
//  PersonalViewController.m
//  encryptAndDecrypt
//
//  Created by huweidong on 14/4/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "PersonalViewController.h"
#import "GRMustache.h"
#import "JPUserViewController.h"

@interface PersonalViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    NSString *path=[[NSBundle mainBundle] bundlePath];
    NSURL *baseURL=[NSURL fileURLWithPath:path];
    NSString *htmlString=[self demoFormatWithName:@"echo" value:@"23333"];
    //加载html
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    //加载js
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"js"] encoding:NSUTF8StringEncoding error:nil]];
    
    
    //屏蔽入口
//    UIView *textV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    textV.backgroundColor = [UIColor orangeColor];
//    textV.userInteractionEnabled = YES;
//
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTextVeiw)];
//    [textV addGestureRecognizer:tap];
//
//    [self.view addSubview:textV];
    
}

- (void)clickTextVeiw {
    
    NSLog(@"a");
    
    JPUserViewController *vc = [JPUserViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)demoFormatWithName:(NSString *)name value:(NSString *)value{
    NSString *fileName=@"template.html";
    NSString *path=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
    NSString *template=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *renderObject=@{@"name":name,@"content":value};
    NSString *content=[GRMustacheTemplate renderObject:renderObject fromString:template error:nil];
    return content;
}

#pragma mark - webview
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.webView stringByEvaluatingJavaScriptFromString:@"setImageClickFunction()"];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *path=[[request URL] absoluteString];
    NSLog(@"%@",path);
    return YES;
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
