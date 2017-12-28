//
//  MainHeaderView.h
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title downloads:(NSString *)downloads descripe:(NSString *)descripe;

@end
