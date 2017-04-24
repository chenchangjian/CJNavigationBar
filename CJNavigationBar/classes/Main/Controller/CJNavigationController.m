//
//  CJNavigationController.m
//  deliciousDinner
//
//  Created by ccj on 15/9/2.
//  Copyright (c) 2015年 ccj. All rights reserved.
//

#import "CJNavigationController.h"
//#import "CJButton.h"

@interface CJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.title = @"发段子";
    // 设置滑动返回功能
    [self setBackGesture];
   
}


- (void)setBackGesture
{
    UIScreenEdgePanGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    
    NSArray *targets  =  [gesture valueForKeyPath:@"_targets"];
    
    id gestureRecognizer = targets[0];
    
    id target = [gestureRecognizer valueForKeyPath:@"_target"];
    //
    //    NSLog(@"%@",target);
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 借用系统的滑动手势的功能，当触发自己的滑动手势的时候，调用系统的滑动返回功能
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    

}

// 如果返回no，表示不触发这个手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%@~~~", [self.childViewControllers lastObject]);
    
    // 如果你不想让哪个控制器带有滑动返回功能,那么就加入下面的代码,这里是不想GestureViewController自定义的控制器带有滑动返回功能
    // 否则只写return的那一句即可
    //    if ([[self.childViewControllers lastObject] isKindOfClass:[GestureViewController class]])
    //    {
    //        return NO;
    //    }
    
    return self.childViewControllers.count != 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 自动设置所有控制器的返回键
    if (self.childViewControllers.count >= 1)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
                [button sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

         [button addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
//        self.tabBarController.tabBar.hidden = YES;
        viewController.hidesBottomBarWhenPushed = YES;

    }
//    [viewController.view setBackgroundColor:[UIColor colorWithRed:87.0 green:87.0 blue:87.0 alpha:0]];
    
    [super pushViewController:viewController animated:YES];
    
}

- (void)BtnClick
{
    [self popViewControllerAnimated:YES];
}

@end
