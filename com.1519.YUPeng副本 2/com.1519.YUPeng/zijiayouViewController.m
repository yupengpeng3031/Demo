//
//  zijiayouViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/4.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "zijiayouViewController.h"

#import "Define.h"

#import "HTTPEngine.h"

#import "zijiayoumodel.h"

#import "zjyghmodel.h"

#import "zijiayouthreemodel.h"

#import "CycleScrollView.h"

#import "zijiayouTableViewCell.h"

#import "onetwoViewController.h"

#import "CacheManger.h"

@interface zijiayouViewController ()<UITableViewDataSource,UITableViewDelegate,CycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *zijiaArray;

@property (nonatomic,strong)NSMutableArray *zijiaaArray;

@property (nonatomic,strong)NSMutableArray *adreesArray;

@property (nonatomic,strong)NSMutableArray *threeArray;

@end

@implementation zijiayouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [NSMutableArray new];
    
    _zijiaArray = [NSMutableArray new];
    
    _zijiaaArray = [NSMutableArray new];
    
    _adreesArray = [NSMutableArray new];
    
    _threeArray = [NSMutableArray new];
    
    [self loadDatasource];
}

-(void)loadDatasource {
    
    HTTPEngine *engine = [HTTPEngine shareEngine];
    
    [engine GET:ZIJIAYOUAPI success:^(id response) {
        
        //把拿到的数据存入沙盒
        [CacheManger savedData:response withUrl:ZIJIAYOUAPI];
        //读取数据
        NSDictionary *responsee = [CacheManger readDataWithUrl:ZIJIAYOUAPI];
        
        NSDictionary *Response = responsee[@"Response"];
        
        NSArray *AdvertisementList = Response[@"AdvertisementList"];
        
        _zijiaArray = [zijiayoumodel arrayOfModelsFromDictionaries:AdvertisementList error:nil];
        
        NSArray *HotKeywordList = Response[@"HotKeywordList"];
        
        _adreesArray = [zjyghmodel arrayOfModelsFromDictionaries:HotKeywordList error:nil];
        
        NSDictionary *RecommendList = Response[@"RecommendList"];
        
        NSArray *ProductItem = RecommendList[@"ProductItem"];
        
        _threeArray = [zijiayouthreemodel arrayOfModelsFromDictionaries:ProductItem error:nil];
        
        [self createtableView];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)createtableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"zijiayouTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    self.tableView.estimatedRowHeight = 500.0;
    
    CycleScrollView *scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    scrollView.delegate = self;
    
    for (int i = 0; i < _zijiaArray.count; i++) {
        
        zijiayoumodel *model = _zijiaArray[i];
        
        [_zijiaaArray addObject:model.ImgSrc];
        
    }
    
    scrollView.urlArray = _zijiaaArray;
    
    scrollView.autoScroll = YES;
    
    scrollView.autoTime = 2.5f;
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    
    
    [view addSubview:scrollView];
    
    
    
    _tableView.tableHeaderView = view;
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _threeArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zijiayouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    zijiayouthreemodel *model = _threeArray[indexPath.row];
    
    [cell config:model];
    
    return cell;
}

-(void)clickImgAtIndex:(NSInteger)index {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    zijiayoumodel *model = _zijiaArray[index];
    
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
