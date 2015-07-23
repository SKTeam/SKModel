//
//  SKCellFactory.h
//  2015-07-21 TableViewController
//
//  Created by 陈建辉 on 15/7/22.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKCellDataEntity.h"

//这里之所以用@class而不是#import是为了当cell很多的时候，避免table 在#import “SKCellFactor” 时不会#import到它不需要的cell
//不把SKCellDataEntity在这#import而是在m文件也是一个原因
@class UITableViewCell;
@class SKTitleCell;
@class SKMainCell;
@class SKFooterCell;

@interface SKCellFactory : NSObject

//cell 的创建可以用一个函数来做
+ (UITableViewCell*)createCellWithName:(NSString*)cellName identifier:(NSString*)identifier;

//设置数据的外部接口

+ (void)setDataForCell:(UITableViewCell*)cell withEntity:(SKCellDataEntity*)entity;

//设置代理
+ (void)setDelegate:(id)delegate forCell:(UITableViewCell*)cell;

/********************************************************************************************/
/********************         内部接口，为每个类型的cell设置数据         *************************/
/********************************************************************************************/
//cell 的内容设置还是每个都写一遍吧
//因为我不想把数据设置函数写在cell的类中，而是写在factor中，让cell类仅仅处理UI
+ (void)setDataForTiltleCell:(SKTitleCell *)cell withEntity:(SKCellDataEntity *)entity;

+ (void)setDataForMainCell:(SKMainCell *)cell withEntity:(SKCellDataEntity *)entity;

+ (void)setDataForFooterCell:(SKFooterCell *)cell withEntity:(SKCellDataEntity *)entity;

@end
