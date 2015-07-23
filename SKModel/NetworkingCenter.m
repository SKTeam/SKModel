//
//  NetworkingCenter.m
//  MRRKTest
//
//  Created by 陈建辉 on 15/7/22.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import "NetworkingCenter.h"
#if __IPH__IPHONE_OS_VERSION_MIN_REQUIRED
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#endif

#import <CoreData.h>
#import <RestKit/RestKit.h>
#import <AFNetworking.h>

#import "RKManagedObjectRequestOperation.h"
@implementation NetworkingCenter
/**************************************************************************************************************************/
/************************                               RestKit                          **********************************/
/************************                         实现对象映射的网络访问                     **********************************/
/**************************************************************************************************************************/

/************************************************************************************************/
/*****                                      外部接口                                         *****/
/************************************************************************************************/
+(void)RKRequestWithData:(NSDictionary *)data
              objectName:(NSString *)objName
                 mapping:(NSDictionary *)mapping
            successBlock:(void (^)(NSArray *))successBlock
                 failure:(void (^)(NSError *))failureBlock
{
    Class objClass = NSClassFromString(objName);
    RKObjectMapping *myMapping = [RKObjectMapping mappingForClass:objClass];
    [myMapping addAttributeMappingsFromDictionary:mapping];
    NSIndexSet *statusCode = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *discript = [RKResponseDescriptor responseDescriptorWithMapping:myMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:statusCode];
    NSMutableURLRequest *request = [self makeRequestUrlWith:data type:@"GET"];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[discript]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successBlock([mappingResult array]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    [operation start];
}



+(void)RKRequestWithData:(NSDictionary*)data
              entityName:(NSString*)entity
                 mapping:(NSDictionary*)mapping
            successBlock:(void (^)(NSArray* resultArray))successBlock
                 failure:(void (^) (NSError *error))failureBlock
{
    [self requestWithUrlPattern:tempPattern Data:data EntityName:entity Mapping:mapping SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
    }];
    
}


///with key path
+(void)RKRequestWithData:(NSDictionary*)data
              entityName:(NSString*)entity
                 mapping:(NSDictionary*)mapping
                 keyPath:(NSString*)keyPath
            successBlock:(void (^)(NSArray* resultArray))successBlock
                 failure:(void (^) (NSError *error))failureBlock
{
    [self requestWithUrlPattern:tempPattern Type:@"GET" Data:data TimeoutInterval:kDefaultTimeInterval EntityName:entity Mapping:mapping KeyPath:keyPath SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
        
    }];
    
}

/************************************************************************************************/
/*****                                      内部接口                                         *****/
/************************************************************************************************/
+(void)requestWithUrlPattern:(NSString*)pattern
                        Type:(NSString*)type
                        Data:(NSDictionary*)data
             TimeoutInterval:(NSTimeInterval)timeoutInterval
                  EntityName:(NSString*)entity
                     Mapping:(NSDictionary*)mapping
                     KeyPath:(NSString*)keyPath
                SuccessBlock:(void (^)(NSArray* resultArray))successBlock
                     failure:(void (^) (NSError *error))failureBlock
{
    //    RKManagedObjectStore *managedObjectStore=[self getRKManageObjecttore];//core data de
    RKManagedObjectStore *managedObjectStore = [RKManagedObjectStore defaultStore];
    
    
    RKEntityMapping *articleMapping = [RKEntityMapping mappingForEntityForName:entity inManagedObjectStore:managedObjectStore];
    [articleMapping addAttributeMappingsFromDictionary:mapping];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping method:RKRequestMethodAny pathPattern:nil keyPath:keyPath statusCodes:statusCodes];
    
    NSMutableURLRequest  *request = [self makeRequestUrlWith:data type:type];
    
    RKManagedObjectRequestOperation *operation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    operation.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
    operation.managedObjectCache = managedObjectStore.managedObjectCache;
    
    operation.savesToPersistentStore = NO;
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        successBlock([result array]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    [operationQueue addOperation:operation];
}

/**
 *根据参数和请求类型生成请求对象
 *@param pattern        pattern路径
 *@param data           参数字典
 *@param entity         entity对象名字
 *@param mapping        对象映射字典
 *@param successBlock   请求成功block
 *@param failureBlock   请求失败block
 **/
+(void)requestWithUrlPattern:(NSString*)pattern Data:(NSDictionary*)data  EntityName:(NSString*)entity Mapping:(NSDictionary*)mapping  SuccessBlock:(void (^)(NSArray* resultArray))successBlock failure:(void (^) (NSError *error))failureBlock{
    [self requestWithUrlPattern:pattern Type:@"GET" Data:data TimeoutInterval:kDefaultTimeInterval EntityName:entity Mapping:mapping KeyPath:nil SuccessBlock:^(NSArray *resultArray){
        successBlock(resultArray);
    } failure:^(NSError *error){
        failureBlock(error);
    }];
    
}
/**
 *创建CoreData需要的RKManagedObjecetStore
 *@
 **/


/**
 *根据参数和请求类型生成请求对象
 *@param data  参数字典
 *@param type  请求类型 GET/POST
 **/
+(NSMutableURLRequest*)makeRequestUrlWith:(NSDictionary*)data type:(NSString*)type{
    
    NSString *dataString = [data descriptionInStringsFileFormat];
    dataString = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];//去掉空格
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\"" withString:@""];//去掉引号
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];//去掉换行符
    dataString = [dataString stringByReplacingOccurrencesOfString:@";" withString:@"&"];//将分号换成&
    dataString = [dataString substringToIndex:dataString.length-1];
    
    NSString *baseUrlString = baseUrl;
    NSString *patternString = tempPattern;
    NSString *urlString = [baseUrlString stringByAppendingString:patternString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];;
    request.HTTPMethod = type;
    request.timeoutInterval = kDefaultTimeInterval;
    
    if ([type isEqualToString:@"POST"]) {
        request.URL = [NSURL URLWithString:urlString];
        request.HTTPBody = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    }else {
        dataString = [@"?" stringByAppendingString:dataString];
        urlString = [urlString stringByAppendingString:dataString];
        request.URL = [NSURL URLWithString:urlString];
    }
    
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    return request;
}

/**************************************************************************************************************************/
/************************                            AFNetworking                        **********************************/
/************************                         实现单次请求和图片加载                     **********************************/
/**************************************************************************************************************************/

+(void)AFNetworkingRequsetWithData:(NSDictionary *)data successBlock:(void (^)(AFHTTPRequestOperation *, id))successBlock failureBlock:(void (^)(AFHTTPRequestOperation *, NSError *))failureBlock{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:baseUrl]];
    [client getPath:@"/CyyApp/ieaction.do" parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation,error);
    }];
}

+(void)AFNetworkingImgLoadWithPath:(NSString *)path commpletBlock:(void (^)(UIImage *))commpletBlock{
    NSString *urlStr = [baseUrl stringByAppendingString:path];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFImageRequestOperation *imgOperation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        commpletBlock(image);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    [imgOperation start];
}
+(void)AFNetworkingImgLoadWithPath:(NSString *)path successBlock:(void (^)(NSURLRequest *,NSHTTPURLResponse *,UIImage *))successBlock failureBlock:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *))failureBlock{
    NSString *urlStr = [baseUrl stringByAppendingString:path];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFImageRequestOperation *imgOperation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        successBlock(request,response,image);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        failureBlock(request,response,error);
    }];
    [imgOperation start];
}


@end
