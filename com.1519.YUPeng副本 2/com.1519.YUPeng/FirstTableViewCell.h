//
//  FirstTableViewCell.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/2/25.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionProductsModel.h"

@interface FirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgStc;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

-(void)config:(PromotionProductsModel*)pmodel;
@end
