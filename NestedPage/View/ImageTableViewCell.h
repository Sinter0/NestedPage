//
//  ImageTableViewCell.h
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CollectionViewCellID = @"CollectionViewCellID";

@interface ImageCollectionView : UICollectionView

// collectionView所在的tableViewCell的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@interface ImageTableViewCell : UITableViewCell

@property (nonatomic, strong) ImageCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;


@end
