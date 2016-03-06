//
//  abcCollectionViewCell.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "cruisemodel.h"
@interface abcCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

-(void)config:(cruisemodel*)model;

@end
