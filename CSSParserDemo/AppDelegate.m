//
//  AppDelegate.m
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import "AppDelegate.h"
#import "MyNavigationController.h"
#import "MyHomeViewController.h"
#import "UserSetting.h"

#define lf_ColorRGB(r,a) [UIColor colorWithRed:(r>>16&0xff)/255. green:(r>>8&0xff)/255. blue:(r&0xff)/255. alpha:a]

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *nightWindow;

@end

@implementation AppDelegate

- (UIWindow *)nightWindow {
    if (_nightWindow == nil) {
        _nightWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _nightWindow.userInteractionEnabled = NO;
        _nightWindow.backgroundColor = lf_ColorRGB(0x000000, 0.55);
        _nightWindow.windowLevel = UIWindowLevelStatusBar;
    }
    return _nightWindow;
}

- (void)setNight {
    self.nightWindow.hidden = !![UserSetting currentUserSettings].nightMode;
}

- (MyNavigationController *)navigationController {
    
    if (nil == _navigationController) {
        MyHomeViewController *homeVC = [[MyHomeViewController alloc] init];
        _navigationController = [[MyNavigationController alloc] initWithRootViewController:homeVC];
    }
    return _navigationController;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
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
