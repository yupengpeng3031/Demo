//
//  guoneiViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "guoneiViewController.h"

#import "HTTPEngine.h"

#import "Define.h"

#import "gtmodel.h"

#import "aentModel.h"

#import "brushmodel.h"

#import "undermodel.h"

#import "vacationmodel.h"

#import "touismodel.h"

#import "UIImageView+WebCache.h"

#import "guoneiTableViewCell.h"

#import "guoneioneCollectionViewCell.h"

#import "onetwoViewController.h"

#import "CacheManger.h"

#import "CycleScrollView.h"

#import "UMSocial.h"

#import <MessageUI/MessageUI.h>

@interface guoneiViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CycleScrollViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *adverArray;

@property (nonatomic,strong)NSMutableArray *adveraaArray;

@property (nonatomic,strong)NSMutableArray *monthArray;

@property (nonatomic,strong)NSMutableArray *brushArray;

@property (nonatomic,strong)NSMutableArray *underArray;

@property (nonatomic,strong)NSMutableArray *vacaArray;

@property (nonatomic,strong)NSMutableArray *tuArray;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *datasourceone;

@end

@implementation guoneiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [NSMutableArray new];
    
    _adverArray = [NSMutableArray new];
    
    _adveraaArray = [NSMutableArray new];
    
    _monthArray = [NSMutableArray new];
    
    _brushArray = [NSMutableArray new];
    
    _underArray = [NSMutableArray new];
    
    _vacaArray = [NSMutableArray new];
    
    _tuArray = [NSMutableArray new];
    
    _datasourceone = [NSMutableArray new];
    
    [self loadDataSource];
    
    
    
    
    
}

-(void)loadDataSource {
    
    HTTPEngine *engine = [HTTPEngine shareEngine];
    
    [engine GET:GUONEIAPI success:^(id response) {
        
        NSLog(@"%@",response);
        
        //把拿到的数据存入沙盒
        [CacheManger savedData:response withUrl:GUONEIAPI];
        
        //读取数据
        NSDictionary *responsee = [CacheManger readDataWithUrl:GUONEIAPI];
        
        
        NSDictionary *Response = responsee[@"Response"];
        
        NSArray *Advertisement = Response[@"Advertisement"];
        
        _adverArray = [aentModel arrayOfModelsFromDictionaries:Advertisement error:nil];
        
        NSArray *MonthRecommend = Response[@"MonthRecommend"];
        
        _monthArray = [brushmodel arrayOfModelsFromDictionaries:MonthRecommend error:nil];
        
        
        
        
        gtmodel *model = [gtmodel new];
        
        NSDictionary * BrushPresent = Response[@"BrushPresent"];
        
        model.ImgSrc = BrushPresent[@"ImgSrc"];
        
        model.Link = BrushPresent[@"Link"];
        
        model.Category = BrushPresent[@"Category"];
        
        model.CategoryValue = BrushPresent[@"Category"][@"CategoryValue"];
        
        [_brushArray addObject:model];
        
        NSDictionary *Underneathtisemen = Response[@"Underneathtisemen"];
        
        NSArray *ProductItem = Underneathtisemen[@"ProductItem"];
        
        _underArray = [undermodel arrayOfModelsFromDictionaries:ProductItem error:nil];
        
        NSDictionary *VacationList = Response[@"VacationList"];
        
        NSArray *ProductIteme = VacationList[@"ProductItem"];
        
        _vacaArray = [vacationmodel arrayOfModelsFromDictionaries:ProductIteme error:nil];
    
        NSDictionary *TourList = Response[@"TourList"];
        
        NSArray *ProductItemb = TourList[@"ProductItem"];
        
        _tuArray = [touismodel arrayOfModelsFromDictionaries:ProductItemb error:nil];
        
        [self createTableView];
        
    } failure:^(NSError *error) {
    }];
}



