//
//  MyNavigationView.m
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/12/14.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import "MyNavigationView.h"
#import "ThemeUtil.h"

@interface MyNavigationView ()


@end

@implementation MyNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, self.bounds.size.height)];
        CGPoint center = titleLabel.center;
        titleLabel.text = @"首页";
        titleLabel.textColor =  MCOLORX(@"#MyViewController",@"navigationViewTitleColor");
        center.x = self.center.x;
        titleLabel.center = center;
        self.backgroundColor = MCOLORX(@"#MyViewController",@"navigationViewColor");
        
        [self addSubview:titleLabel];
    }
    return self;
}

@end
