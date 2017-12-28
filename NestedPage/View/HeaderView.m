//
//  MainHeaderView.m
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title downloads:(NSString *)downloads descripe:(NSString *)descripe {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        // 图标
        UIImageView *gameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.height/8, self.height/10, self.height/2, self.height/2)];
        gameImageView.image = [UIImage imageNamed:@"fake_game"];
        gameImageView.layer.cornerRadius = 10;
        [gameImageView.layer setMasksToBounds:YES];
        [self addSubview:gameImageView];
        
        // 标题
        UILabel *titleLabel = [self labelWithText:title
                                        textColor:[UIColor blackColor]
                                         fontSize:18];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(gameImageView.mas_right).mas_equalTo(20);
            make.top.equalTo(gameImageView);
        }];
        
        // 下载次数
        UILabel *downloadsLabel = [self labelWithText:downloads
                                            textColor:[UIColor grayColor]
                                             fontSize:14];
        [self addSubview:downloadsLabel];
        [downloadsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.top.equalTo(titleLabel.mas_bottom).mas_equalTo(12);
        }];
        
        // 描述
        UILabel *descripLabel = [self labelWithText:descripe
                                          textColor:[UIColor grayColor]
                                           fontSize:14];
        [self addSubview:descripLabel];
        [descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(downloadsLabel);
            make.bottom.equalTo(gameImageView);
        }];
        
        // 分栏器
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"介绍", @"攻略"]];
        self.segmentedControl.selectedSegmentIndex = 0;
        self.segmentedControl.selected = YES;
        self.segmentedControl.tintColor = [UIColor grayColor];
        [self addSubview:self.segmentedControl];
        
        CGFloat segmentControlWidthScale = 8 / 10.0;
        [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(gameImageView.mas_bottom).mas_equalTo(self.height/10);
            make.width.mas_equalTo(self.width*segmentControlWidthScale);
        }];
        
        // 底边线
        CALayer *line = [CALayer layer];
        line.frame = CGRectMake(0, self.height-1, self.width, 1);
        line.backgroundColor = [UIColor grayColor].CGColor;
        [self.layer addSublayer:line];
    }
    return self;
}

/// 初始化一个UILabel
- (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    return  label;
}

@end
