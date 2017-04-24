//
//  JSFinanTableViewController.m
//  fenghuangjinfu
//
//  Created by ccj on 2017/4/5.
//  Copyright © 2017年 ccj. All rights reserved.
//

#import "JSFinanTableViewController.h"
#import "TitlePagerView.h"
#import "CJHomeController.h"
#import "JSFinderTableViewController.h"
#import "CJMeTableViewController.h"
#import <pop/POP.h>
#define NavBarFrame self.navigationController.navigationBar.frame

@interface JSFinanTableViewController ()<ViewPagerDataSource, ViewPagerDelegate, TitlePagerViewDelegate, CJHomeDelegate>
@property (nonatomic, strong) TitlePagerView *pagingTitleView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) CJHomeController *interestVC;
@property (nonatomic, strong) JSFinderTableViewController *hotVC;
@property (nonatomic, strong) CJMeTableViewController *TopNewVC;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *backView;
@property (assign, nonatomic)BOOL isHidden;

@property (weak, nonatomic) UIView *scrollView;
@property (nonatomic, assign) CGPoint offset;
@end

@implementation JSFinanTableViewController

- (void)viewDidLoad {
    self.dataSource = self;
    self.delegate = self;
    self.manualLoadData = YES;
    
    self.currentIndex = 0;
    
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    
    [self reloadData];
    
    
}

-(void)initNav{
    self.title = @"理财";
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CJScreenW, 40)];
    self.backView.backgroundColor = CJRandomColor;
    [self.view addSubview:self.backView];
    CJLog(@"self.view = %@", [self.view class]);
    self.pagingTitleView.center = self.backView.center;
    self.pagingTitleView.centerY = 20;
    [self.backView addSubview:self.pagingTitleView];
    self.backView.userInteractionEnabled = YES;
    self.backView.multipleTouchEnabled = YES;
    self.backView.exclusiveTouch = YES;
    self.pagingTitleView.userInteractionEnabled = YES;
    self.pagingTitleView.multipleTouchEnabled = YES;
    self.pagingTitleView.exclusiveTouch = YES;
    

}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 3;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    if (index == 0) {
        return [self createNewestVC];
    } else if (index == 1) {
        return [self createHotsVC];
    } else {
        return [self createNewVC];
    }
}

// 在这里生成子控制器(首页中还有三个子控制器)
- (UIViewController *)createNewestVC {
    self.interestVC = [[CJHomeController  alloc] init];
    self.interestVC.delegate = self;
    return self.interestVC;
}

- (UIViewController *)createHotsVC {
    self.hotVC = [[JSFinderTableViewController alloc] init];
    return self.hotVC;
    
}

- (UIViewController *)createNewVC {
    self.TopNewVC = [[CJMeTableViewController alloc] init];
    return self.TopNewVC;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    self.currentIndex = index;
}

- (TitlePagerView *)pagingTitleView {
    if (!_pagingTitleView) {
        self.pagingTitleView = [[TitlePagerView alloc] init];
        self.pagingTitleView.frame = CGRectMake(0, 0, 0, 40);
        self.pagingTitleView.font = [UIFont systemFontOfSize:16];
        NSArray *titleArray = @[@"关注", @"热门", @"最新"];
        self.pagingTitleView.tintColor = [UIColor whiteColor];
        self.pagingTitleView.width = [TitlePagerView calculateTitleWidth:titleArray withFont:self.pagingTitleView.font];
        [self.pagingTitleView addObjects:titleArray];
        self.pagingTitleView.delegate = self;
    }
    return _pagingTitleView;
}


- (void)didTouchBWTitle:(NSUInteger)index {
    //    NSInteger index;
    CJLog(@"33333333");
    UIPageViewControllerNavigationDirection direction;
    
    if (self.currentIndex == index) {
        return;
    }
    
    if (index > self.currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    UIViewController *viewController = [self viewControllerAtIndex:index];
    
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}

- (void)setCurrentIndex:(NSInteger)index {
    _currentIndex = index;
    [self.pagingTitleView adjustTitleViewByIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    if (self.currentIndex != 0 && contentOffsetX <= CJScreenW * 2) {
        contentOffsetX += CJScreenW * self.currentIndex;
    }
    
    [self.pagingTitleView updatePageIndicatorPosition:contentOffsetX];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)tableViewDidScrolleToTopWithOffset:(CGPoint) offset
{
    dispatch_async(
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // 执行耗时的异步操作...
       CGFloat offsetY = offset.y - self.offset.y;
       self.offset = offset;
       CJLog(@"offsetY = %f", offsetY);
       if (offset.y <= 5 || offsetY < 0)
       {
           if (self.isHidden)
           {
               CGRect navBarFrame=NavBarFrame;
               CGRect scrollViewFrame=self.view.frame;
               
               navBarFrame.origin.y = 20;
               scrollViewFrame.origin.y += 44;
               scrollViewFrame.size.height -= 44;
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   self.navigationItem.title = @"理财";
                   // 回到主线程，执行UI刷新操作
                   [UIView animateKeyframesWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction) animations:^{
                       NavBarFrame = navBarFrame;
                       self.scrollView.frame=scrollViewFrame;
                       //                self.backView.y = 0;
                       self.backView.height = 40;
                       self.pagingTitleView.centerY = 20;
                       self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                       self.view.frame = scrollViewFrame;
                   } completion:^(BOOL finished) {
                   }];

               });
               self.isHidden= NO;
               CJLog(@"11111");
           }
       }else if (offset.y > 5)
       {
           if (!self.isHidden)
           {
               CGRect frame =NavBarFrame;
               CGRect scrollViewFrame=self.view.frame;
               frame.origin.y = -24;
               scrollViewFrame.origin.y -= 44;
               scrollViewFrame.size.height += 44;
               dispatch_async(dispatch_get_main_queue(), ^{
                   // 回到主线程，执行UI刷新操作
                   
                   [UIView animateKeyframesWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction) animations:^{
                       NavBarFrame = frame;
                       self.scrollView.frame=scrollViewFrame;
                       //                self.backView.y = 0;
                       self.backView.height = 44;
                       self.pagingTitleView.centerY = 22;
                       
                       self.view.frame = scrollViewFrame;
                       self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
                   } completion:^(BOOL finished) {
                       self.navigationItem.title = nil;
                   }];

               });
               self.isHidden=YES;
               CJLog(@"222222");
           }
       }
    });
    
}

@end
