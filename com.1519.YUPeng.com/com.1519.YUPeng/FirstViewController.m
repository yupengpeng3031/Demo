//
//  FirstViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "FirstViewController.h"

#import "FirstTableViewCell.h"

#import "FirstOneModel.h"

#import "HTTPEngine.h"

#import "BannersModel.h"

#import "TopicBannersModel.h"

#import "PromotionProductsModel.h"

#import "VacationProductsModel.h"

#import "TourProductsModel.h"

#import "UIImageView+WebCache.h"

#import "UIButton+WebCache.h"

#import "onetwoViewController.h"

#import "FirstCategoryValueModel.h"

#import "FirestCategoryModel.h"

#import "guoneiViewController.h"

#import "guoneierViewController.h"

#import "chujingViewController.h"

#import "zijiayouViewController.h"

#import "menpiaoViewController.h"

#import "CycleScrollView.h"

#import "CacheManger.h"


@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,CycleScrollViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, strong)NSMutableArray *imageNameArray;

@property (nonatomic, strong)NSMutableArray *imageNameeArray;

@property (nonatomic, strong)NSMutableArray *firestArray;

@property (nonatomic,strong)NSMutableArray *TopArry;

@property (nonatomic,strong)NSMutableArray *vacaArray;

@property (nonatomic,strong)NSMutableArray *tourArray;

@property (nonatomic,strong)NSMutableArray *arr;

@property (nonatomic,strong)NSMutableArray *arr2;

