//
//  chujingViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "chujingViewController.h"

#import "Define.h"

#import "HTTPEngine.h"

#import "chujingmodel.h"

#import "keybordmodel.h"

#import "bigsemodel.h"

#import "couplemodel.h"

#import "CycleScrollView.h"

#import "onetwoViewController.h"

#import "chujingTableViewCell.h"

#import "CacheManger.h"

@interface chujingViewController ()<UITableViewDataSource,UITableViewDelegate,CycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *cjArray;

@property (nonatomic,strong)NSMutableArray *cjdArray;

@property (nonatomic,strong)NSMutableArray *kbArray;

@property (nonatomic,strong)NSMutableArray *bigArray;

@property (nonatomic,strong)NSMutableArray *couArray;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation chujingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cjArray = [NSMutableArray new];
    
    _cjdArray = [NSMutableArray new];
    
    _kbArray = [NSMutableArray new];
    
    _bigArray = [NSMutableArray new];
    
    _couArray = [NSMutableArray new];
    
    _dataArray = [NSMutableArray new];
    
    
    
    [self loadDataSource];
}

-(void)loadDataSource {
    
    HTTPEngine *engine = [HTTPEngine shareEngine];
    
    [engine GET:CHUJINGIAPI success:^(id response) {
        
        //把拿到的数据存入沙盒
        [CacheManger savedData:response withUrl:CHUJINGIAPI];
        //读取数据
        NSDictionary *responsee = [CacheManger readDataWithUrl:CHUJINGIAPI];
        
        NSDictionary *Response = responsee[@"Response"];
        
        NSArray *Advertisement = Response[@"Advertisement"];
        
        _cjArray = [chujingmodel arrayOfModelsFromDictionaries:Advertisement error:nil];
        
        NSArray *KeyWord = Response[@"KeyWord"];
        
        _kbArray = [keybordmodel arrayOfModelsFromDictionaries:KeyWord error:nil];
        
        NSDictionary *BigSeller = Response[@"BigSeller"];
        
        NSArray *ProductItem = BigSeller[@"ProductItem"];
        
        _bigArray = [bigsemodel arrayOfModelsFromDictionaries:ProductItem error:nil];
        
        NSDictionary *Couple = Response[@"Couple"];
        
        NSArray *Productitem = Couple[@"ProductItem"];
        
        _couArray = [couplemodel arrayOfModelsFromDictionaries:Productitem error:nil];
        
        [self createTableView];
        
        [self createDatasourceone];
        
    } failure:^(NSError *error) {
        
        
        
    }];
}

-(void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"chujingTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    self.tableView.estimatedRowHeight = 500.0;
    
    CycleScrollView *scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    scrollView.delegate = self;
    
    for (int i = 0; i < _cjArray.count; i++) {
        
        chujingmodel *model = _cjArray[i];
        
        [_cjdArray addObject:model.ImgSrc];
        
    }
    
    scrollView.urlArray = _cjdArray;
    
    scrollView.autoScroll = YES;
    
    scrollView.autoTime = 2.5f;

   
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    
    
    [view addSubview:scrollView];
    
    
    
    _tableView.tableHeaderView = view;

}

-(void)createDatasourceone {
    
    for (int i = 0; i < _bigArray.count; i++) {
        
        [_dataArray addObject: _bigArray[i]];
    }
    for (int j = 0; j < _couArray.count; j++) {
        
        [_dataArray addObject:_couArray[j]];
    }
    
}

#pragma mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    chujingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (indexPath.row < 5) {
        bigsemodel *mo = _dataArray[indexPath.row];
        
        [cell config:mo];
        
    } else {
        couplemodel *md = _dataArray[indexPath.row];
        
        [cell confg:md];
    }

    
    
    
    return cell;
}

-(void)clickImgAtIndex:(NSInteger)index {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    chujingmodel *model = _cjArray[index];
    
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
