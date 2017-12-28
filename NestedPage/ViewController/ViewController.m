//
//  ViewController.m
//  NestedPage
//
//  Created by Xing on 2017/12/26.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import "IntroduceTableViewController.h"
#import "StrategyTableViewController.h"



@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) IntroduceTableViewController *introduceTVC;
@property (nonatomic, strong) StrategyTableViewController *strategyTVC;
@property (nonatomic, assign) CGFloat scrollViewHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    // headerView置于上层
    [self.view addSubview:self.headerView];
    
    self.introduceTVC = [[IntroduceTableViewController alloc] init];
    self.strategyTVC = [[StrategyTableViewController alloc] init];
    [self setupChildViewController:self.introduceTVC x:0];
    [self setupChildViewController:self.strategyTVC x:SCREEN_WIDTH];
}

- (HeaderView *)headerView {
    if (!_headerView) {
        CGFloat headerHeight = SCREEN_HEIGHT / 6 + SEGMENT_HEIGHT;
        _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, headerHeight)
                                                  title:@"王者荣耀"
                                              downloads:@"n+ 次下载"
                                               descripe:@"1.1 GB"];
        
        [_headerView.segmentedControl addObserver:self
                                       forKeyPath:@"selectedSegmentIndex"
                                          options:NSKeyValueObservingOptionNew
                                          context:nil];
    }
    return _headerView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollViewHeight = self.view.height - 64;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollViewHeight)];
        _scrollView.contentSize = CGSizeMake(self.view.width*2, self.scrollViewHeight);
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)setupChildViewController:(UITableViewController *)tableViewController x:(CGFloat)x {
    UITableViewController *tableVC = tableViewController;
    tableVC.view.frame = CGRectMake(x, 0, self.view.width, self.scrollViewHeight);
    [self addChildViewController:tableVC];
    [self.scrollView addSubview:tableVC.view];
    [tableVC.tableView addObserver:self
                        forKeyPath:@"contentOffset"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
}


#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     if (scrollView == self.scrollView) {
        // 滑动到游戏介绍页
        if (scrollView.contentOffset.x == 0) {
            if (self.headerView.segmentedControl.selectedSegmentIndex != 0) {
                self.headerView.segmentedControl.selectedSegmentIndex = 0;
            }
            // 滑动到攻略页
        } else if (scrollView.contentOffset.x == self.view.width) {
            if (self.headerView.segmentedControl.selectedSegmentIndex != 1) {
                self.headerView.segmentedControl.selectedSegmentIndex = 1;
            }
        }
    }

    if (scrollView == self.introduceTVC.tableView) {
        NSLog(@"%f", scrollView.contentOffset.y);
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat headerViewScrollStopY = (int)SCREEN_HEIGHT/6 - 15.0;
        UITableView *tableView = object;
        CGFloat contentOffsetY = tableView.contentOffset.y;
        // 滑动没有超过停止点,头部视图跟随移动
        if (contentOffsetY < headerViewScrollStopY) {
            self.headerView.y = - tableView.contentOffset.y;
            // 同步tableView的contentOffset
            for (UITableViewController *vc in self.childViewControllers) {
                if (vc.tableView.contentOffset.y != tableView.contentOffset.y) {
                    vc.tableView.contentOffset = tableView.contentOffset;
                }
            }
        // 头部视图固定位置
        } else {
            self.headerView.y = - headerViewScrollStopY;
            // 解决高速滑动下tableView偏移量错误的问题
            if (self.headerView.segmentedControl.selectedSegmentIndex == 0) {
                UITableViewController *vc = self.childViewControllers[1];
                if (vc.tableView.contentOffset.y < headerViewScrollStopY) {
                    CGPoint contentOffset = vc.tableView.contentOffset;
                    contentOffset.y = headerViewScrollStopY;
                    vc.tableView.contentOffset = contentOffset;
                }
            } else {
                UITableViewController *vc = self.childViewControllers[1];
                if (vc.tableView.contentOffset.y < headerViewScrollStopY) {
                    CGPoint contentOffset = vc.tableView.contentOffset;
                    contentOffset.y = headerViewScrollStopY;
                    vc.tableView.contentOffset = contentOffset;
                }
            }
        }
    }
    
    // segmentController选中不同按钮切换scrollView的页面
    if ([keyPath isEqualToString:@"selectedSegmentIndex"]) {
        // 点击介绍
        if (self.headerView.segmentedControl.selectedSegmentIndex == 0) {
            self.scrollView.contentOffset = CGPointZero;
        // 点击攻略
        } else {
            self.scrollView.contentOffset = CGPointMake(self.view.width, 0);
        }
    }
}

- (void)dealloc {
    [self.headerView.segmentedControl removeObserver:self forKeyPath:@"selectedSegmentIndex"];
    [self.introduceTVC.tableView removeObserver:self forKeyPath:@"contentOffset"];
    [self.strategyTVC.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
