//
//  menpiaoViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/4.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "menpiaoViewController.h"

#import "Define.h"

#import "HTTPEngine.h"

#import "menpiaomodel.h"

#import "menpiaotopmodel.h"

#import "menpiaodommodel.h"

#import "overmodel.h"

#import "menpiaopromodel.h"

#import "CycleScrollView.h"

#import "onetwoViewController.h"

#import "menpiaoTableViewCell.h"

#import "UIImageView+WebCache.h"

#import "CacheManger.h"

@interface menpiaoViewController ()<UITableViewDataSource,UITableViewDelegate,CycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *mpArray;

@property (nonatomic,strong)NSMutableArray *mpppppArray;

@property (nonatomic,strong)NSMutableArray *mptopArray;

@property (nonatomic,strong)NSMutableArray *mpdomArray;

@property (nonatomic,strong)NSMutableArray *overArray;

@property (nonatomic,strong)NSMutableArray *mpppArray;

@end

@implementation menpiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [NSMutableArray new];
    
    _mpArray = [NSMutableArray new];
    
    _mpppppArray = [NSMutableArray new];
    
    _mptopArray = [NSMutableArray new];
    
    _mpdomArray = [NSMutableArray new];
    
    _overArray = [NSMutableArray new];
    
    _mpppArray = [NSMutableArray new];
    
    [self loaddataSource];
}

-(void)loaddataSource {
    
    HTTPEngine *engine = [HTTPEngine shareEngine];
    
    [engine GET:MENPIAOAPI success:^(id response) {
        
        //把拿到的数据存入沙盒
        [CacheManger savedData:response withUrl:MENPIAOAPI];
        //读取数据
        NSDictionary *responsee = [CacheManger readDataWithUrl:MENPIAOAPI];
        

        
        NSDictionary *Response = responsee[@"Response"];
        
        NSArray *Banners = Response[@"Banners"];
        
        _mpArray = [menpiaomodel arrayOfModelsFromDictionaries:Banners error:nil];
        
        NSArray *TopicBanners = Response[@"TopicBanners"];
        
        _mptopArray = [menpiaotopmodel arrayOfModelsFromDictionaries:TopicBanners error:nil];
        
        NSArray *DomesticBanners = Response[@"DomesticBanners"];
        
        _mpdomArray = [menpiaodommodel arrayOfModelsFromDictionaries:DomesticBanners error:nil];
        
        NSArray *OverseasBanners = Response[@"OverseasBanners"];
        
        _overArray = [overmodel arrayOfModelsFromDictionaries:OverseasBanners error:nil];
        
        NSArray *PromotionProducts = Response[@"PromotionProducts"];
        
        _mpppArray = [menpiaopromodel arrayOfModelsFromDictionaries:PromotionProducts error:nil];
        
        [self createtableView];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)createtableView {

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"menpiaoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    self.tableView.estimatedRowHeight = 500.0;
    
    CycleScrollView *scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    scrollView.delegate = self;
    
    for (int i = 0; i < _mpArray.count; i++) {
        
        menpiaomodel *model = _mpArray[i];
        
        [_mpppppArray addObject:model.ImgSrc];
        
    }
    
    scrollView.urlArray = _mpppppArray;
    
    scrollView.autoScroll = YES;
    
    scrollView.autoTime = 2.5f;
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 10)];
    
    view1.backgroundColor = [UIColor grayColor];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 210, self.view.frame.size.width, 100)];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 100, 80)];
    
    menpiaotopmodel *model = _mptopArray[0];
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.ImgSrc]];
    
    imageview.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [imageview addGestureRecognizer:tap];

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(155, 20, 100, 30)];
    
    label.text = model.BannerName;
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(155, 55, 200, 30)];
    
    label2.text = model.BannerSubName;
    
    label2.font = [UIFont systemFontOfSize:14];
    
    [view2 addSubview:imageview];
    
    [view2 addSubview:label];
    
    [view2 addSubview:label2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 310, self.view.frame.size.width/2, 100)];
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    
    menpiaotopmodel *model1 = _mptopArray[1];
    
    [imageview1 sd_setImageWithURL:[NSURL URLWithString:model1.ImgSrc]];
    
    imageview1.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
    
    tap1.numberOfTapsRequired = 1;
    
    tap1.numberOfTouchesRequired = 1;
    
    [imageview1 addGestureRecognizer:tap1];

    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(95, 20, 80, 30)];
    
    label3.text = model1.BannerName;
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(95, 55, 80, 30)];
    
    label4.text = model1.BannerSubName;
    
    label4.font = [UIFont systemFontOfSize:14];
    
    [view3 addSubview:imageview1];
    
    [view3 addSubview:label3];
    
    [view3 addSubview:label4];

    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 310, self.view.frame.size.width/2, 100)];
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    
    menpiaotopmodel *model2 = _mptopArray[2];
    
    [imageview2 sd_setImageWithURL:[NSURL URLWithString:model2.ImgSrc]];
    
    imageview2.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
    
    tap2.numberOfTapsRequired = 1;
    
    tap2.numberOfTouchesRequired = 1;
    
    [imageview2 addGestureRecognizer:tap2];

    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(95, 20, 100, 30)];
    
    label5.text = model2.BannerName;
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(95, 55, 80, 30)];
    
    label6.text = model2.BannerSubName;
    
    label6.font = [UIFont systemFontOfSize:14];
    
    [view4 addSubview:imageview2];
    
    [view4 addSubview:label5];
    
    [view4 addSubview:label6];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 410)];
    
    [view addSubview:scrollView];
    
    [view addSubview:view1];
    
    [view addSubview:view2];
    
    [view addSubview:view3];
    
    [view addSubview:view4];
    
    
    
    _tableView.tableHeaderView = view;
    


}
//点击事件
-(void)tap:(UITapGestureRecognizer*)tap {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    menpiaotopmodel *model = _mptopArray[0];
    
    vc.Link = model.Link;
    
    [self.navigationController pushViewController:vc animated:YES];
}
//点击事件
-(void)tap1:(UITapGestureRecognizer*)tap {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    menpiaotopmodel *model = _mptopArray[1];
    
    vc.Link = model.Link;
    
    [self.navigationController pushViewController:vc animated:YES];
}
//点击事件
-(void)tap2:(UITapGestureRecognizer*)tap {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    menpiaotopmodel *model = _mptopArray[2];
    
    vc.Link = model.Link;

    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _mpppArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     menpiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    menpiaopromodel *model = _mpppArray[indexPath.row];
    
    [cell config:model];
    
    return cell;
}

-(void)clickImgAtIndex:(NSInteger)index {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    menpiaomodel *model = _mpArray[index];
    
    vc.Link = model.Link;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
