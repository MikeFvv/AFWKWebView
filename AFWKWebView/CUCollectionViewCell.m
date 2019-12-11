//
//  CUCollectionViewCell.m
//  LCGCycleCollectionView
//
//  Created by 李传光 on 2019/4/17.
//  Copyright © 2019 李传光. All rights reserved.
//

#import "CUCollectionViewCell.h"

@implementation CUCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _imageView =  [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"pt1_1"];
        [self.contentView addSubview:_imageView];
    }
    return self ;
}

@end
