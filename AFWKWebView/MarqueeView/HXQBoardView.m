//
//  HXQBoardView.m
//  AFWKWebView
//
//  Created by Tiny on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import "HXQBoardView.h"
#import "HXQMarqueeModel.h"
#import "UIImageView+WebCache.h"

@interface HXQBoardView ()

@property (nonatomic, strong) HXQMarqueeModel *model;

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *titleLb;

@end
@implementation HXQBoardView

-(instancetype)initWithFrame:(CGRect)frame Model:(HXQMarqueeModel *)model{
    if (self = [super initWithFrame:frame]) {
        self.model = model;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 103, 137.5)];
    [self addSubview:self.headImgView];
    self.headImgView.image = [UIImage imageNamed:self.model.userImg];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction)]];
}

-(void)itemClickAction{
    if (self.boardItemClick) {
        self.boardItemClick(self.model);
    }
}
@end
