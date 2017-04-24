//
//  CJNetWorkTools.m
//  mobip2p
//
//  Created by 凤凰金服 on 17/1/12.
//  Copyright © 2017年 zkbc. All rights reserved.
//

#import "CJNetWorkTools.h"
// 用于网络请求
/**
 *  网络请求工具的正式环境均为10443端口,测试环境为10080端口
 *
 *  web工具的正式环境和测试环境均为10080端口
 *  
 *  网络请求的地址带有message/
 */
#define produceEnvironment @"https://fenghuangjinfu.com:10443/message/"
#define testEnvironment @"http://112.74.215.138:10080/message/"

@implementation CJNetWorkTools
+ (CJNetWorkTools *)shareNetworkTools
{
    static CJNetWorkTools * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 注意: 在指定baseURL的时候, 后面需要加上/
        NSURL *url = [NSURL URLWithString:testEnvironment];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    // 设置网络请求基础信息
    [self baseHttpRequestWithTools:instance];
    return instance;
}

+ (void)baseHttpRequestWithTools:(CJNetWorkTools *)instance
{
    [instance.tasks makeObjectsPerformSelector:@selector(cancel)];
    instance.requestSerializer = [AFJSONRequestSerializer serializer];
    [instance.requestSerializer setValue:@"Content-type" forHTTPHeaderField:@"application/json;charset=UTF-8"];

}


#pragma makr - 开始监听网络
- (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:{
                self.networkStatus = AFNetworkReachabilityStatusUnknown;
                CJLog(@"未知");
            }
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.networkStatus = AFNetworkReachabilityStatusNotReachable;
                CJLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.networkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                CJLog(@"蜂窝数据网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                CJLog(@"WiFi");
                
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
    //[manager stopMonitoring]
    
}

/**
 *  网络是否可用
 */
- (BOOL)isNetworkAvailable
{
    if ((self.networkStatus == AFNetworkReachabilityStatusNotReachable) || (self.networkStatus == AFNetworkReachabilityStatusUnknown))
    {
        return NO;
    }else
    {
        return YES;
    }
}

@end
