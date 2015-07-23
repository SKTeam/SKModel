//
//  CoreDataManager.m
//  MRRKTest
//
//  Created by 陈建辉 on 15/7/20.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import "CoreDataManager.h"
#import <MagicalRecord.h>
#import <RestKit.h>
#import <NSManagedObjectContext+MagicalRecord.h>
@implementation CoreDataManager

+(void)initMagicalRecordAndRestKit{
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"myStore.sqlite"];
    
    RKManagedObjectStore *managedStore = [[RKManagedObjectStore alloc] initWithPersistentStoreCoordinator:[NSPersistentStoreCoordinator MR_defaultStoreCoordinator]];
    [managedStore createManagedObjectContexts];
    
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:managedStore.persistentStoreCoordinator];
    
    
#warning 手动更改MagicalRecord
    /*
     *这个地方很奇怪啊，这两个函数都是写在m文件中的，我只能手动在相应的h文件中添加申明
     */
    [NSManagedObjectContext MR_setRootSavingContext:managedStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:managedStore.mainQueueManagedObjectContext];

}

+(void)clearMagicalRecord{
    [MagicalRecord cleanUp];
}

+(void)clearEntity:(NSString *)entityName{
    [NSClassFromString(entityName) MR_truncateAll];
}

//4.获取entity所有元素
+(NSArray *)arrayOfEntity:(NSString *)entityName{
    return [self arrayOfEntity:entityName sortBy:kSortKey ascending:NO];
}

+(NSArray *)arrayOfEntity:(NSString *)entityName sortBy:(NSString *)sortKey ascending:(BOOL)isAscending{
   return [NSClassFromString(entityName) MR_findAllSortedBy:sortKey ascending:isAscending];
}

//5.获取entity 的10 条元素
+(NSArray *)arrayForTable:(NSString *)entityName withPage:(NSInteger)page{
    NSArray *resultArr = [self arrayOfEntity:entityName];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i<kNumForTable; i++) {
        [arr addObject:resultArr[kNumForTable*page + i]];
    }
    return arr;
}

+(BOOL)checkEntityExist:(NSString *)entityName withKey:(NSNumber *)key{
    id entity = [NSClassFromString(entityName) MR_findFirstByAttribute:@"zn_id" withValue:key];
    if (entity) {
        return YES;
    }
    return NO;
}

@end
