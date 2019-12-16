//
//  AFScrollView.m
//  AFWKWebView
//
//  Created by Tiny on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import "AFScrollView.h"
#import "AFItemModel.h"
#import "AFIiemView.h"
#import "UIView+Extionsiton.h"

@interface AFScrollView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewList;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, copy) void (^itelClick)(AFItemModel *);


@end

@implementation AFScrollView

-(void)dealloc{
    [self.timer  invalidate];
    self.timer = nil;
}

-(NSMutableArray *)viewList{
    if (!_viewList) {
        _viewList = [NSMutableArray array];
    }
    return _viewList;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.008f target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _isLeftSlide = YES;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.scrollEnabled = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}

-(void)setItems:(NSArray *)items{

    _models = items;
    //移除动画
    [self.scrollView.layer removeAllAnimations];
    
    //先移除之前的item
    for (UIView *v in self.scrollView.subviews) {
        if ([v isKindOfClass:[AFIiemView class]]) {
            [v removeFromSuperview];
        }
    }
    [self.viewList removeAllObjects];
    
    //创建新的item
    AFIiemView *last = nil;
    CGFloat margin = 2;
    for (int i = 0; i < items.count; i++) {
        AFItemModel *model = items[i];
        AFIiemView * lb = [[AFIiemView alloc] initWithFrame:CGRectMake(last.frame.origin.x + last.bounds.size.width + margin, 0, model.width, 137.5) Model:model];
        __weak typeof(self) weakself = self;
        lb.boardItemClick = ^(AFItemModel *xModel) {
            if (weakself.itelClick) {
                weakself.itelClick(xModel);
            }
        };
        lb.tag = i;
        [self.scrollView addSubview:lb];
        [self.viewList addObject:lb];
        last = lb;
    }
    
    if (self.isLeftSlide) {
        //设置scrollView的contentSize
        self.scrollView.contentSize = CGSizeMake(last.frame.origin.x+last.bounds.size.width, 0);
        CGSize contetnsize = self.scrollView.contentSize;
        self.scrollView.frame = CGRectMake(0,0,contetnsize.width+self.bounds.size.width, 137.5);
        self.clipsToBounds = YES;
    } else {
        //设置scrollView的contentSize
        self.scrollView.contentSize = CGSizeMake(-(last.frame.origin.x+last.bounds.size.width), 0);
        CGSize contetnsize = self.scrollView.contentSize;
        self.scrollView.frame = CGRectMake(self.bounds.size.width,0,contetnsize.width, 137.5);
        self.clipsToBounds = YES;
    }
    
}

-(void)refreshProgress{
    
    if (self.isLeftSlide) {
        self.scrollView.x -=0.5;
        if (self.scrollView.x <= -(self.scrollView.contentSize.width - self.bounds.size.width)) {
            self.scrollView.x = 0;
        }
    } else {
        self.scrollView.x +=0.5;
        if (self.scrollView.x >= 0) {
            self.scrollView.x = self.scrollView.contentSize.width + self.bounds.size.width;
        }
    }
}



- (void)startAnimation {
    if (!self.timer.isValid) {
        [self.timer fire];
    }
}

-(void) stopAnimation{  //结束动画
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - Private
-(void)addMarueeViewItemClickBlock:(void (^)(AFItemModel *))block{
    self.itelClick = block;
}

@end
