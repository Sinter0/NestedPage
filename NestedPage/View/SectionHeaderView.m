//
//  SectionHeaderView.m
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "SectionHeaderView.h"
@interface SectionHeaderView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation SectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:self.label];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setLabelText:(NSString *)labelText {
    self.label.text = labelText;
}

@end
