//
//  HXQBoardView.h
//  AFWKWebView
//
//  Created by Tiny on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXQMarqueeModel;
@interface HXQBoardView : UIView

-(instancetype)initWithFrame:(CGRect)frame Model:(HXQMarqueeModel *)model;

@property (nonatomic, copy) void (^boardItemClick)(HXQMarqueeModel *model);

@end
