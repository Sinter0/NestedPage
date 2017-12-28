//
//  StrategyTableViewController.m
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "StrategyTableViewController.h"

@interface StrategyTableViewController ()

@end

@implementation StrategyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    CGFloat headerHeight = SCREEN_HEIGHT / 6 + SEGMENT_HEIGHT;
    // 假的tableview，高度同GameDetailHeadView
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, headerHeight)];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = [@"攻略名称" stringByAppendingString:[NSString stringWithFormat:@"%ld", indexPath.row]];
    
    cell.detailTextLabel.text = @"当前共收录：xxx篇";
    cell.imageView.image = [UIImage imageNamed:@"fake_game"];
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
