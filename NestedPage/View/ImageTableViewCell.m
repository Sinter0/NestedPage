//
//  ImageTableViewCell.m
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "ImageCollectionViewCell.h"

@implementation ImageCollectionView

@end

@implementation ImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/4);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[ImageCollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
        
        [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellID];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.bounds;
}

/// 设置delegate，dataSource等
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath {
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    // 把cell的indexPath传递给collectionView
    self.collectionView.indexPath = indexPath;
    // 这里不能仅仅使用 [self.collectionView setContentOffset:CGPointZero]
    [self.collectionView setContentOffset:CGPointZero animated:NO];
    [self.collectionView reloadData];
}


@end
