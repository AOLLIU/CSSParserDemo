//
//  ViewController.m
//  CSSParserDemo
//
//  Created by 刘伟 on 2017/11/21.
//  Copyright © 2017年 com.Qdaily.asnail. All rights reserved.
//

#import "MyHomeViewController.h"
#import <Masonry.h>
#import "UserSetting.h"
#import "ThemeUtil.h"
#import "AppDelegate.h"
#import "MyNavigationView.h"

@interface MyHomeViewController ()

@property (nonatomic,strong) MyNavigationView *myNavigationView;

@end

@implementation MyHomeViewController

- (UIView *)myNavigationView {
    if (_myNavigationView == nil) {
        _myNavigationView = [[MyNavigationView alloc]initWithFrame: CGRectMake(0, 0, self.view.bounds.size.width, MFLOAT(@"#MyViewControllerUI", @"containerViewMarginTop"))];
    }
    return _myNavigationView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = MCOLORX(@"#MyViewController",@"backGoundColor");
    [self.view addSubview:self.myNavigationView];
    [self configUI];
    [self configSettingBtn];
}


- (void)configUI {
    UIView *containerView = [[UIView alloc]init];
    containerView.backgroundColor =  MCOLORX(@"#MyViewControllerUI", @"containerBgcolor");
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(MFLOAT(@"#MyViewControllerUI", @"containerViewMarginTop"));
        make.left.equalTo(self.view).offset(MFLOAT(@"#MyViewControllerUI", @"containerViewMarginLeftAndRight"));
        make.right.equalTo(self.view).offset(-MFLOAT(@"#MyViewControllerUI", @"containerViewMarginLeftAndRight"));
        make.height.mas_equalTo(MFLOAT(@"#MyViewControllerUI", @"containerViewHeight"));
    }];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"book.jpg"];
    [containerView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.left.right.equalTo(containerView);
        make.height.mas_equalTo(MFLOAT(@"#MyViewControllerUI", @"imageVHeight"));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [containerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).offset(MFLOAT(@"#MyViewControllerUI", @"titleLabelMarginTotop"));
        make.left.equalTo(containerView).offset(MFLOAT(@"#MyViewControllerUI", @"titleLabelMarginToLeftRight"));
        make.right.equalTo(self.view).offset(-MFLOAT(@"#MyViewControllerUI", @"titleLabelMarginToLeftRight"));
    }];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = @"哪些图省事的推理桥段,让你看完想烧书?";
    
    UILabel *subTitleLabel = [[UILabel alloc]init];
    [containerView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(MFLOAT(@"#MyViewControllerUI", @"subTitleLabelMarginTotop"));
        make.left.equalTo(containerView).offset(MFLOAT(@"#MyViewControllerUI", @"subTitleLabelMarginToLeftRight"));
        make.right.equalTo(self.view).offset(-MFLOAT(@"#MyViewControllerUI", @"subTitleLabelMarginToLeftRight"));
    }];
    subTitleLabel.numberOfLines = 2;
    subTitleLabel.font = [UIFont systemFontOfSize:15];
    subTitleLabel.text = @"罚抄十戒二十法则命题三十要素一百遍,让你不好好学!";
}

- (void)configSettingBtn {
    
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"ChangeMode" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(changeMode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-100);
        make.width.mas_equalTo(150);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)changeMode:(UIButton *)sender {
    [UserSetting currentUserSettings].nightMode = ![UserSetting currentUserSettings].nightMode;
    
    UIWindow * rootWindow = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    [UIView transitionWithView:[UIApplication sharedApplication].delegate.window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        ((AppDelegate*)[UIApplication sharedApplication].delegate).navigationController = nil;
                        rootWindow.rootViewController = (UIViewController *)((AppDelegate*)[UIApplication sharedApplication].delegate).navigationController;
                    }
                    completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

