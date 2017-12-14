//
//  ThemeUtil.h
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//  最上层封装,在应用中使用其方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemeManager.h"



#define MARRAY(selector,property) [Theme_Manager getValueOfProperty:property forSeletor:selector]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


// with selector 即从css文件中取
///1.取常量
#define MFLOAT(selector,property) [ThemeUtil parseFloatFromValues:MARRAY(selector,property)]
///2.去颜色
#define MCOLORX(selector,property) [ThemeUtil getColorOrClearColor:([ThemeUtil parseColorFromValues:MARRAY(selector,property)])]

@interface ThemeUtil : NSObject

///0.返回颜色
+(UIColor*)getColorOrClearColor:(UIColor* )color;

///  可能有dynamic值
///1.取常量
+(CGFloat) parseFloatFromValues:(NSArray*)value;
///2.取颜色
+(UIColor*) parseColorFromValues:(NSArray*)value;




@end
