//
//  UserSetting.h
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSetting : NSObject

@property (nonatomic,assign) BOOL nightMode;

+ (instancetype)currentUserSettings;

@end
