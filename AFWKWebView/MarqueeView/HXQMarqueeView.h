//
//  HXQMarqueeView.h
//  AFWKWebView
//
//  Created by Tiny on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXQMarqueeModel;
@interface HXQMarqueeView : UIView

/// 是否向左滑动
@property (nonatomic, assign) BOOL isLeftSlide;

-(void)setItems:(NSArray <HXQMarqueeModel *>*)items;

-(void)addMarueeViewItemClickBlock:(void(^)(HXQMarqueeModel *model))block;

-(void)stopAnimation;

-(void)startAnimation;


@end
