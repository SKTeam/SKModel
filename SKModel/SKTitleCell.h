//
//  SKTitleCell.h
//  diandi
//
//  Created by 陈建辉 on 15/6/23.
//  Copyright (c) 2015年 unipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTitleCell : UITableViewCell{
    CGFloat cellWidth;//当cell的宽度没有屏幕宽时记录cell宽度
}

@property (nonatomic,retain) UIImageView *imgView;
@property (nonatomic,retain) UILabel *nameStrLable;
@property (nonatomic,retain) UILabel *timeLabel;
@property (nonatomic,retain) UILabel *subLable;
@end
