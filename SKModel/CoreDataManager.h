//
//  CoreDataManager.h
//  MRRKTest
//
//  Created by 陈建辉 on 15/7/20.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kSortKey @"zn_id"
#define kNumForTable 10
@interface CoreDataManager : NSObject

//1. 初始化 MagicalRecord 和 RestKit
+ (void)initMagicalRecordAndRestKit;

//2. 清空并移除 MagicalRecord
+ (void)clearMagicalRecord;

//3. 清空一个实体
+ (void)clearEntity:(NSString*)entityName;

//4.获取一个实体的所有元素并根据 index 排序
+ (NSArray*)arrayOfEntity:(NSString*)entityName;
+ (NSArray*)arrayOfEntity:(NSString*)entityName sortBy:(NSString*)sortKey ascending:(BOOL)isAscending;

//5.获取UITableView一次加载的10各entity
+ (NSArray*)arrayForTable:(NSString*)entityName withPage:(NSInteger)page;
//6. 检查某个kSortKey的条目是否已经存储了，是者不存，否则存
+ (BOOL)checkEntityExist:(NSString*)entityName withKey:(NSNumber*)key;
@end
