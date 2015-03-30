//
//  AppDelegate.m
//  TuSDKDemo
//
//  Created by Clear Hu on 14/10/27.
//  Copyright (c) 2014年 Lasque. All rights reserved.
//

#import "AppDelegate.h"
#import "TuSDK/TuSDK.h"
#import "DemoRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     * ！！！！！！！！！！！！！！！！！！！！！！！！！特别提示信息要长！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
     * 关于TuSDK体积（SDK编译后仅为1.9MB）：
     * 1,如果您不需要使用本地贴纸功能，或仅需要使用在线贴纸功能，请删除/app/TuSDK.bundle/stickers文件夹
     * 2,如果您仅需要几款滤镜，您可以删除/app/TuSDK.bundle/textures下的*.gsce文件
     * 3,如果您不需要使用滤镜功能，请删除/app/TuSDK.bundle/textures文件夹
     * 4,TuSDK在线管理功能请访问：http://tusdk.com/
     *
     * IOS编译Framework知识：
     * Framework包含armv7,arm64等不同CPU的编译结果的集合；
     * 其中每种CPU编译结果还包含Debug以及Realse两种子结果；
     * 当集成某个Framework（假如TuSDK.Framework物理文件大小为30MB），编译成APP发布后，实际大小约为不到2MB
     *
     * 开发文档:http://tusdk.com/docs/ios/api/
     */
    
    // 可选: 设置日志输出级别 (默认不输出)
    [TuSDK setLogLevel:lsqLogLevelDEBUG];
    
    // 初始化SDK (请前往 http://tusdk.com 申请秘钥)
    [TuSDK initSdkWithAppKey:@"828d700d182dd469-04-ewdjn1"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    // 初始化根控制器
    self.window.rootViewController = [[TuSDKICNavigationController alloc]initWithRootViewController:[DemoRootViewController controller]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application;
{
    lsqLDebug(@"applicationDidReceiveMemoryWarning");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