@property (nonatomic)int page;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"春秋旅游";
    
    _dataSource = [NSMutableArray new];
    
    _imageNameArray = [NSMutableArray new];
    
    _imageNameeArray = [NSMutableArray new];
    
    _TopArry = [NSMutableArray new];
    
    _vacaArray = [NSMutableArray new];
    
    _tourArray = [NSMutableArray new];
    
    _arr = [NSMutableArray new];
    
    _firestArray = [NSMutableArray new];
    
    _arr2 = [NSMutableArray new];
    
    
    [self loadDataSource];
    
}
-(void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"FirstTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
    
    self.tableView.estimatedRowHeight = 400.0;
    
    CycleScrollView *scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    scrollView.delegate = self;
    
    for (int i = 0; i < _imageNameArray.count; i++) {
        
        BannersModel *model = _imageNameArray[i];
        
        [_imageNameeArray addObject:model.ImgSrc];
        
    }
    
    scrollView.urlArray = _imageNameeArray;
    
    scrollView.autoScroll = YES;
    
    scrollView.autoTime = 2.5f;
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn3.frame = CGRectMake(5, CGRectGetMaxY(scrollView.frame)+5, (self.view.frame.size.width-10)/2, (self.view.frame.size.width-10)/4-5);
    
    btn3.backgroundColor = [UIColor blueColor];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(btn3.frame.size.width-128, btn3.frame.size.height-60, 100, 50)];
    
    label3.text = @"自驾游";
    
    label3.textColor = [UIColor whiteColor];
    
    [btn3 addSubview:label3];
    
    UIImage *image3 = [UIImage imageNamed:@"home_aroud"];
    
    UIImageView *imageview3 = [[UIImageView alloc]initWithImage:image3];
    
    imageview3.frame = CGRectMake(btn3.frame.size.width/2-15, 20, 30, 30);
    
    [btn3 addSubview:imageview3];

    [btn3 addTarget:self action:@selector(btn3Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn4.frame = CGRectMake(CGRectGetMaxX(btn3.frame)+5, CGRectGetMaxY(scrollView.frame)+5, (self.view.frame.size.width-10)/2-5, (self.view.frame.size.width-10)/4-5);
    
    btn4.backgroundColor = [UIColor blueColor];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(btn4.frame.size.width-114, btn4.frame.size.height-60, 100, 50)];
    
    label4.text = @"门票";
    
    label4.textColor = [UIColor whiteColor];
    
    [btn4 addSubview:label4];
    
    UIImage *image4 = [UIImage imageNamed:@"daban_jianjie"];
    
    UIImageView *imageview4 = [[UIImageView alloc]initWithImage:image4];
    
    imageview4.frame = CGRectMake(btn4.frame.size.width/2-15, 20, 30, 30);
    
    [btn4 addSubview:imageview4];

    [btn4 addTarget:self action:@selector(btn4Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn6.frame = CGRectMake(5,CGRectGetMaxY(btn3.frame)+5,self.view.frame.size.width-10, (self.view.frame.size.width-10)/4);
    btn6.backgroundColor = [UIColor grayColor];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(10, btn6.frame.size.height-100, 150, 100)];
    
    label6.text = @"出境\n299元起玩转境外";
    
    label6.textColor = [UIColor whiteColor];
    
    label6.numberOfLines = 2;
    
    [btn6 addSubview:label6];
    
    UIImage *image6 = [UIImage imageNamed:@"daban_main_dtpzc"];
    
    UIImageView *imageview6 = [[UIImageView alloc]initWithImage:image6];
    
    imageview6.frame = CGRectMake(btn6.frame.size.width/2+35, 25, 40, 40);
    
    [btn6 addSubview:imageview6];
    
    [btn6 addTarget:self action:@selector(btn6Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn7.frame = CGRectMake(5,CGRectGetMaxY(btn6.frame)+5, (self.view.frame.size.width-10)/2, (self.view.frame.size.width-10)/4);
    
    btn7.backgroundColor = [UIColor greenColor];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(10, btn7.frame.size.height-100, 120, 100)];
    
    label7.text = @"国内\n周末拼假都方便";
    
    label7.textColor = [UIColor whiteColor];
    
    label7.numberOfLines = 2;
    
    [btn7 addSubview:label7];
    
    UIImage *image7 = [UIImage imageNamed:@"daban_zyjd"];
    
    UIImageView *imageview7 = [[UIImageView alloc]initWithImage:image7];
    
    imageview7.frame = CGRectMake(btn7.frame.size.width/2+30, 25, 40, 40);
    
    [btn7 addSubview:imageview7];
    
    [btn7 addTarget:self action:@selector(btn7Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn8.frame = CGRectMake(CGRectGetMaxX(btn7.frame)+5,CGRectGetMaxY(btn6.frame)+5, (self.view.frame.size.width-10)/2, (self.view.frame.size.width-10)/4);
    
    btn8.backgroundColor = [UIColor yellowColor];
    
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(10, btn8.frame.size.height-100, 120, 100)];
    
    label8.text = @"邮轮\n和你一起去吹风";
    
    label8.textColor = [UIColor whiteColor];
    
    label8.numberOfLines = 2;
    
    [btn8 addSubview:label8];
    
    UIImage *image8 = [UIImage imageNamed:@"home_cruise"];
    
    UIImageView *imageview8 = [[UIImageView alloc]initWithImage:image8];
    
    imageview8.frame = CGRectMake(btn8.frame.size.width/2+30, 25, 40, 40);
    
    [btn8 addSubview:imageview8];
    
    [btn8 addTarget:self action:@selector(btn8Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i = 0; i < _TopArry.count; i++) {
        
        TopicBannersModel *tmodel = [_TopArry objectAtIndex:i];
        
        NSString *str = tmodel.ImgSrc;
        
        [_arr addObject:str];
    }
    
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn9.frame = CGRectMake(5,CGRectGetMaxY(btn7.frame)+5, (self.view.frame.size.width-20)/3, (self.view.frame.size.width-20)/3);
    
    btn9.backgroundColor = [UIColor grayColor];
    
    [btn9 addTarget:self action:@selector(btn9Pressed:) forControlEvents:UIControlEventTouchUpInside];

    [btn9 sd_setBackgroundImageWithURL:[NSURL URLWithString:_arr[0]] forState:UIControlStateNormal];

    UIButton *btn10 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn10.frame = CGRectMake(10+(self.view.frame.size.width-20)/3, CGRectGetMaxY(btn7.frame)+5, (self.view.frame.size.width-20)/3, (self.view.frame.size.width-20)/3);
    [btn10 addTarget:self action:@selector(btn10Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn10 sd_setBackgroundImageWithURL:[NSURL URLWithString:_arr[1]] forState:UIControlStateNormal];
    
    UIButton *btn11 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn11.frame = CGRectMake(10+(self.view.frame.size.width-20)/3*2+5, CGRectGetMaxY(btn7.frame)+5, (self.view.frame.size.width-20)/3, (self.view.frame.size.width-20)/3);
    
    [btn11 addTarget:self action:@selector(btn11Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn11 sd_setBackgroundImageWithURL:[NSURL URLWithString:_arr[2]] forState:UIControlStateNormal];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,CGRectGetMaxY(btn9.frame)+5)];
    
    
    
    [bgview addSubview:scrollView];
    
    [bgview addSubview:btn3];
    
    [bgview addSubview:btn4];
    
    [bgview addSubview:btn6];
    
    [bgview addSubview:btn7];
    
    [bgview addSubview:btn8];
    
    [bgview addSubview:btn9];
    
    [bgview addSubview:btn10];
    
    [bgview addSubview:btn11];
    
    _tableView.tableHeaderView = bgview;
    
}

-(void)clickImgAtIndex:(NSInteger)index {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    FirstCategoryValueModel *model = _firestArray[index];
    
    vc.Link = model.Link;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)btn3Pressed:(UIButton*)sender {
    
    zijiayouViewController *xc = [[zijiayouViewController alloc]init];
    
    xc.navigationItem.title = @"自驾游";
    
    [self.navigationController pushViewController:xc animated:YES];

                                
}
-(void)btn4Pressed:(UIButton*)sender {
    
    menpiaoViewController *cv = [[menpiaoViewController alloc]init];
    
    cv.navigationItem.title = @"门票";
    
    [self.navigationController pushViewController:cv animated:YES];

                                
}
-(void)btn6Pressed:(UIButton*)sender {
    
    chujingViewController *cv = [[chujingViewController alloc]init];
    
    cv.navigationItem.title = @"出境";
    
    [self.navigationController pushViewController:cv animated:YES];

}
-(void)btn7Pressed:(UIButton*)sender {
    
    guoneiViewController *gv = [[guoneiViewController alloc]init];
    
    gv.navigationItem.title = @"国内游";
    
    [self.navigationController pushViewController:gv animated:YES];
    
    
}
-(void)btn8Pressed:(UIButton*)sender {
    
    guoneierViewController *vc = [[guoneierViewController alloc]init];
    
    vc.navigationItem.title = @"邮轮游";

    [self.navigationController pushViewController:vc animated:YES];
    
                                
}
-(void)btn9Pressed:(UIButton*)sender {
    
    TopicBannersModel *mol = _TopArry[0];
    
    onetwoViewController *vc = [onetwoViewController new];
    NSString *title = mol.BannerSubName;
    
    NSString *ss = [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *net = [mol.Link stringByReplacingOccurrencesOfString:mol.BannerSubName withString:ss];
    
    vc.Link = net;
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)btn10Pressed:(UIButton*)sender {
    
    TopicBannersModel *mol = _TopArry[1];
    
    onetwoViewController *vc = [onetwoViewController new];
        vc.Link = mol.Link;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)btn11Pressed:(UIButton*)sender {
    
    TopicBannersModel *mol = _TopArry[2];
    
    onetwoViewController *vc = [onetwoViewController new];
    
    vc.Link = mol.Link;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSString*)urlStr {
    //[self initData];
    return [NSString stringWithFormat:SHOUYEAPI];
}
-(void)loadDataSource {
    
    NSString *urlStr = [self urlStr];
    
    HTTPEngine *engine = [HTTPEngine shareEngine];
    
    [engine GET:urlStr success:^(id response) {
        
        
        //把拿到的数据存入沙盒
        [CacheManger savedData:response withUrl:urlStr];
        //读取数据
        NSDictionary *responsee = [CacheManger readDataWithUrl:[self urlStr]];
        
        NSDictionary *Response = responsee[@"Response"];
       // NSLog(@"%@",Response);
        NSArray *Banners = Response[@"Banners"];
        
        for (NSDictionary *dic in Banners) {
            
            BannersModel *bmodel = [[BannersModel alloc]init];
            
            FirestCategoryModel *del = [FirestCategoryModel new];
            
            FirstCategoryValueModel *el = [FirstCategoryValueModel new];
            
            bmodel.ImgSrc = dic[@"ImgSrc"];
            
            bmodel.Link = dic[@"Link"];
            
            bmodel.BannerName = dic[@"BannerName"];
            
            bmodel.BannerSubName = dic[@"BannerSubName"];
            
             NSDictionary *Category = dic[@"Category"];
            
            del.CategoryKey = Category[@"CategoryKey"];
            
            NSDictionary *CategoryValue = Category[@"CategoryValue"];
            
            el.Link = CategoryValue[@"Link"];
            
            [_firestArray addObject:el];
            
            [_imageNameArray addObject:bmodel];
            
        }
        
        NSArray *TopicBanners = Response[@"TopicBanners"];
        
        for (NSDictionary *dic1 in TopicBanners) {
            
            TopicBannersModel *tmodel = [[TopicBannersModel alloc]init];
            
            tmodel.ImgSrc = dic1[@"ImgSrc"];
            
            tmodel.Link = dic1[@"Link"];
            
            tmodel.BannerName = dic1[@"BannerName"];
            
            tmodel.BannerSubName = dic1[@"BannerSubName"];
            
            NSDictionary *Category = dic1[@"Category"];
            
            tmodel.Category.CategoryKey = Category[@"CategoryKey"];
            
            NSDictionary *CategoryValue = Category[@"CategoryValue"];
            
            tmodel.Category.CategoryValue.SearchKeyword = CategoryValue[@"SearchKeyword"];
            
            [_TopArry addObject:tmodel];
           
        }
        NSArray *PromotionProducts = Response[@"PromotionProducts"];
        
        for (NSDictionary *dic2 in PromotionProducts) {
            
            PromotionProductsModel *pmodel = [[PromotionProductsModel alloc]init];
            
            pmodel.ProductName = dic2[@"ProductName"];
            
            pmodel.ProductId = dic2[@"ProductId"];
            
            pmodel.Price = dic2[@"Price"];
            
            pmodel.SystemType = dic2[@"SystemType"];
            
            pmodel.ImgSrc = dic2[@"ImgSrc"];
            
            pmodel.ProductTypeName = dic2[@"ProductTypeName"];
            
            pmodel.ProductTypeId = dic2[@"ProductTypeId"];
            
            pmodel.Title = dic2[@"Title"];
            
            pmodel.Destination = dic2[@"Destination"];
            
            pmodel.DiscountType = dic2[@"DiscountType"];
            
            pmodel.LabelType = dic2[@"LabelType"];
            
            [_dataSource addObject:pmodel];
        }
        NSArray *VacationProducts = Response[@"VacationProducts"];
    
        for (NSDictionary *dic3 in VacationProducts) {
            
            VacationProductsModel *vmodel = [[VacationProductsModel alloc]init];
            
            vmodel.ProductName = dic3[@"ProductName"];
            
            vmodel.ProductId = dic3[@"ProductId"];
            
            vmodel.Price = dic3[@"Price"];
            
            vmodel.SystemType = dic3[@"SystemType"];
            
            vmodel.ImgSrc = dic3[@"ImgSrc"];
            
            vmodel.ProductTypeName = dic3[@"ProductTypeName"];
            
            vmodel.ProductTypeId = dic3[@"ProductTypeId"];
            
            vmodel.Title = dic3[@"Title"];
            
            vmodel.Destination = dic3[@"Destination"];
            
            vmodel.DiscountType = dic3[@"DiscountType"];
            
            vmodel.LabelType = dic3[@"LabelType"];
            
            [_vacaArray addObject:vmodel];
        }
        NSArray *TourProducts = Response[@"TourProducts"];
        
        for (NSDictionary *dic4 in TourProducts) {
            
            TourProductsModel *tomodel = [[TourProductsModel alloc]init];
            
            tomodel.ProductName = dic4[@"ProductName"];
            
            tomodel.ProductId = dic4[@"ProductId"];
            
            tomodel.Price = dic4[@"Price"];
            
            tomodel.SystemType = dic4[@"SystemType"];
            
            tomodel.ImgSrc = dic4[@"ImgSrc"];
            
            tomodel.ProductTypeName = dic4[@"ProductTypeName"];
            
            tomodel.ProductTypeId = dic4[@"ProductTypeId"];
            
            tomodel.Title = dic4[@"Title"];
            
            tomodel.Destination = dic4[@"Destination"];
            
            tomodel.DiscountType = dic4[@"DiscountType"];
            
            tomodel.LabelType = dic4[@"LabelType"];
            
            [_tourArray addObject:tomodel];
        }
        [self createTableView];
        
    } failure:^(NSError *error) {
        
        NSLog(@"请求数据失败");
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    PromotionProductsModel *pmodel = _dataSource[indexPath.row];
    
    [cell config:pmodel];
    
    return cell;
}

-(void)btn:(UIButton*)sender {
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56dbeb1e67e58edeb20011bd" shareText:@"UMShareToSms" shareImage:[UIImage imageNamed:@"AppIcon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToSms,UMShareToQQ,UMShareToRenren, nil] delegate:self];

}
//触法点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
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
