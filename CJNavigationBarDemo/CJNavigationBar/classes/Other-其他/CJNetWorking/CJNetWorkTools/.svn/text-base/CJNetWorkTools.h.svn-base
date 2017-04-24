//
//  CJNetWorkTools.h
//  mobip2p
//
//  Created by 凤凰金服 on 17/1/12.
//  Copyright © 2017年 zkbc. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CJNetWorkTools : AFHTTPSessionManager
@property(nonatomic, assign) AFNetworkReachabilityStatus networkStatus;

+ (instancetype)shareNetworkTools;
// 开始监听网络
- (void)startMonitoring;
// 检测是否有网络
- (BOOL)isNetworkAvailable;
@end
