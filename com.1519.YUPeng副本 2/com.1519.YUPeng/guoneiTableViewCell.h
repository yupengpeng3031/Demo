//
//  guoneiTableViewCell.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "vacationmodel.h"

#import "touismodel.h"

@interface guoneiTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *imageview;

@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)UILabel *adressLabel;

@property (nonatomic,strong)UILabel *priceLabel;

@property (nonatomic,strong)UIButton *btn;

-(void)config:(vacationmodel*)model;

-(void)confg:(touismodel *)model;
@end
