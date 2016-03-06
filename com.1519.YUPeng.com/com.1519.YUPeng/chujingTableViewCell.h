//
//  chujingTableViewCell.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "bigsemodel.h"

#import "couplemodel.h"

@interface chujingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *adresslabel;

@property (weak, nonatomic) IBOutlet UILabel *pricelabel;

-(void)config:(bigsemodel*)model;

-(void)confg:(couplemodel*)mol;

@end
