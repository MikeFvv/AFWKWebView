//
//  AFItemModel.h
//  AFWKWebView
//
//  Created by Tiny on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AFItemModel : NSObject

@property (nonatomic , copy)NSString *userImg;  //头像

@property (nonatomic, assign) CGFloat width;  //视图总宽度

- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
