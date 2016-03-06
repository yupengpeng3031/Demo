//
//  zijiayouTableViewCell.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/4.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "zijiayouthreemodel.h"

@interface zijiayouTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imager;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *adresslabel;

-(void)config:(zijiayouthreemodel*)model;

@end
