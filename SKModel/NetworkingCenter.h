//
//  NetworkingCenter.h
//  MRRKTest
//
//  Created by 陈建辉 on 15/7/22.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import <Foundation/Foundation.h>

#define baseUrl @"my host's ip"
#define tempPattern @"/myPattern"
#define kDefaultTimeInterval 3

@class AFHTTPRequestOperation;
@class UIImage;
@interface NetworkingCenter : NSObject
/**************************************************************************************************************************/
/************************                               RestKit                          **********************************/
/************************                         实现对象映射的网络访问                     **********************************/
/**************************************************************************************************************************/
/**
 *直接发起RK的网络请求，对象映射是简单的对象而不是CoreData的entity
 *@param data           参数字典
 *@param objName        对象名字
 *@param mapping        对象映射字典
 *@param successBlock   请求成功block
 *@param failureBlock   请求失败block
 **/
+ (void)RKRequestWithData:(NSDictionary*)data objectName:(NSString*)objName mapping:(NSDictionary*)mapping successBlock:(void(^)(NSArray* resultArray))successBlock failure:(void(^)(NSError *error))failureBlock;

+(void)RKRequestWithData:(NSDictionary*)data  entityName:(NSString*)entity mapping:(NSDictionary*)mapping  successBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock;

///带keyPath参数
+(void)RKRequestWithData:(NSDictionary*)data  entityName:(NSString*)entity mapping:(NSDictionary*)mapping keyPath:(NSString*)keyPath  successBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock;


/**************************************************************************************************************************/
/************************                            AFNetworking                        **********************************/
/************************                         实现单次请求和图片加载                     **********************************/
/**************************************************************************************************************************/
+ (void)AFNetworkingRequsetWithData:(NSDictionary*)data successBlock:(void(^)(AFHTTPRequestOperation *operation,id resultObject))successBlock failureBlock:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;

+ (void)AFNetworkingImgLoadWithPath:(NSString*)path commpletBlock:(void(^)(UIImage* urlImg))commpletBlock;
+ (void)AFNetworkingImgLoadWithPath:(NSString*)path successBlock:(void(^)(NSURLRequest *request,NSHTTPURLResponse *response,UIImage *urlImg))successBlock failureBlock:(void(^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failureBlock;
@end
