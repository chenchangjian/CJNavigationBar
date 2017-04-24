//
//  CJTabBarController.m
//  deliciousDinner
//
//  Created by 凤凰金服 on 16/8/12.
//  Copyright © 2016年 碧桂园. All rights reserved.
//

#import "CJTabBarController.h"
#import "CJTabBar.h"
#import "CJHomeController.h"
#import "JSFinanTableViewController.h"
#import "JSFinderTableViewController.h"
#import "CJMeTableViewController.h"
#import "CJNavigationController.h"

@interface CJTabBarController ()
{
    NSInteger oldIndex;
}
@property (nonatomic, strong)NSMutableArray *controllerArr;
@property (nonatomic, strong)CJHomeController *home;
@property (nonatomic, strong)JSFinanTableViewController *finan;
@property (nonatomic, strong)JSFinderTableViewController *finder;
@property (nonatomic, strong)CJMeTableViewController *me;
@end

@implementation CJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置子控制器
    
    
    [self setupItems];
    [self setChildVC];
    // 设置自定义tabBar
    // 如果想在中间再加入一个tabBarItem, 那么就用下面的这个方法
    // 但是要重新生成一个组, 用于放置CJAddViewController
//    [self setTabBar];
}

- (NSMutableArray *)controllerArr
{
    if (!_controllerArr)
    {
        _controllerArr = [NSMutableArray array];
    }
    return _controllerArr;
}

- (void)setTabBar
{
    [self setValue:[[CJTabBar alloc] init] forKey:@"tabBar"];
}


- (void)setChildVC
{
 
    self.home = [[CJHomeController alloc] init];
    self.finan = [[JSFinanTableViewController alloc ]init];
    self.finder = [[JSFinderTableViewController alloc]init];
    self.me = [[CJMeTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self setUpChildVC: self.home title: @"首页" image:@"tabBar_essence_icon" imageClicked:@"tabBar_essence_click_icon"];
    
    [self setUpChildVC:self.finan title:@"理财" image:@"tabBar_new_icon" imageClicked:@"tabBar_new_click_icon"];
    
    
    [self setUpChildVC:self.finder title:@"发现" image:@"tabBar_friendTrends_icon" imageClicked:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChildVC:self.me title: @"我的" image:@"tabBar_me_icon" imageClicked:@"tabBar_me_click_icon"];
    
}

- (void)setUpChildVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image imageClicked:(NSString *)imageClicked
{
    
    CJNavigationController *v1 = [[CJNavigationController alloc] initWithRootViewController:VC];
    [self.controllerArr addObject:VC];
    CJLog(@"_controllerArr.count = %ld", _controllerArr.count);
    v1.tabBarItem.title = title;
    //
    v1.tabBarItem.image = [UIImage imageNamed:image];
    
    UIImage *clickImage = [UIImage imageNamed:imageClicked];
    UIImage *selected = [clickImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    v1.tabBarItem.selectedImage = selected;
    //    v1.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    v1.view.backgroundColor = CJCommonBgColor;
    
    [self addChildViewController:v1];
    
}

- (void)setupItems
{
    
    // UIControlStateNormal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 统一给所有的UITabBarItem设置文字属性
    // 只有后面带有UI_APPEARANCE_SELECTOR的属性或方法, 才可以通过appearance对象来统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger selectIndex = [tabBar.items indexOfObject:item];
    // 先判断是否双击
    if ([self checkIsDoubleClick:self.controllerArr[selectIndex]])
    {
        // 发送代理通知刷新
        CJLogFunc;
        if (selectIndex == 0)
        {
            [self.home refresh];
        }
    }else
    { // 单击, 执行动画
        if (selectIndex != oldIndex) {
            [self animationWithIndex:selectIndex];
            CJLogFunc;
        }

    }

}

- (void)animationWithIndex:(NSInteger)index {
//     Image + Label动画
        NSMutableArray *animationArrayM = [NSMutableArray array];
        for (UIView *tabBarButton in self.tabBar.subviews) {
            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [animationArrayM addObject:tabBarButton];
            }
        }
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
        animation.duration = 1;
        animation.calculationMode = kCAAnimationCubic;
        // 添加动画
        [[animationArrayM[index] layer] addAnimation:animation forKey:nil];
    
        oldIndex = index;
    
    
    // Image动画
//    NSMutableArray *animationArrayM = [NSMutableArray array];
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            for (UIImageView *imageV in tabBarButton.subviews) {
//                if ([imageV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//                    [animationArrayM addObject:imageV];
//                }
//            }
//        }
//    }
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"transform.scale";
//    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
//    animation.duration = 1;
//    animation.calculationMode = kCAAnimationCubic;
//    
//    CABasicAnimation *anim2 = [CABasicAnimation animation];
//    
//    anim2.keyPath = @"transform.rotation";
//    
//    anim2.toValue = @(arc4random_uniform(360) / 180.0 * M_PI);
//    
//    anim2.duration = 1;
//    // 添加动画
//    [[animationArrayM[index] layer] addAnimation:animation forKey:nil];
//    
//    oldIndex = index;
    
}

// 判断是否双击
- (BOOL)checkIsDoubleClick:(UIViewController *)viewController
{
    static UIViewController *lastViewController = nil;
    static NSTimeInterval lastClickTime = 0;
    
    if (lastViewController != viewController) {
        lastViewController = viewController;
        lastClickTime = [NSDate timeIntervalSinceReferenceDate];
        
        return NO;
    }
    
    NSTimeInterval clickTime = [NSDate timeIntervalSinceReferenceDate];
    if (clickTime - lastClickTime > 0.5 ) {
        lastClickTime = clickTime;
        return NO;
    }
    
    lastClickTime = clickTime;
    return YES;
}
@end
