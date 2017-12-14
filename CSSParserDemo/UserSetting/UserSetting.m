//
//  UserSetting.m
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import "UserSetting.h"

static NSString * const UserSettingsIsNightMode = @"QDUserSettingsIsNightMode";

@implementation UserSetting

+ (instancetype)currentUserSettings {
    static UserSetting *currentUserSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentUserSettings = [[UserSetting alloc] init];
    });
    return currentUserSettings;
}


- (BOOL)nightMode{
    return [[NSUserDefaults standardUserDefaults] boolForKey:UserSettingsIsNightMode];
}

- (void)setNightMode:(BOOL)nightMode{
    [[NSUserDefaults standardUserDefaults] setBool:nightMode forKey:UserSettingsIsNightMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
