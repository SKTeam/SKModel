//
//  SKCellFactory.m
//  2015-07-21 TableViewController
//
//  Created by 陈建辉 on 15/7/22.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import "SKCellFactory.h"
#import "SKTitleCell.h"
#import "SKMainCell.h"
#import "SKFooterCell.h"
@implementation SKCellFactory

+(UITableViewCell *)createCellWithName:(NSString *)cellName identifier:(NSString *)identifier{
    return [[NSClassFromString(cellName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
}

+(void)setDataForCell:(UITableViewCell *)cell withEntity:(SKCellDataEntity *)entity{
//    NSString *classString = [NSString stringWithFormat:@"%@",[cell class]];
    if ([cell class] == [SKTitleCell class]) {
        SKTitleCell *tempCell = (SKTitleCell*)cell;
        [self setDataForTiltleCell:tempCell withEntity:entity];
    }else if ([cell class] == [SKMainCell class]){
        SKMainCell *tempCell = (SKMainCell*)cell;
        [self setDataForMainCell:tempCell withEntity:entity];
    }else if ([cell class] == [SKFooterCell class]){
        SKFooterCell *tempCell = (SKFooterCell*)cell;
        [self setDataForFooterCell:tempCell withEntity:entity];
    }
}


+(void)setDelegate:(id)delegate forCell:(UITableViewCell *)cell{
    if ([cell class] == [SKTitleCell class]) {

    }else if ([cell class] == [SKMainCell class]){

    }else if ([cell class] == [SKFooterCell class]){
        SKFooterCell *tempCell = (SKFooterCell*)cell;
        tempCell.footerDelegate = delegate;
    }
}

/********************************************************************************************/
/********************         内部接口，为每个类型的cell设置数据         *************************/
/********************************************************************************************/
+(void)setDataForTiltleCell:(SKTitleCell *)cell withEntity:(SKCellDataEntity *)entity{
    
    cell.imgView.image = [UIImage imageNamed:entity.titleImgName];
    cell.nameStrLable.text = entity.titleName;
    cell.subLable.text = entity.titleSubName;
    cell.timeLabel.text = entity.titleTime;
}
+(void)setDataForMainCell:(SKMainCell *)cell withEntity:(SKCellDataEntity *)entity{
    
    cell.textView.text = entity.mainText;
}
+(void)setDataForFooterCell:(SKFooterCell *)cell withEntity:(SKCellDataEntity *)entity{
    
    cell.likeNum.text = [NSString stringWithFormat:@"%@",entity.footerLikeNum];
    cell.commentNum.text = [NSString stringWithFormat:@"%@",entity.footerCommentNum];;
}
@end
