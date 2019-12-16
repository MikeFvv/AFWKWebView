//
//  AFWKWebViewController.h
//  AFWKWebView
//
//  Created by lvan Lewis on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFWKWebViewController : UIViewController
@property (nonatomic,assign) BOOL isNavHidden;
- (void)loadWebURLSring:(NSString *)string;
- (void)loadWebHTMLSring:(NSString *)string;
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;

@end

NS_ASSUME_NONNULL_END
