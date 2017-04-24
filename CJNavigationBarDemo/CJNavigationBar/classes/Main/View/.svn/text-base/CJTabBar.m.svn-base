//
//  CJTabBar.m
//  百思不得姐
//
//  Created by ccj on 15/9/1.
//  Copyright (c) 2015年 ccj. All rights reserved.
//

#import "CJTabBar.h"
//#import "CJAddViewController.h"

@interface CJTabBar ()

@property (nonatomic, weak) UIButton *pulishButton;


@end

@implementation CJTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIButton *pulishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [pulishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [pulishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [pulishButton sizeToFit];
        self.pulishButton = pulishButton;
        [self addSubview:pulishButton];
        
        
        [pulishButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchDown];
    }
    return self;
    
}

- (void)btnClick
{
//    NSLog(@"%s",__func__);
    //    UITabBarController *rootVc = (UITabBarController *)self.window.rootViewController;
    //    UINavigationController *nav = (UINavigationController *)rootVc.selectedViewController;
    //[nav presentViewController:addView animated:NO completion:nil];
    
    
    
//    CJAddViewController *addView = [[CJAddViewController alloc] init];
//    [self.window.rootViewController presentViewController:addView animated:NO completion:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pulishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);

    int index = 0;
    CGFloat tabBarButtonW = self.frame.size.width / 5;
    CGFloat tabBarButtonH = self.frame.size.height ;
    CGFloat tabBarButtonY = 0;
    for (UIView *tabBarButton in self.subviews)
    {
        
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"])
            continue;
        
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >= 2)
        {
            tabBarButtonX += tabBarButtonW;
        }
        
        
        
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        index ++;
    }
    
    
}

@end
