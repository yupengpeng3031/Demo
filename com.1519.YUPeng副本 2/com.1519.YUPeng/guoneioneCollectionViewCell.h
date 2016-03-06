//
//  guoneioneCollectionViewCell.h
//  com.1519.YUPeng
//
//  Created by qianfeng on 16/3/2.
//  Copyright © 2016年 yupengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "brushonemodel.h"
@interface guoneioneCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *label;
-(void)config:(brushonemodel*)str;
@end
