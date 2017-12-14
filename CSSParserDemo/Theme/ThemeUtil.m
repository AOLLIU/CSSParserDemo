//
//  ThemeUtil.m
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import "ThemeUtil.h"
#define CONSTANTS_THEME_DYNAMIC @"dynamic"

@implementation ThemeUtil


+ (UIColor *)getColorOrClearColor:(UIColor *)color {
  
    if (color==nil) {
        return [UIColor clearColor];
    }
    return color;
}


+(CGFloat) parseFloatFromValues:(NSArray*)value {
    
    CGFloat floatValue = [[value firstObject] floatValue];
    if ([[value lastObject] isEqualToString:CONSTANTS_THEME_DYNAMIC]) {
        floatValue *= [ThemeUtil themeScale];
    }
    return floatValue;
}

+(UIColor*) parseColorFromValues:(NSArray*)cssValues {
    UIColor* anColor = nil;
    
    BOOL validCss =       [cssValues count] == 1
    || [cssValues count] == 5    // rgb( x x x )
    || [cssValues count] == 6;   // rgba( x x x x )
    if ( !validCss )
    {
        return nil;
    }
    
    if ([cssValues count] == 1) {
        NSString* cssString = [cssValues firstObject];
        
        if ([cssString characterAtIndex:0] == '#') {
            unsigned long colorValue = 0;
            float alpha = 1;
            // #FFF
            if ([cssString length] == 4) {
                colorValue = strtol([cssString UTF8String] + 1, nil, 16);
                colorValue = ((colorValue & 0xF00) << 12) | ((colorValue & 0xF00) << 8)
                | ((colorValue & 0xF0) << 8) | ((colorValue & 0xF0) << 4)
                | ((colorValue & 0xF) << 4) | (colorValue & 0xF);
                
                // #FFFFFF
            } else if ([cssString length] == 7) {
                colorValue = strtol([cssString UTF8String] + 1, nil, 16);
            } else if ([cssString length] == 9) {
                alpha = strtol([[cssString substringFromIndex:7] UTF8String],nil,16) / 255.0;
                colorValue = strtol([[cssString substringToIndex:7] UTF8String] + 1, nil, 16);
            }
            
            anColor = RGBACOLOR(((colorValue & 0xFF0000) >> 16),
                                ((colorValue & 0xFF00) >> 8),
                                (colorValue & 0xFF),
                                alpha
                                );
            
        } else {
            anColor = nil;
        }
    } else if ([cssValues count] == 5 && [[cssValues firstObject] isEqualToString:@"rgb("]) {
        // rgb( x x x )
        anColor = RGBCOLOR([[cssValues objectAtIndex:1] floatValue],
                           [[cssValues objectAtIndex:2] floatValue],
                           [[cssValues objectAtIndex:3] floatValue]);
        
    } else if ([cssValues count] == 6 && [[cssValues firstObject] isEqualToString:@"rgba("]) {
        // rgba( x x x x )
        anColor = RGBACOLOR([[cssValues objectAtIndex:1] floatValue],
                            [[cssValues objectAtIndex:2] floatValue],
                            [[cssValues objectAtIndex:3] floatValue],
                            [[cssValues objectAtIndex:4] floatValue]);
    }
    
    return anColor;
}

+ (CGFloat) themeScale {
    CGFloat scale = [UIScreen mainScreen].bounds.size.width/375; // iPhone下只要写了dynamic 就认为按照iPhone6的视觉稿出图做放缩
    return scale;
}
@end
