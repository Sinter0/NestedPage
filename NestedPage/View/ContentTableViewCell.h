//
//  ContentTableViewCell.h
//  NestedPage
//
//  Created by Xing on 2017/12/26.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShowMoreBlock)(NSIndexPath *indexPath);

@interface ContentTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *gameIntroduce; // 游戏介绍内容
@property (nonatomic, strong) NSIndexPath *indexPath; // 用于刷新指定cell
@property (nonatomic, assign, getter=isShowMoreContent) BOOL showMoreContent; // 是否显示更多内容

@property (nonatomic, copy) ShowMoreBlock showMoreBlock; // 点击更多按钮回调

/// 默认高度（收起）
+ (CGFloat)cellDefaultHeight;

/// 显示全文的高度
+ (CGFloat)cellMoreContentHeight:(NSString *)content;

@end
