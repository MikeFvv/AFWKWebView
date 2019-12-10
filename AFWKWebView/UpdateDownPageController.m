//
//  UpdateDownPageController.m
//  AFWKWebView
//
//  Created by lvan Lewis on 2019/12/10.
//  Copyright © 2019 AFan. All rights reserved.
//

#import "UpdateDownPageController.h"
#import "Masonry.h"
#import "UIImage+GIF.h"

@interface UpdateDownPageController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *contaierView;

@property (strong, nonatomic) UIImageView *bgImgView;


@end

@implementation UpdateDownPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setScrollView];
    [self createSubViews];
    [self setupUI2];
}


/// 更新app
- (void)updateApp {
    
}
/// 进入官网
- (void)goto_guanwang:(UIButton *)sender {
    
}

- (void)setupUI2 {
    
    UIImageView *zzBgImg = [[UIImageView alloc] init];
    zzBgImg.image = [UIImage imageNamed:@"palying"];
    [self.bgImgView addSubview:zzBgImg];
    
    [zzBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake([[UIScreen mainScreen] bounds].size.width, 503));
    }];
}



- (void)createSubViews {
    
    UIImageView *topImgView = [[UIImageView alloc] init];
    topImgView.image = [UIImage imageNamed:@"11x5"];
    [self.contentView addSubview:topImgView];
    
    [topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(@(40));
    }];
    
    UIButton *inBtn = [[UIButton alloc] init];
    [inBtn setTitle:@"进入官网" forState:UIControlStateNormal];
    [inBtn addTarget:self action:@selector(goto_guanwang:) forControlEvents:UIControlEventTouchUpInside];
    inBtn.backgroundColor = [UIColor redColor];
    inBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    inBtn.layer.cornerRadius = 5;
    inBtn.layer.masksToBounds = YES;
    inBtn.tag = 1000;
    [self.contentView addSubview:inBtn];
    
    [inBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topImgView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    
    UIImageView *bgImgView = [[UIImageView alloc] init];
    bgImgView.image = [UIImage imageNamed:@"bg"];
    [self.contentView addSubview:bgImgView];
    _bgImgView = bgImgView;
    
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImgView.mas_bottom).offset(1);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(531.5);
    }];
    
    UIImageView *ztopImgView = [[UIImageView alloc] init];
    ztopImgView.image = [UIImage imageNamed:@"advertising"];
    [self.contentView addSubview:ztopImgView];
    
    [ztopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImgView.mas_top);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(135.5);
    }];
    
    
    CGFloat widht = 51;
    
    UIView *imgBackView = [[UIView alloc] init];
    imgBackView.backgroundColor = [UIColor greenColor];
    [bgImgView addSubview:imgBackView];
    
    [imgBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ztopImgView.mas_bottom).offset(10);
        make.left.equalTo(bgImgView.mas_left).offset(20);
        make.right.equalTo(bgImgView.mas_right).offset(-20);
        make.height.mas_equalTo(widht);
    }];
    
    
    CGFloat spe = ([[UIScreen mainScreen] bounds].size.width - 20*2- widht*5)/4;
    
    NSArray *imgs = @[@"11x5",@"lh",@"k3",@"pk10",@"ssc"];
    for (NSInteger index = 0; index < 5; index++) {
        UIImageView *ztopImgView = [[UIImageView alloc] init];
        ztopImgView.frame = CGRectMake(index * (widht + spe), 0, widht, widht);
        ztopImgView.image = [UIImage imageNamed:imgs[index]];
        [imgBackView addSubview:ztopImgView];
    }
    
    
    UILabel *xzLabel = [[UILabel alloc] init];
    xzLabel.text = @"下载手机应用";
    xzLabel.font = [UIFont systemFontOfSize:14];
    xzLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:xzLabel];
    
    [xzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBackView.mas_bottom).offset(10);
        make.left.equalTo(imgBackView.mas_left);
    }];
    
    UILabel *dzxzLabel = [[UILabel alloc] init];
    dzxzLabel.text = @"点击下载 随时随地都能玩";
    dzxzLabel.font = [UIFont systemFontOfSize:15];
    dzxzLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:dzxzLabel];
    
    [dzxzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xzLabel.mas_bottom).offset(5);
        make.left.equalTo(imgBackView.mas_left);
    }];
    
    
    UIImageView *gradeImgView = [[UIImageView alloc] init];
    gradeImgView.image = [UIImage imageNamed:@"grade"];
    [bgImgView addSubview:gradeImgView];
    
    [gradeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dzxzLabel.mas_bottom).offset(20);
        make.left.equalTo(bgImgView.mas_left).offset(5);
        make.right.equalTo(bgImgView.mas_right).offset(-10);
        make.height.mas_equalTo(47);
    }];
    
    UIView *bgXZView = [[UIView alloc] init];
    bgXZView.layer.borderWidth = 1.5;
    bgXZView.layer.borderColor = [UIColor whiteColor].CGColor;
    bgXZView.backgroundColor = [UIColor greenColor];
    [bgImgView addSubview:bgXZView];
    
    [bgXZView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gradeImgView.mas_bottom).offset(12);
        make.left.equalTo(bgImgView.mas_left).offset(-1);
        make.right.equalTo(bgImgView.mas_right).offset(1);
        make.height.mas_equalTo(94);
    }];
    
    UIView *nbBgXZView = [[UIView alloc] init];
    nbBgXZView.backgroundColor = [UIColor redColor];
    [bgXZView addSubview:nbBgXZView];
    
    [nbBgXZView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgXZView.mas_centerX);
        make.centerY.equalTo(bgXZView.mas_centerY);
        make.left.equalTo(bgXZView.mas_left).offset(55);
        make.right.equalTo(bgXZView.mas_right).offset(-55);
        make.height.mas_equalTo(80);
    }];
    
    CGFloat widthh = 60;
    CGFloat spee = ([[UIScreen mainScreen] bounds].size.width - 55*2- widthh*3)/2;
    NSArray *imgss = @[@"register",@"promptly",@"share"];
    
    for (NSInteger index = 0; index < 3; index++) {
        UIImageView *zsImgView = [[UIImageView alloc] init];
        zsImgView.frame = CGRectMake(index * (widthh + spee), 0, widthh, 80);
        zsImgView.image = [UIImage imageNamed:imgss[index]];
        [nbBgXZView addSubview:zsImgView];
    }
    
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"update" ofType:@"gif"];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *uImage = [UIImage sd_imageWithGIFData:imageData];
    
    UIButton *updateBtn = [[UIButton alloc] init];
    [updateBtn setBackgroundImage:uImage forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(updateApp) forControlEvents:UIControlEventTouchUpInside];
    updateBtn.tag = 1001;
    [bgImgView addSubview:updateBtn];

    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgXZView.mas_bottom).offset(6);
        make.centerX.equalTo(bgImgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(287, 73));
    }];
    
    
}

