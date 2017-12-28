//
//  ImageCollectionViewCell.m
//  NestedPage
//
//  Created by Xing on 2017/12/27.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}


@end
