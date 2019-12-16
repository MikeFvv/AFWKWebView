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
#import "UIImageView+WebCache.h"
#import "AFWKWebViewController.h"

#import "HXQMarqueeModel.h"
#import "HXQMarqueeView.h"
#import "UIView+Extionsiton.h"
#import "BANetManager_OC.h"


@interface UpdateDownPageController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *contaierView;


@property (strong, nonatomic) UIImageView *bgImgView;
@property (strong, nonatomic) UIImageView *wfBgImg;

@property (strong, nonatomic) UIImageView *topIconImgView;
@property (strong, nonatomic) UIImageView *iconImg;

@property (strong, nonatomic) NSArray *imgsArray;
/// 数据源
@property (strong, nonatomic) NSArray *dataArray;


@end

@implementation UpdateDownPageController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self sendRequest];
    
    [self setScrollView];
    [self createSubViews];
    [self setupUI2];
    [self setKefuView];
    
    [self performSelector:@selector(setSlideScrollView) withObject:nil afterDelay:0.5];
}

/// 异步请求
- (void)sendRequest {
    
    NSInteger appUrlType = 4;
    
    //1获取文件的访问路径
    NSString *path = nil;
    if (appUrlType == 1) { /// 悟空彩票
        path=@"https://wkcpappxiufugongjujsavt2nhxz.com:8443/front/wkcp";
    } else if (appUrlType == 2) { /// 800万彩票
        path=@"https://800wanappxiufugongju67bsg.com:8443/front/800";
    } else if (appUrlType == 3) { /// 八戒手游
        path=@"https://bjsyappxiufugongju8byhwe65b.com:8443/front/bajie";
    } else if (appUrlType == 4) { /// 君乐彩票
        path=@"https://jLcpappxiufugongjunhj4wugxz.com:8443/front/junle";
    } else if (appUrlType == 5) { /// 悟空手游
        path=@"https://wksyappxiufugongju9gfxsx.com:8443/front/wksy";
    } else if (appUrlType == 6) { /// 大圣手游
        path=@"https://dssyappxiufugongju5bhxz21wbh.com:8443/front/dasheng";
    } else if (appUrlType == 7) { /// 皇家手游
        path=@"https://hjsyappxiufugongju2hnvu6zcdw.com:8443/front/huangjia";
    } else {   /// 0
        path=@"http://176.113.71.120:8062/front/800";
    }
    
    
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = path;
    entity.needCache = YES;
    
    __weak __typeof(self)weakSelf = self;
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        NSArray *obj = response[@"obj"];
        strongSelf.dataArray = [obj copy];
        [strongSelf setData];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"1");
    } progressBlock:nil];
    
    
    //    NSURL *URL=[NSURL URLWithString:path];
    //    NSURLRequest *URlrequest=[NSURLRequest requestWithURL:URL];
    //    NSURLSession *URlSession=[NSURLSession sharedSession];
    //
    //
    //    __weak __typeof(self)weakSelf = self;
    //
    //    NSURLSessionDataTask *task=[URlSession dataTaskWithRequest:URlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //        __strong __typeof(weakSelf)strongSelf = weakSelf;
    //        if (error) {
    //            return;
    //        }
    //        NSDictionary *dictSession = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    //        NSLog(@"%@",dictSession);
    //        NSArray *obj = dictSession[@"obj"];
    //        strongSelf.dataArray = [obj copy];
    //        // 更新UI，在主线程
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [strongSelf setData];
    //        });
    //    }];
    //    [task resume];
}

- (void)setData {
    
    NSDictionary *dict4 = self.dataArray.lastObject;
    if (dict4) {
        [self.topIconImgView sd_setImageWithURL:[NSURL URLWithString:dict4[@"url"]] placeholderImage:[UIImage imageNamed:@"icon"] options:SDWebImageRefreshCached];
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:dict4[@"url"]] placeholderImage:[UIImage imageNamed:@"icon"] options:SDWebImageRefreshCached];
    }
}

/// 热门点击移动到 立即下载
- (void)onRMGames {
    [self.scrollView setContentOffset:CGPointMake(0, 200)  animated:YES];
}

/// 客服
- (void)onKefuBackView {
    NSDictionary *dict1 = self.dataArray.firstObject;
    [self goto_wkWebView:dict1[@"url"]];
}

/// 立即更新app  立即下载
- (void)updateDownApp {
    if (self.dataArray.count > 2) {
        NSDictionary *dict3 = self.dataArray[2];
        [self goto_wkWebView:dict3[@"url"]];
    }
}
/// 进入官网
- (void)goto_guanwang:(UIButton *)sender {
    if (self.dataArray.count > 1) {
        NSDictionary *dict2 = self.dataArray[1];
        [self goto_wkWebView:dict2[@"url"]];
    }
}


- (void)goto_wkWebView:(NSString *)url {
    AFWKWebViewController *web = [[AFWKWebViewController alloc] init];
    [web loadWebURLSring:url];
    [self.navigationController pushViewController:web animated:YES];
}



