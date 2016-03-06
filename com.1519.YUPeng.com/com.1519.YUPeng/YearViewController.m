//
//  YearViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "YearViewController.h"

#import "SDImageCache.h"

@interface YearViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArr;
}

@end

@implementation YearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的设置";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self dataInit];
    
    [self createTableView];
    
}

-(void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
}

-(void)dataInit {
    
    _dataArr = [[NSMutableArray alloc]init];
    
    NSArray *arr1 = @[@"推送设置",@"开启推送通知",@"开启关注通知",@"清楚缓存"];
    
    [_dataArr addObject:arr1];
    
    NSArray *Arr2 = @[@"推荐春秋旅游",@"官方推荐",@"官方微博"];
    
    [_dataArr addObject:Arr2];
    
    [_tableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section]count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1||indexPath.row == 2) {
            
            UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(200, 0, 100, 30)];
            
            [sw addTarget:self action:@selector(swClick:) forControlEvents:UIControlEventValueChanged];
            
            sw.tag = indexPath.row+1001;
            
            [cell.contentView addSubview:sw];
        }
        
    }
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    
    return cell;
}
//开关按钮
-(void)swClick:(UISwitch*)sw {
    
}

//获取所有缓存大小
-(CGFloat)getCacheSize {
    //缓存 有两类 sdwebimage 还有 每个界面保存的缓存
    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
    
    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    
    //获取文件中的所有的文件
    NSArray *arr = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:myPath error:nil];
    
    unsigned long long size = 0;
    
    for (NSString *fileName in arr) {
        
        NSString *filePath = [myPath stringByAppendingPathComponent:fileName];
        
        NSDictionary *dict = [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil];
        
        size += dict.fileSize;
    }
    
    CGFloat totalSize = (sdSize+size)/1024.0/1024.0;
    
    return totalSize;
}

//cell 选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        //第0分区
        NSString *sizeStr = [NSString stringWithFormat:@"%fM",[self getCacheSize]];
        
        if (indexPath.row == 3) {
            
            UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"清除缓存" message:sizeStr preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionsheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                //删除按钮
                //删除sd
                [[SDImageCache sharedImageCache]clearMemory];//清除内存缓存
                
                [[SDImageCache sharedImageCache]clearDisk];//磁盘
                
                //界面下载缓存
                NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
                //删除
                [[NSFileManager defaultManager]removeItemAtPath:myPath error:nil];
                
            }]];
            
            [actionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"取消");
                
            }]];
            
            [self presentViewController:actionsheet animated:YES completion:nil];

        }
    }else if (indexPath.section == 1){
        //1分区
        if (indexPath.row == 0) {
            //推荐
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://weibo.com/springtour"]];
        } else if (indexPath.row == 1) {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://weibo.com/springtour"]];
        }else {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://weibo.com/springtour"]];
        }
    }
}



//-(void)createTextfield {
//        
//    UITextField *fild = [[UITextField alloc]initWithFrame:CGRectMake(20, 210, self.view.frame.size.width-40, 50)];
//        
//    fild.backgroundColor = [UIColor redColor];
//    
//    fild.clipsToBounds = YES;
//    
//    fild.layer.cornerRadius = 10;
//    
//    fild.placeholder = @"手机号码/邮箱";
//    
//    UITextField *fild1 = [[UITextField alloc]initWithFrame:CGRectMake(20, 280, self.view.frame.size.width-40, 50)];
//    
//    fild1.backgroundColor = [UIColor redColor];
//    
//    fild1.clipsToBounds = YES;
//    
//    fild1.layer.cornerRadius = 10;
//
//    
//    fild1.placeholder = @"密码(8 ~ 16个字符)";
//    
//    fild1.secureTextEntry = YES;
//    
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    button.frame = CGRectMake(20, 380, self.view.frame.size.width-40, 50);
//    
//    button.backgroundColor = [UIColor grayColor];
//    
//    [button setTitle:@"登陆" forState:UIControlStateNormal];
//    
//    button.clipsToBounds = YES;
//    
//    button.layer.cornerRadius = 10;
//    
//    button.titleLabel.font = [UIFont systemFontOfSize:20];
//
//    [self.view addSubview:button];
//    
//    [self.view addSubview:fild];
//    
//    [self.view addSubview:fild1];
//    
//    
//}
//
//
//
//-(void)customNavigationItem {
//    
//    //找到navigationitem
//    UINavigationItem *item = self.navigationItem;
//    
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(btn:)];
//    
//    item.rightBarButtonItem = btn;
//    
//}
//
//-(void)btn:(UIButton*)button {
//
//    
//}

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
