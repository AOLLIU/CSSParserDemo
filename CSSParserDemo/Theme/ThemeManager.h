//
//  ThemeManager.h
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//  和CSSParser相连的中间层,主要是处理获取到的元素及值

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject

+ (instancetype)shareManager;

///获取某个元素的某个值
- (NSArray*)getValueOfProperty:(NSString*)property forSeletor:(NSString *)selector;

@end

#define Theme_Manager [ThemeManager shareManager]
