//
//  AppDelegate.h
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyNavigationController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MyNavigationController *navigationController;

- (void)setNight;

@end

