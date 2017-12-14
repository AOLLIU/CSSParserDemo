//
//  ThemeManager.m
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import "ThemeManager.h"
#import "UserSetting.h"
#import "NICSSParser.h"
#import "DeviceInfo.h"

#define THEME_STYLE_DEFINE_FILE @"style.css"
#define THEME_RES_PATH_IPHONE5_SUBFIX @"~iPhone5"
#define THEME_RES_PATH_IPHONE6P_SUBFIX @"~iPhone6p"
#define THEME_RES_PATH_IPHONEX_SUBFIX @"~iPhoneX"
#define THEME_RES_PATH_NIGHTMODE_SUBFIX @"~nightmode" //夜间模式

#define THEME_RES_CONSTANTS @"#constants"
#define THEME_RES_PATH_CONSTANTS_SUBFIX @"~constants"

@interface ThemeManager ()

@property (nonatomic,strong) NSMutableDictionary *iPhoneThemeDic;
@property (nonatomic,strong) NSMutableDictionary *constantsThemeDic;
@property (nonatomic,strong) NSMutableDictionary *iPhoneNightModeThemeDic;
@property (nonatomic, retain) NSMutableDictionary *imageCache;

@end


static ThemeManager *_themeManager = nil;

@implementation ThemeManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _themeManager = [[self alloc] init];
    });
    return _themeManager;
}

- (id)init {
    self = [super init];
    if (self) {
        _constantsThemeDic = [[NSMutableDictionary alloc] init];
        _imageCache = [[NSMutableDictionary alloc] init];
        [self loadiPhoneCSSStyle];
        [self loadConstantsCSSStyle];
    }
    return self;
}


- (void)loadiPhoneCSSStyle{
    _iPhoneThemeDic = [[NSMutableDictionary alloc] init];
    
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSString *path = [bundleRoot stringByAppendingPathComponent:THEME_STYLE_DEFINE_FILE];
    
    NSDictionary* parentDic = [[[NICSSParser alloc] init] dictionaryForPath:path];
    [self rebuildThemeDictionaryWithThemeDictionary:parentDic toDictionary:_iPhoneThemeDic];
    
    if ([DeviceInfo is320wScreen]) {
        NSString* iPhone5Path = [[[path stringByDeletingPathExtension] stringByAppendingString:THEME_RES_PATH_IPHONE5_SUBFIX] stringByAppendingPathExtension:@"css"];;
        parentDic = [[[NICSSParser alloc] init] dictionaryForPath:iPhone5Path];
        [self rebuildThemeDictionaryWithThemeDictionary:parentDic toDictionary:_iPhoneThemeDic];
    } else if ([DeviceInfo isiPhone6pScreen]) {
        NSString* iPhone6pPath = [[[path stringByDeletingPathExtension] stringByAppendingString:THEME_RES_PATH_IPHONE6P_SUBFIX] stringByAppendingPathExtension:@"css"];;
        parentDic = [[[NICSSParser alloc] init] dictionaryForPath:iPhone6pPath];
        [self rebuildThemeDictionaryWithThemeDictionary:parentDic toDictionary:_iPhoneThemeDic];
    } else if ([DeviceInfo isiPhoneXScreen]) {
        NSString* iPhoneXPath = [[[path stringByDeletingPathExtension] stringByAppendingString:THEME_RES_PATH_IPHONEX_SUBFIX] stringByAppendingPathExtension:@"css"];;
        parentDic = [[[NICSSParser alloc] init] dictionaryForPath:iPhoneXPath];
        [self rebuildThemeDictionaryWithThemeDictionary:parentDic toDictionary:_iPhoneThemeDic];
    }
    
    _iPhoneNightModeThemeDic = [[NSMutableDictionary alloc] init];
    NSString* nightModePath = [[[path stringByDeletingPathExtension] stringByAppendingString:THEME_RES_PATH_NIGHTMODE_SUBFIX] stringByAppendingPathExtension:@"css"];;
    parentDic = [[[NICSSParser alloc] init] dictionaryForPath:nightModePath];
    [self rebuildThemeDictionaryWithThemeDictionary:parentDic toDictionary:_iPhoneNightModeThemeDic];
}