-(void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self createDatasourceone];
    
    CycleScrollView *scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    scrollView.delegate = self;
    
    for (int i = 0; i < _adverArray.count; i++) {
        
        aentModel *model = _adverArray[i];
        
        [_adveraaArray addObject:model.ImgSrc];
        
    }
    
    scrollView.urlArray = _adveraaArray;
    
    scrollView.autoScroll = YES;
    
    scrollView.autoTime = 2.5f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, self.view.frame.size.width-20, 50)];
    
    label.text = @"热推景点";
    
    label.textAlignment = NSTextAlignmentCenter;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(self.view.frame.size.width/3, 100);
    
    layout.minimumLineSpacing = 5;
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 250, self.view.frame.size.width-20, 100) collectionViewLayout:layout];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    _collectionView.pagingEnabled = YES;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self createDatasource];
    
    [_collectionView registerClass:[guoneioneCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 350)];
    
    [View addSubview:label];
    
    [View addSubview:_collectionView];
    
    [View addSubview:scrollView];
    
    _tableView.tableHeaderView = View;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
    
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   guoneioneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];

    brushonemodel *model = _dataSource[indexPath.row];
    
    
    [cell config:model];
    
    return cell;
}

-(void)createDatasource {
    
    for (brushmodel *model in _monthArray) {
        
        NSArray *ProductItemlist = model.ProductItemList;
        
            for (brushonemodel *mol in ProductItemlist) {
                
                brushonemodel *ol = [brushonemodel new];
                
                ol.BannerUrl = mol.BannerUrl;
                
                ol.BannerName = mol.BannerName;
                
                ol.SubTitle = mol.SubTitle;
                
                [_dataSource addObject:ol];
            }
    }
}

-(void)createDatasourceone {
    
    for (int i = 0; i < _vacaArray.count; i++) {

        [_datasourceone addObject:_vacaArray[i]];
    }
    for (int j = 0; j < _tuArray.count; j++) {
        
        [_datasourceone addObject:_tuArray[j]];
    }
}
//点击事件
-(void)clickImgAtIndex:(NSInteger)index {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    aentModel *model = _adverArray[index];
    
    vc.Link = model.Link;
    
    NSLog(@"%@",vc.Link);
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasourceone.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     guoneiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    
    if (!cell) {
        
        cell  = [[guoneiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellid"];
        
    }
    if (indexPath.row < 3) {
        
        vacationmodel *mo = _datasourceone[indexPath.row];
        
        cell.btn = [[UIButton alloc]initWithFrame:CGRectMake(280 ,70, 50, 30)];
        
        [cell.btn setTitle:@"分享" forState:UIControlStateNormal];
        
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [cell.btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [cell.btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];

        [cell addSubview:cell.btn];
        
        [cell config:mo];

    } else {
        touismodel *md = _datasourceone[indexPath.row];
        
        cell.btn = [[UIButton alloc]initWithFrame:CGRectMake(280 ,70, 50, 30)];
        
        [cell.btn setTitle:@"分享" forState:UIControlStateNormal];
        
        [cell.btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] ;
        
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [cell.btn addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:cell.btn];
        
        [cell confg:md];
    }
    
      return cell;
}

-(void)btn:(UIButton*)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56dbeb1e67e58edeb20011bd" shareText:@"UMShareToSms" shareImage:[UIImage imageNamed:@"AppIcon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToSms,UMShareToQQ,UMShareToRenren, nil] delegate:self];

    
}

-(void)btn1:(UIButton*)sender{
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56dbeb1e67e58edeb20011bd" shareText:@"UMShareToEmail," shareImage:[UIImage imageNamed:@"AppIcon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToSms,UMShareToQQ,UMShareToRenren, nil] delegate:self];
    
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
            
        case MFMailComposeResultCancelled:
            NSLog(@"邮件被取消");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"邮件被保存");
            break;
        case MFMailComposeResultSent:
            NSLog(@"邮件已发送");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"邮件发送失败");
            break;
        default:
            break;
    }
    //邮件界面要模态跳转返回
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    //result 发送短信的结果状态
    switch (result) {
            
        case MessageComposeResultCancelled:
            
            NSLog(@"短信被取消");
            
            break;
            
        case MessageComposeResultSent:
            
            NSLog(@"短信已发送");
            
            break;
            
        case MessageComposeResultFailed:
            
            NSLog(@"短信发送失败");
            
            break;
            
        default:
            
            break;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 105.0;
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