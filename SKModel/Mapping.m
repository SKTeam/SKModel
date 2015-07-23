//
//  Mapping.m
//  2015-07-21 TableViewController
//
//  Created by 陈建辉 on 15/7/23.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import "Mapping.h"

@implementation Mapping
/*SKCellDataEntity
 @property (nonatomic, retain) NSNumber * footerCommentNum;
 @property (nonatomic, retain) NSNumber * footerLikeNum;
 @property (nonatomic, retain) NSNumber * keyIndex;
 @property (nonatomic, retain) NSString * mainImgUrl;
 @property (nonatomic, retain) NSString * mainText;
 @property (nonatomic, retain) NSString * titleimgName;
 @property (nonatomic, retain) NSString * titleImgUrl;
 @property (nonatomic, retain) NSString * titleName;
 @property (nonatomic, retain) NSString * titleSubName;
 @property (nonatomic, retain) NSString * titleTime;
 */

+(NSDictionary *)cellDataEntityMapping{//根据自己网络返回来确定空格内容，如果某一项没有就去除那一项
    return @{@" ":@"titleName",
             @" ":@"titleSubName",
             @" ":@"titleimgName",
             @" ":@"titleImgUrl",
             @" ":@"titleTime",
             @" ":@"mainText",
             @" ":@"mainImgUrl",
             @" ":@"footerCommentNum",
             @" ":@"footerLikeNum",
             @" ":@"keyIndex",
             };
}

@end