- (void)setKefuView {
    
    UIView *kefuBackView = [[UIView alloc] init];
    kefuBackView.backgroundColor = [self colorWithHex:0x4EB3F2];
    [self.view addSubview:kefuBackView];
  
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onKefuBackView)];
    [kefuBackView addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
    
    [kefuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.right.equalTo(self.view.mas_right);
        make.size.mas_equalTo(CGSizeMake(115, 40));
    }];
    
    
    UIImageView *icImg = [[UIImageView alloc] init];
    icImg.image = [UIImage imageNamed:@"right-lay1"];
    [kefuBackView addSubview:icImg];
    
    [icImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(kefuBackView.mas_centerY);
        make.left.equalTo(kefuBackView.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(18, 19));
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"在线客服";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor whiteColor];
    [kefuBackView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(kefuBackView.mas_centerY);
        make.left.equalTo(icImg.mas_right).offset(8);
    }];
    
    [self.view bringSubviewToFront:kefuBackView];
    
}


- (void)setSlideScrollView {
    
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
    NSArray * arr = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *modelList = [NSMutableArray array];
    for (NSInteger index = 0; index < 30; index++) {
        for (NSDictionary *dict in arr) {
            HXQMarqueeModel *model = [[HXQMarqueeModel alloc] initWithDictionary:dict];
            [modelList addObject:model];
        }
    }
    HXQMarqueeView *marqueeView = [[HXQMarqueeView alloc] initWithFrame:CGRectMake(0, 503-137.5, self.view.bounds.size.width, 137.5)];
    marqueeView.backgroundColor = [UIColor clearColor];
    [self.wfBgImg addSubview:marqueeView];
//    marqueeView.isLeftSlide = NO;
    [marqueeView setItems:modelList];
    [marqueeView startAnimation];
    
    [marqueeView addMarueeViewItemClickBlock:^(HXQMarqueeModel *model) {
        NSLog(@"%@",model.userImg);
    }];
}


- (void)setupUI2 {
    
    // 玩法多样
    UIImageView *wfBgImg = [[UIImageView alloc] init];
    wfBgImg.userInteractionEnabled = YES;
    wfBgImg.image = [UIImage imageNamed:@"agein"];
    [self.contentView addSubview:wfBgImg];
    _wfBgImg = wfBgImg;
    
    [wfBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(503);
    }];
    
    // 热门游戏
    UIImageView *rmBgImg = [[UIImageView alloc] init];
    rmBgImg.userInteractionEnabled = YES;
    rmBgImg.image = [UIImage imageNamed:@"hot"];
    [self.contentView addSubview:rmBgImg];
    
    [rmBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wfBgImg.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(351);
    }];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRMGames)];
    [rmBgImg addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
    
    
    // 下载
    UIImageView *xzbImg = [[UIImageView alloc] init];
    xzbImg.image = [UIImage imageNamed:@"bottom"];
    xzbImg.userInteractionEnabled = YES;
    [self.contentView addSubview:xzbImg];
    
    [xzbImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rmBgImg.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(65);
    }];
    
    /// 联系在线客服 领红包
    NSString *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"get" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *uImage = [UIImage sd_imageWithGIFData:imageData];
    
    UIButton *updateBtn = [[UIButton alloc] init];
    [updateBtn setBackgroundImage:uImage forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(onKefuBackView) forControlEvents:UIControlEventTouchUpInside];
    updateBtn.tag = 1002;
    [xzbImg addSubview:updateBtn];
    
    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(xzbImg.mas_centerY);
        make.right.equalTo(xzbImg.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(89, 56));
    }];
}



