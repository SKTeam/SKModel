//
//  SKCellDataEntity.h
//  SKModel
//
//  Created by 陈建辉 on 15/7/23.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SKCellDataEntity : NSManagedObject

//@property (nonatomic, retain) NSNumber * footerCommentNum;
//@property (nonatomic, retain) NSNumber * footerLikeNum;
//@property (nonatomic, retain) NSNumber * keyIndex;
//@property (nonatomic, retain) NSString * mainImgUrl;
//@property (nonatomic, retain) NSString * mainText;
//@property (nonatomic, retain) NSString * titleimgName;
//@property (nonatomic, retain) NSString * titleImgUrl;
//@property (nonatomic, retain) NSString * titleName;
//@property (nonatomic, retain) NSString * titleSubName;
//@property (nonatomic, retain) NSString * titleTime;


@property (nonatomic, retain) NSNumber * keyIndex;
@property (nonatomic, retain) NSString * titleName;
@property (nonatomic, retain) NSString * titleSubName;
@property (nonatomic, retain) NSString * titleImgName;
@property (nonatomic, retain) NSString * titleImgUrl;
@property (nonatomic, retain) NSString * titleTime;
@property (nonatomic, retain) NSString * mainText;
@property (nonatomic, retain) NSString * mainImgUrl;
@property (nonatomic, retain) NSNumber * footerLikeNum;
@property (nonatomic, retain) NSNumber * footerCommentNum;

@end
