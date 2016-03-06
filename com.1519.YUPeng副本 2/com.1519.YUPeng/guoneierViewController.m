//
//  guoneierViewController.m
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/2.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import "guoneierViewController.h"

#import "HTTPEngine.h"

#import "Define.h"

#import "guoniewemodel.h"

#import "guoneiweonemodel.h"

#import "cruisemodel.h"

#import "CycleScrollView.h"

#import "onetwoViewController.h"

#import "UIImageView+WebCache.h"

#import "abcCollectionViewCell.h"

#import "abcTableViewCell.h"

#import "CacheManger.h"

@interface guoneierViewController ()<UITableViewDataSource,UITableViewDelegate,CycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UICollectionView *collectiomview;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *adArray;

@property (nonatomic,strong)NSMutableArray *adaArray;

@property (nonatomic,strong)NSMutableArray *gaaArray;

@property (nonatomic,strong)NSMutableArray *cruArray;

@end

@implementation guoneierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _adArray = [NSMutableArray new];
    
    _adaArray = [NSMutableArray new];
    
    _gaaArray = [NSMutableArray new];
    
    _cruArray = [NSMutableArray new];
    
    [self loadDataSource];
    
    
}

//数据解析
-(void)loadDataSource {
    
    HTTPEngine *engine = [HTTPEngine shareEngine];
   
    [engine GET:YOULUNAPI success:^(id response) {
        
        
        //把拿到的数据存入沙盒
        [CacheManger savedData:response withUrl:YOULUNAPI];
        //读取数据
        NSDictionary *responsee = [CacheManger readDataWithUrl:YOULUNAPI];
        

        
        NSDictionary *Response = responsee[@"Response"];
        
        NSArray *Advertisements = Response[@"Advertisements"];
        
        _adArray = [guoniewemodel arrayOfModelsFromDictionaries:Advertisements error:nil];
        
        NSLog(@"%@",_adArray);
        
        NSDictionary *RecommandProducts = Response[@"RecommandProducts"];
        
        NSArray *ProductItem = RecommandProducts[@"ProductItem"];
        
        _gaaArray = [guoneiweonemodel arrayOfModelsFromDictionaries:ProductItem error:nil];
        
        NSLog(@"%@",_gaaArray);
        
        NSArray *CruiseCompanies = Response[@"CruiseCompanies"];
        
        _cruArray = [cruisemodel arrayOfModelsFromDictionaries:CruiseCompanies error:nil];
        
        [self createtableView];
        
        NSLog(@"%@",_cruArray);
        
    }failure:^(NSError *error) {
    
    }];

}
//创建tableview
-(void)createtableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"abcTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    self.tableView.estimatedRowHeight = 500.0;
    
    CycleScrollView *scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    scrollView.delegate = self;
    
    for (int i = 0; i < _adArray.count; i++) {
        
        guoniewemodel *model = _adArray[i];
        
        [_adaArray addObject:model.ImgSrc];
        
    }
    
    scrollView.urlArray = _adaArray;
    
    scrollView.autoScroll = YES;
    
    scrollView.autoTime = 2.5f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), self.view.frame.size.width, 50)];
    
    label.text = @"邮轮公司";
    
    label.textAlignment = NSTextAlignmentCenter;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(self.view.frame.size.width/3, 100);
    
    layout.minimumLineSpacing = 5;
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    _collectiomview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 250, self.view.frame.size.width-20, 100) collectionViewLayout:layout];
    
    _collectiomview.backgroundColor = [UIColor grayColor];
    
    _collectiomview.delegate = self;
    
    _collectiomview.dataSource = self;
    
    self.collectiomview.showsHorizontalScrollIndicator = NO;
    
    self.collectiomview.showsVerticalScrollIndicator = NO;
    
    _collectiomview.pagingEnabled = YES;

    [_collectiomview registerNib:[UINib nibWithNibName:@"abcCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 350)];
    
    [view addSubview:_collectiomview];
    
    [view addSubview:scrollView];
    
    [view addSubview:label];
    
    _tableView.tableHeaderView = view;
    
}

#pragma mark
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _cruArray.count;
    
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    abcCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    cruisemodel *model = _cruArray[indexPath.row];
    
    [cell config:model];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gaaArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    abcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    guoneiweonemodel *model = _gaaArray[indexPath.row];
    
    [cell config:model];
   
    return cell;
}
-(void)clickImgAtIndex:(NSInteger)index {
    
    onetwoViewController *vc = [[onetwoViewController alloc]init];
    
    guoniewemodel *model = _adArray[index];
    
    vc.Link = model.Link;
    
    NSLog(@"%@",_adaArray);
    
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
