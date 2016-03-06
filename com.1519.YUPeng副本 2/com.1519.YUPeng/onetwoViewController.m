//
//  onetwoViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "onetwoViewController.h"

#import <WebKit/WebKit.h>

#import "MMProgressHUD.h"

#import "MMLinearProgressView.h"

@interface onetwoViewController ()<WKNavigationDelegate>

@property (nonatomic,strong)WKWebView *webView;

@property (nonatomic,strong)NSTimer *timer;

@end

@implementation onetwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createWebView];
}

-(void)createWebView {
    
    //实例化对象
    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:_webView];
    //_webView.userInteractionEnabled = NO;
    _webView.navigationDelegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL  URLWithString:_Link]];
    
    [_webView loadRequest:request];
    
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    if (!self.timer) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    }
    
    [MMProgressHUD setProgressViewClass:[MMLinearProgressView class]];
    
    [MMProgressHUD showDeterminateProgressWithTitle:@"下载" status:@"loading......"];
}

-(void)updateTimer:(NSTimer*)timer {
    
    [MMProgressHUD updateProgress:_webView.estimatedProgress];
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
    }
    
    [MMProgressHUD dismissWithSuccess:@"下载完成"];
    
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
    }
    [MMProgressHUD dismissWithError:@"下载失败"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