- (void)createSubViews {
    
    UIImageView *topIconImgView = [[UIImageView alloc] init];
    topIconImgView.layer.cornerRadius = 5;
    topIconImgView.layer.masksToBounds = YES;
    topIconImgView.image = [UIImage imageNamed:@"icon"];
    [self.contentView addSubview:topIconImgView];
    _topIconImgView = topIconImgView;
    
    [topIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(@(40));
    }];
    
    UIButton *inBtn = [[UIButton alloc] init];
    [inBtn setTitle:@"进入官网" forState:UIControlStateNormal];
    [inBtn addTarget:self action:@selector(goto_guanwang:) forControlEvents:UIControlEventTouchUpInside];
    inBtn.backgroundColor = [self colorWithHex:0x3B81E7];
    inBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    inBtn.layer.cornerRadius = 5;
    inBtn.layer.masksToBounds = YES;
    inBtn.tag = 1000;
    [self.contentView addSubview:inBtn];
    
    [inBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topIconImgView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    
    UIImageView *bgImgView = [[UIImageView alloc] init];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:@"bg"];
    [self.contentView addSubview:bgImgView];
    _bgImgView = bgImgView;
    
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIconImgView.mas_bottom).offset(6);
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
    
    
    CGFloat widht = 51.5;
    
    UIView *imgBackView = [[UIView alloc] init];
    //    imgBackView.backgroundColor = [UIColor greenColor];
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
    
    // icon
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.layer.cornerRadius = 5;
    iconImg.layer.masksToBounds = YES;
    iconImg.image = [UIImage imageNamed:@"icon"];
    [bgImgView addSubview:iconImg];
    _iconImg = iconImg;
    
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBackView.mas_bottom).offset(10);
        make.left.equalTo(imgBackView.mas_left);
        make.size.mas_equalTo(55);
    }];
    
    UILabel *xzLabel = [[UILabel alloc] init];
    xzLabel.text = @"下载手机应用";
    xzLabel.font = [UIFont systemFontOfSize:14];
    xzLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:xzLabel];
    
    [xzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_top).offset(5);
        make.left.equalTo(iconImg.mas_right).offset(15);
    }];
    
    UILabel *dzxzLabel = [[UILabel alloc] init];
    dzxzLabel.text = @"点击下载 随时随地都能玩";
    dzxzLabel.font = [UIFont systemFontOfSize:15];
    dzxzLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:dzxzLabel];
    
    [dzxzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(iconImg.mas_bottom).offset(-10);
        make.left.equalTo(xzLabel.mas_left);
    }];
    
    
    UIImageView *gradeImgView = [[UIImageView alloc] init];
    gradeImgView.image = [UIImage imageNamed:@"grade"];
    [bgImgView addSubview:gradeImgView];
    
    [gradeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).offset(15);
        make.left.equalTo(bgImgView.mas_left).offset(5);
        make.right.equalTo(bgImgView.mas_right).offset(-10);
        make.height.mas_equalTo(47);
    }];
    
    UIView *bgXZView = [[UIView alloc] init];
    bgXZView.layer.borderWidth = 1.5;
    bgXZView.layer.borderColor = [self colorWithHex:0xD4D4D4 alpha:0.5].CGColor;
    //    bgXZView.backgroundColor = [UIColor greenColor];
    [bgImgView addSubview:bgXZView];
    
    [bgXZView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gradeImgView.mas_bottom).offset(12);
        make.left.equalTo(bgImgView.mas_left).offset(-2);
        make.right.equalTo(bgImgView.mas_right).offset(2);
        make.height.mas_equalTo(100);
    }];
    
    UIView *nbBgXZView = [[UIView alloc] init];
    //    nbBgXZView.backgroundColor = [UIColor redColor];
    [bgXZView addSubview:nbBgXZView];
    
    [nbBgXZView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgXZView.mas_centerX);
        make.centerY.equalTo(bgXZView.mas_centerY);
        make.left.equalTo(bgXZView.mas_left).offset(55);
        make.right.equalTo(bgXZView.mas_right).offset(-55);
        make.height.mas_equalTo(80);
    }];
    
    /// 立即下载
    CGFloat widthh = 60;
    CGFloat spee = ([[UIScreen mainScreen] bounds].size.width - 55*2- widthh*3)/2;
    NSArray *imgss = @[@"register",@"promptly",@"share"];
    
    for (NSInteger index = 0; index < 3; index++) {
        UIImageView *zsImgView = [[UIImageView alloc] init];
        zsImgView.frame = CGRectMake(index * (widthh + spee), 0, widthh, 80);
        zsImgView.image = [UIImage imageNamed:imgss[index]];
        [nbBgXZView addSubview:zsImgView];
        if (index == 1) {
            zsImgView.userInteractionEnabled = YES;
            //添加手势事件
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateDownApp)];
            //将手势添加到需要相应的view中去
            [zsImgView addGestureRecognizer:tapGesture];
            //选择触发事件的方式（默认单机触发）
            [tapGesture setNumberOfTapsRequired:1];
        }
    }
    
    /// 立即更新 gif图
    NSString *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"update" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *uImage = [UIImage sd_imageWithGIFData:imageData];
    
    UIButton *updateBtn = [[UIButton alloc] init];
    [updateBtn setBackgroundImage:uImage forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(updateDownApp) forControlEvents:UIControlEventTouchUpInside];
    updateBtn.tag = 1001;
    [bgImgView addSubview:updateBtn];
    
    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgXZView.mas_bottom).offset(6);
        make.centerX.equalTo(bgImgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(287, 73));
    }];
    
    
}

- (UIColor*)colorWithHex:(long)hexColor {
    return [self colorWithHex:hexColor alpha:1];
}
- (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
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
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 1000);
    _scrollView.bounces = YES;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    UIView *contentView = [[UIView alloc]init];
    [_scrollView addSubview:contentView];
    //    contentView.backgroundColor = [UIColor greenColor];
    _contentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_scrollView);
        make.width.offset(self.view.bounds.size.width);
        make.height.equalTo(@1505);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", _scrollView);
}


@end

