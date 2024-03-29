//
//  AppDelegate.m
//  AFWKWebView
//
//  Created by lvan Lewis on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import "AppDelegate.h"
#import "AFWKWebViewController.h"
#import "UpdateDownPageController.h"

@interface AppDelegate ()
///
@property (nonatomic, copy) NSString *URL;
///
@property (nonatomic, strong) AFWKWebViewController *webView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self sendRequest];
    //    [self sendSyncWithRequest];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    AFWKWebViewController *web = [[AFWKWebViewController alloc] init];
    UpdateDownPageController *web = [[UpdateDownPageController alloc] init];
    //    [web loadWebURLSring:self.URL];
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:web];;
    _webView = web;
    
    [self.window makeKeyAndVisible];
    return YES;
}


/// 异步请求
- (void)sendRequest {
    NSString *path=@"http://176.113.71.120:8062/app/wksy";
    NSURL *URL=[NSURL URLWithString:path];
    NSURLRequest *URlrequest=[NSURLRequest requestWithURL:URL];
    NSURLSession *URlSession=[NSURLSession sharedSession];
    
    
    __weak __typeof(self)weakSelf = self;
    
    NSURLSessionDataTask *task=[URlSession dataTaskWithRequest:URlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        // json 解析
        NSDictionary *dictSession = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dictSession);
        NSArray *obj = dictSession[@"obj"];
        NSDictionary *dictPar = obj.firstObject;
        NSString *url = dictPar[@"url"];
        
//        url = @"https://www.baidu.com/";  ///<<< AFan 上线这里需要注释掉
        // 更新UI，在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
           [strongSelf.webView loadWebURLSring:url];
        });
        
        
    }];
    [task resume];
}
/// 同步请求
- (void)sendSyncWithRequest
{
    NSString *strURL = @"http://176.113.71.120:8062/app/wksy";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSString *error = dict[@"error"];
    if (error) {
        NSLog(@"请求返回错误");
        //                 [MBProgressHUD showError:error];
    } else{
        NSArray *obj = dict[@"obj"];
        NSLog(@"%@", obj);
        NSDictionary *dictPar = obj.firstObject;
        self.URL = dictPar[@"url"];
        //        NSString *success = dict[@"success"];
        //                 [MBProgressHUD showSuccess:success];
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
