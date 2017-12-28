//
//  ContentTableViewCell.m
//  NestedPage
//
//  Created by Xing on 2017/12/26.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "ContentTableViewCell.h"

static const CGFloat kBlankLength = 10;

@interface ContentTableViewCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *showMoreButton;
// 记录button初始的frame
@property (nonatomic, assign) CGRect btnOriFrame;

@end

@implementation ContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBlankLength, kBlankLength, SCREEN_WIDTH-kBlankLength*2, 100)];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.contentLabel];
        
        self.showMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.showMoreButton setTitle:@"更多" forState:UIControlStateNormal];
        [self.showMoreButton addTarget:self
                                action:@selector(showMoreOrLessContent)
                      forControlEvents:UIControlEventTouchUpInside];
        [self.showMoreButton sizeToFit];
        CGFloat unFoldButtonX = SCREEN_WIDTH - kBlankLength - self.showMoreButton.width;
        CGFloat unFoldButtonY = kBlankLength * 2 + self.contentLabel.height;
        CGRect buttonFrame = self.showMoreButton.frame;
        buttonFrame.origin.x = unFoldButtonX;
        buttonFrame.origin.y = unFoldButtonY;
        self.showMoreButton.frame = buttonFrame;
        self.btnOriFrame = buttonFrame;
        [self.contentView addSubview:self.showMoreButton];
    }
        
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isShowMoreContent) {
        // 计算文本高度
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        CGSize size = [self.gameIntroduce boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kBlankLength*2, 1000) options:option attributes:attribute context:nil].size;
        
        self.contentLabel.frame = CGRectMake(kBlankLength, kBlankLength, SCREEN_WIDTH-kBlankLength*2, size.height+20);
        
        CGFloat buttonMoreContentY = kBlankLength * 2 + self.contentLabel.height;
        CGRect buttonMoreContentRect = self.btnOriFrame;
        buttonMoreContentRect.origin.y = buttonMoreContentY;
        self.showMoreButton.frame = buttonMoreContentRect;
        [self.showMoreButton setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        self.contentLabel.frame = CGRectMake(kBlankLength, kBlankLength, SCREEN_WIDTH-kBlankLength*2, 100);
        self.showMoreButton.frame = self.btnOriFrame;
        [self.showMoreButton setTitle:@"全文" forState:UIControlStateNormal];
    }
}

- (void)showMoreOrLessContent {
    if (self.showMoreBlock) {
        self.showMoreBlock(self.indexPath);
    }
}



- (void)setGameIntroduce:(NSString *)gameIntroduce {
    self.contentLabel.text = gameIntroduce;
    _gameIntroduce = gameIntroduce;
}


+ (CGFloat)cellDefaultHeight {
    return 160;
}

+ (CGFloat)cellMoreContentHeight:(NSString *)content {
    // 计算文本高度
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kBlankLength*2, 1000) options:option attributes:attribute context:nil].size;
    return size.height + 80;
}

@end
