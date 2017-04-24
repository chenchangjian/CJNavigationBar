//
//  CJHomeController.m
//  deliciousDinner
//
//  Created by 凤凰金服 on 16/8/12.
//  Copyright © 2016年 碧桂园. All rights reserved.
//

#import "CJHomeController.h"
//#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "CJNetWorkTools.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "CJTabBarController.h"
#import "CJRefreshHeader.h"

@interface CJHomeController ()
@property (nonatomic, strong) NSMutableArray *allTheTops;
@end

@implementation CJHomeController

static NSString * const ID = @"topic";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置
    [self setNavGationBar];
    [self setupInset];
    [self refresh];
//    [self MonitoringNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置导航条
- (void)setNavGationBar
{
    self.navigationItem.title = @"首页";
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_coin_icon" highImage:@"nav_coin_icon_click" target:self action:@selector(rightClick)];
    
    //    self.navigationItem.rightBarButtonItems = @[settingButton, moonButton];
    //
}

- (NSMutableArray *)allTheTops
{
    if (!_allTheTops)
    {
        _allTheTops = [NSMutableArray array];
        
    }
    return _allTheTops;
}

- (void)setupInset
{
    self.tableView.contentInset = UIEdgeInsetsMake(44,0,49,0);
    //    self.view.backgroundColor = CCJCommonBgColor;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //    self.tableView.rowHeight = 200;
    // 设置tableView的预估行高
    self.tableView.estimatedRowHeight = 100;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 取消多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // 注册cell
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SJDishTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

- (void)refresh
{
    // 普通刷新
//    // 下拉刷新
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MonitoringNet)];
//    // 自动改变透明度
//    self.tableView.mj_header.automaticallyChangeAlpha = YES;
//    
//    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
//    
//    // 上拉刷新
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTags)];
//    //    self.tableView.footer = [CJMyFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTags)];
//    
//    self.tableView.mj_footer.hidden = YES;
    
    // 自定义动画刷新
    CJRefreshHeader *header = [CJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(MonitoringNet)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
    
}

// 监听网络
- (void)MonitoringNet
{
    CJNetWorkTools *manager = [CJNetWorkTools shareNetworkTools];
    BOOL isNetWork = [manager isNetworkAvailable];
    if (isNetWork)
    {
        [self setupEnternet];
    }else
    {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
        });
    }
    
}

- (void)setupEnternet
{
    CJLogFunc;
//    CJNetWorkTools *manager = [CJNetWorkTools shareNetworkTools];
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"a"] = @"list";
//    dict[@"c"] = @"data";
//    dict[@"type"] = @(self.type);// @1;
//
//    // 发送请求
//    CCJWeakSelf;
    // 发送请求
//    [manager POST:@"index" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        
//    }];
NSDictionary *params = @{
                         @"loginName":@"niub",
                         @"password":@"123456",
                         @"type":@"JSON",
                         };
    
    // andDataType参数 为模型, 如果传入模型, 就返回转完模型后的数组,也就是返回成功的data 此时是装模型的数组
    // 如果没有传入模型, 就把原始数据字典数组什么都不处理就返回, 也可以自己在返回后自己转模型数组
    // 框架使用,需要在info.plist中添加
    //    <key>NSAppTransportSecurity</key><dict>
    //    <key>NSAllowsArbitraryLoads</key>
    //    <true/></dict>
    // 具体看印象笔记 网络图片在ios9之后加载不上去的问题https协议

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        NSLog(@"!@!#@$$");
    });

}

- (void)loadMoreTags
{   // 在发请求前一定要先停止以前的请求
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    dict[@"a"] = @"list";
    //    dict[@"c"] = @"data";
    //    dict[@"type"] = @(self.type);// @1;
    //    dict[@"maxtime"] = self.maxtime;
    //
    //    // 发送请求
    //    CCJWeakSelf;
    //    [weakSelf.manager GET:CCJRequestURL parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
    //        NSLog(@"%@!!!!!!!",responseObject);
    //
    //        weakSelf.allTops = [CJTpos objectArrayWithKeyValuesArray:responseObject[@"list"]];
    //        [weakSelf.allTheTops addObjectsFromArray:weakSelf.allTops];
    //
    //
    //        // 存储maxtime
    //        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
    //        [weakSelf.tableView reloadData];
    //        [weakSelf.tableView.footer endRefreshing];
    //
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        [weakSelf.tableView.footer endRefreshing];
    //
    //    }];
    
    NSDictionary *params = @{
                             @"loginName":@"niub",
                             @"password":@"123456",
                             @"type":@"JSON",
                             };
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.allTheTops.count;
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    CJTopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//
//    cell.tops = self.allTheTops[indexPath.row];


    //    CGFloat cellY = CGRectGetMaxY(cell.text_label.frame);
    //    _cellY = cellY;
//    return cell;
    
    UITableViewCell *cell= [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


#pragma mark - cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    CJTpos *topic = self.allTheTops[indexPath.row];
    //    return  topic.cellHeight;
    return 40;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CJCommentController *comContry = [[CJCommentController alloc] init];
//    //    [self presentViewController:comContry animated:YES completion:nil];
//    
//    comContry.topic = self.allTheTops[indexPath.row];
//    [self.navigationController pushViewController:comContry animated:YES];
//    //    self.navigationController.hidesBottomBarWhenPushed = YES;
//    
//}

//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
//{
//    if ([self.delegate respondsToSelector:@selector(tableViewDidScrolleToTop)]) {
//        [self.delegate tableViewDidScrolleToTop];
//    }
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if ([self.delegate respondsToSelector:@selector(tableViewDidScrolleToTopWithOffset:)]) {
        [self.delegate tableViewDidScrolleToTopWithOffset:offset];
    }
}


@end
