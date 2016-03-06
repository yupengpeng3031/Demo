//
//  RootViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "RootViewController.h"

#import "Define.h"

#import "UIImageView+WebCache.h"

#import "HTTPEngine.h"

#import "BaseTabBarViewController.h"

#import "AppDelegate.h"

@interface RootViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    _scrollView.backgroundColor = [UIColor redColor];
    
    _scrollView.delegate = self;
    NSArray *imageNameArray = [self createDataArray];
    
    [self createImageView:imageNameArray];
    
    
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * imageNameArray.count, self.view.frame.size.height);
    
    
    self.scrollView.pagingEnabled = YES;

    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn.frame = CGRectMake(self.view.frame.size.width - 150, 40, 100, 50);
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    
}
//跳过按钮事件
-(void)skip:(UIButton*)sender {
    _scrollView.alpha = 0;
    [_scrollView removeFromSuperview];
    [self goMain];
}

- (void)createImageView:(NSArray*)imageNameArray {
    
    
    for (int i = 0; i < imageNameArray.count; i++) {
        
        UIImage *image = [UIImage imageNamed:imageNameArray[i]];
        UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
        //设置ImageView的内容模式
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        

        //拿到图片的frame
        CGRect imageViewFrame = imageView.frame;
        //让图片的宽度等于屏幕的宽度
        imageViewFrame.size.width = self.view.frame.size.width;
        imageViewFrame.size.height = self.view.frame.size.height;
        //设置每张图片的x 坐标，使他们排成一行
        imageViewFrame.origin.x = i*self.view.frame.size.width;
        //设置imageview 的frame
        
        imageView.frame = imageViewFrame;
        //添加到滚动视图上
        [_scrollView addSubview:imageView];
        
        //在最后一张图片上加个按钮
        if (i  == imageNameArray.count - 1) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            
            btn.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height - 100, 100, 50);
            
            btn.backgroundColor = [UIColor yellowColor];
            
            [btn setTitle:@"立即体验" forState:UIControlStateNormal];
            
            btn.clipsToBounds = YES;
            
            btn.layer.cornerRadius = 10;
            
            
            
            [imageView addSubview:btn];
            
            imageView.userInteractionEnabled = YES;
            
            [btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        }
    
    }
}
-(void)btnPressed {
    _scrollView.alpha = 0;
    [_scrollView removeFromSuperview];
    [self goMain];

}

-(NSArray*)createDataArray {
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    for (int i = 1; i <= 5; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"LaunchImage%d.jpg",i];
        [resultArray addObject:imageName];
    }
    
    return resultArray;
}

-(void)goMain {
    
    
    
        
        BaseTabBarViewController *tabaVC = [[BaseTabBarViewController alloc]init];
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        app.window.rootViewController = tabaVC;
  
    
    
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
