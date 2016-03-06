//
//  abcTableViewCell.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "guoneiweonemodel.h"
@interface abcTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *pricelabel;

-(void)config:(guoneiweonemodel*)model;

@end
