//
//  SKFooterCell.h
//  diandi
//
//  Created by 陈建辉 on 15/6/23.
//  Copyright (c) 2015年 unipay. All rights reserved.
//

#import <UIKit/UIKit.h>

/*****************************************************************
 *footer delegate
 */
@protocol SKFooterCellDelegate<NSObject>
@optional
-(void)SKFooterCellLikeBtnClick:(UIButton*)btn;
-(void)SKFooterCellCommentBtnClick:(UIButton *)btn;
@end



@interface SKFooterCell : UITableViewCell {
    CGFloat cellWidth;//当cell的宽度没有屏幕宽时记录cell宽度
}

@property (nonatomic,assign) id<SKFooterCellDelegate> footerDelegate;
@property (nonatomic,retain) UIButton *likeBtn;
@property (nonatomic,retain) UIButton *commentBtn;
@property (nonatomic,retain) UILabel *likeNum;
@property (nonatomic,retain) UILabel *commentNum;
@property (nonatomic,retain) UIView *backView;

-(void)hideLoveBtn;

@end