- (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (UIView *)colorView:(UIColor *)color text:(NSString *)text {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    return view;
}


- (void)setScrollView {
    
    //    _scrollView = [[UIScrollView alloc]init];
    //    _scrollView.delegate = self;
    //    [self.view addSubview:_scrollView];
    //    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view);
    //    }];
    //
    //    _contaierView = [[UIView alloc]init];
    //    [_scrollView addSubview:_contaierView];
    //    [_contaierView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(_scrollView);
    //        make.width.equalTo(self.view);
    //    }];
    
    
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor cyanColor];
    //设置contentSize,默认是0,不支持滚动
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 1000);
    //设置contentOffset
    //_scrollView.contentOffset = CGPointMake(-50, -50);
    //contentInset(在原有的基础上更改滚动区域)
    //_scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    //锁定方向
    //    _scrollView.directionalLockEnabled = YES;
    
    //滚动的时候,超出内容视图边界,是否有反弹效果
    _scrollView.bounces = YES;
    //假如是yes并且bounces是yes,甚至如果内容大小小于bounds的时候，允许垂直拖动
    _scrollView.alwaysBounceVertical = YES;
    
    //分页
    //    _scrollView.pagingEnabled = YES;
    
    //设置滚动条的显示
    _scrollView.showsVerticalScrollIndicator = YES;
    
    //设置滚动条的滚动范围
    //    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 50, 0, 0);
    //滚动条样式
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    UIView *contentView = [[UIView alloc]init];
    [_scrollView addSubview:contentView];
    contentView.backgroundColor = [UIColor greenColor];
    _contentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.offset(self.view.bounds.size.width);
        make.height.equalTo(@1000);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", _scrollView);
}


@end