- (void)loadConstantsCSSStyle{
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSString *path = [bundleRoot stringByAppendingPathComponent:THEME_STYLE_DEFINE_FILE];
    NSString* contantsPath = [[[path stringByDeletingPathExtension] stringByAppendingString:THEME_RES_PATH_CONSTANTS_SUBFIX] stringByAppendingPathExtension:@"css"];;
    NSDictionary* parentDic = [[[NICSSParser alloc] init] dictionaryForPath:contantsPath];
    [self rebuildThemeDictionaryWithThemeDictionary:parentDic toDictionary:_constantsThemeDic];
}


-(BOOL) rebuildThemeDictionaryWithThemeDictionary:(NSDictionary*)dic toDictionary:(NSMutableDictionary*)targetDic{
    if (dic == nil || dic.count == 0 || targetDic == nil) {
        return NO;
    }
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL *stop) {
        if (![key isKindOfClass:[NSString class]] || obj == nil || ![obj isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        NSMutableDictionary* curChildDictionary = [targetDic objectForKey:key];
        if (curChildDictionary == nil) {
            curChildDictionary = [NSMutableDictionary dictionary];
            [targetDic setObject:curChildDictionary forKey:key];
        }
        
        __block NSMutableDictionary* blockCurChildDictionary = curChildDictionary;
        [obj enumerateKeysAndObjectsUsingBlock:^(NSString* childkey, id childValue, BOOL *stop) {
            if (![childkey isKindOfClass:[NSString class]] || childValue == nil || [childkey isEqualToString:kPropertyOrderKey]) {
                return;
            }
            if ([childValue isKindOfClass:[NSArray class]]) {
                [blockCurChildDictionary setObject:childValue forKey:childkey];
            } else if ([childValue isKindOfClass:[NSString class]]) {
                NSArray* childValueArray = [childValue componentsSeparatedByString:@" "];
                if (childValueArray && childValueArray.count > 0) {
                    [blockCurChildDictionary setObject:childValueArray forKey:childkey];
                }
            }
        }];
    }];
    
    return YES;
}



- (NSArray*)getValueOfProperty:(NSString*)property forSeletor:(NSString *)selector {
    //如果需要ipad也使用这种方法可以在这里分开处理
    return [self getiPhoneValueOfProperty:property forSeletor:selector];
}


- (NSArray*)getiPhoneValueOfProperty:(NSString*)property forSeletor:(NSString *)selector
{
    NSArray* result = nil;
    
    if ([UserSetting currentUserSettings].nightMode) {
        NSDictionary* childThemeDic = [_iPhoneNightModeThemeDic objectForKey:selector];
        if (childThemeDic) {
            result = [childThemeDic objectForKey:property];
        }
    }
    
    if (result == nil) {
        NSDictionary* childThemeDic = [_iPhoneThemeDic objectForKey:selector];
        if (childThemeDic) {
            result = [childThemeDic objectForKey:property];
        }
    }
    
    return [self constantsValueForArray:result];
}

- (NSArray* ) constantsValueForArray:(NSArray*) input{
    if (input == nil || input.count != 1) {
        return input;
    }
    return [self constantsValueForKey:[input firstObject]];
}

- (NSArray* ) constantsValueForKey:(NSString*) key{
    if (([key isKindOfClass:[NSNull class]] || key == nil || key.length == 0)) {
        return @[key];
    }
    NSDictionary* childThemeDic = [_constantsThemeDic objectForKey:THEME_RES_CONSTANTS];
    if (childThemeDic) {
        NSArray* result = [childThemeDic objectForKey:key];
        if (result) {
            return result;
        }
    }
    return @[key];
}

@end
