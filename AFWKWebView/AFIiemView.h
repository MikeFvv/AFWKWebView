//
//  AFIiemView.h
//  AFWKWebView
//
//  Created by Tiny on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFItemModel;
@interface AFIiemView : UIView

-(instancetype)initWithFrame:(CGRect)frame Model:(AFItemModel *)model;

@property (nonatomic, copy) void (^boardItemClick)(AFItemModel *model);

@end
