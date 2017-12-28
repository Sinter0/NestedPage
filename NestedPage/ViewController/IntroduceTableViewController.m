//
//  IntroduceTableViewController.m
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "IntroduceTableViewController.h"
#import "ImageTableViewCell.h"
#import "ImageCollectionViewCell.h"
#import "ContentTableViewCell.h"
#import "SectionHeaderView.h"

static NSString *kCellID0 = @"cellID0";
static NSString *kCellID1 = @"cellID1";
static NSString *kCellID2 = @"cellID2";

NS_ENUM(NSInteger, CellTyle) {
    CellTyleIntroduceImage = 0,
    CellTypeContentText,
    CellTypeRelatedList
};

@interface IntroduceTableViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
// 是否显示更多内容，即全文和收起
@property (nonatomic, getter=isShowMoreContent) BOOL showMoreContent;
// 介绍的内容
@property (nonatomic, copy) NSString *contentString;

@end

@implementation IntroduceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    CGFloat headerHeight = SCREEN_HEIGHT / 6 + SEGMENT_HEIGHT;
    // 假的tableview，高度同GameDetailHeadView
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, headerHeight)];

    self.showMoreContent = NO;

    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;

}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case CellTyleIntroduceImage:
            return 1;
            break;
        case CellTypeContentText:
            return 1;
            break;
        case CellTypeRelatedList:
            return 10;
            break;
        default:
            break;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case CellTyleIntroduceImage:{
            ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID0];
            if (!cell) {
                cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID0];
            }
            return cell;
            break;
        }
        case CellTypeContentText:{
            __weak __typeof(self) weakSelf = self;
            
            ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID1];
            if (!cell) {
                cell = [[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:kCellID1];
                self.contentString = @"";
                
                for (int i = 0; i < 150; i++) {
                    self.contentString = [self.contentString stringByAppendingString:@"介绍"];
                }
                cell.showMoreContent = self.isShowMoreContent;
                cell.gameIntroduce = self.contentString;
                cell.indexPath = indexPath;
                __weak __typeof(cell) weakCell = cell;
                cell.showMoreBlock = ^(NSIndexPath *indexPath) {
                    weakCell.showMoreContent = weakSelf.isShowMoreContent;
                    weakSelf.showMoreContent = !weakSelf.isShowMoreContent;
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath]
                                              withRowAnimation:UITableViewRowAnimationFade];
                };
            }
            return cell;
            break;
        }
        case CellTypeRelatedList:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID2];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:kCellID2];
            }
            cell.textLabel.text = [@"游戏相关条目" stringByAppendingString:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case CellTyleIntroduceImage:
            return SCREEN_HEIGHT / 3;
            break;
        case CellTypeContentText:{
            if (self.isShowMoreContent) {
                return [ContentTableViewCell cellMoreContentHeight:self.contentString];
            } else {
                return [ContentTableViewCell cellDefaultHeight];
            }
            break;
        }
        case CellTypeRelatedList:
            return 60;
            break;
        default:
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ImageTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CellTyleIntroduceImage) {
        [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    backgroundView.backgroundColor = [UIColor clearColor];
    SectionHeaderView *view = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 30)];
    
    if (section == 0) {
        return nil;
    }
    
    switch (section) {
        case CellTypeContentText:
            view.labelText = @"内容摘要";
            break;
        case CellTypeRelatedList:
            view.labelText = @"游戏相关";
        default:
            break;
    }
    [backgroundView addSubview:view];
    return backgroundView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == CellTyleIntroduceImage) {
        return 0;
    }
    return 40;
}

#pragma mark - collection view deta source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[ImageCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT/4, SCREEN_HEIGHT/4)];
    }
    cell.imageView.image = [UIImage imageNamed:@"fake_game"];
    return cell;
}

@end
