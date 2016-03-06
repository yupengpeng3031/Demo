//
//  BaseTabBarViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "FirstViewController.h"
#import "YearViewController.h"
@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewController];

}
-(void)createViewController {
    
    FirstViewController *FVC = [[FirstViewController alloc]init];
    
    UIImage *image = [[UIImage imageNamed:@"nav_one_off"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *endImage = [[UIImage imageNamed:@"nav_one_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:@"首页" image:image selectedImage:endImage];
    
    FVC.tabBarItem = item;
    
    
    
    
    
    UINavigationController *NFVC = [[UINavigationController alloc]initWithRootViewController:FVC];
    
    
    [NFVC.navigationBar setBarTintColor:[UIColor colorWithRed:50/255.0 green:200/255.0 blue:100/255.0 alpha:1.0]];
    
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor purpleColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName, nil];
    
   [NFVC.navigationBar setTitleTextAttributes:dic1];

    
    
    
    YearViewController *YVC = [[YearViewController alloc]init];
    UIImage *yearImage = [[UIImage imageNamed:@"nav_three_off"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *endYearImage = [[UIImage imageNamed:@"nav_three_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *yearItem = [[UITabBarItem alloc]initWithTitle:@"我的春秋" image:yearImage selectedImage:endYearImage];
    YVC.tabBarItem = yearItem;
    UINavigationController *NYVC = [[UINavigationController alloc]initWithRootViewController:YVC];
    
    NSArray *tabbarSubViews = @[NFVC,NYVC];
    
    self.viewControllers = tabbarSubViews;
    
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
