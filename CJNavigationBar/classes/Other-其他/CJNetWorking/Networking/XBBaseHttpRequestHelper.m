//
//  XBBaseHttpRequestHelper.m
//  xiu8iOS
//
//  Created by 张淼 on 15/9/9.
//  Copyright (c) 2015年 xiu8. All rights reserved.
//

#import "XBBaseHttpRequestHelper.h"
#import "AFNetworking.h"
static AFHTTPSessionManager *_httpManager;

@implementation XBBaseHttpRequestHelper

+ (AFHTTPSessionManager *)httpManager
{
    if (!_httpManager) {
        _httpManager = [AFHTTPSessionManager manager];
        
        // 设置请求头格式
        _httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_httpManager.requestSerializer setValue:@"Content-type" forHTTPHeaderField:@"application/json;charset=UTF-8"];
    }
    return _httpManager;
}

+ (void)cancelAllOperation
{
    [[self httpManager].operationQueue cancelAllOperations];
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

//    // 设置请求头格式
//    [self httpManager].requestSerializer = [AFJSONRequestSerializer serializer];
//    [[self httpManager].requestSerializer setValue:@"Content-type" forHTTPHeaderField:@"application/json;charset=UTF-8"];
    
//    [[self httpManager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         failure(error);
//    }];
    
    [self.httpManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [[self httpManager] GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void)post:(NSString *)url params:(id)param success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
//    // 设置请求头格式
//    [self httpManager].requestSerializer = [AFJSONRequestSerializer serializer];
//    [[self httpManager].requestSerializer setValue:@"Content-type" forHTTPHeaderField:@"application/json;charset=UTF-8"];
    

//    [[self httpManager] POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//    }];
    
    [self.httpManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [[self httpManager] POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
@end
