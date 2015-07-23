//
//  SKFooterCell.m
//  diandi
//
//  Created by 陈建辉 on 15/6/23.
//  Copyright (c) 2015年 unipay. All rights reserved.
//


#import "SKFooterCell.h"
#define kPadding 0
@implementation SKFooterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellWidth = [UIScreen mainScreen].bounds.size.width - 20;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layoutMargins = UIEdgeInsetsZero;
        [self.contentView addSubview:self.backView];
    }
    return self;
}

/*
 *@property (nonatomic,retain) UIButton *likeBtn;
 *@property (nonatomic,retain) UIButton *commentBtn;
 *@property (nonatomic,retain) UILabel *likeNum;
 *@property (nonatomic,retain) UILabel *commentNum;
 */

-(UIButton*)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kPadding, 5, 20, 20)];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"heart.png"] forState:UIControlStateNormal];
        _likeBtn.tag = 1;
        [_likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}
-(UIButton*)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kPadding+50, 5, 20, 20)];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        _commentBtn.tag = 2;
        [_commentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}
-(UILabel*)likeNum{
    if (_likeNum == nil) {
        _likeNum = [[UILabel alloc] initWithFrame:CGRectMake(kPadding+20+5, 5, 50, 20)];
        _likeNum.font = [UIFont systemFontOfSize:12];
        _likeNum.textColor = [UIColor blackColor];
        _likeNum.textAlignment = NSTextAlignmentLeft;
        _likeNum.text = @"5";
    }
    return _likeNum;
}
-(UILabel*)commentNum{
    if (_commentNum == nil) {
        _commentNum = [[UILabel alloc] initWithFrame:CGRectMake(kPadding+50+20+5, 5, 70, 20)];
        _commentNum.font = [UIFont systemFontOfSize:12];
        _commentNum.textColor = [UIColor blackColor];
        _commentNum.textAlignment = NSTextAlignmentLeft;
        _commentNum.text = @"21";
    }
    return _commentNum;
}

-(UIView*)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(cellWidth - 100, 0, 100, 44)];
        [_backView addSubview:self.likeBtn];
        [_backView addSubview:self.likeNum];
        [_backView addSubview:self.commentBtn];
        [_backView addSubview:self.commentNum];
    }
    return _backView;
}
//----
-(void)btnClick:(UIButton*)btn{
    if (btn.tag==1) {
        if (_footerDelegate && [_footerDelegate respondsToSelector:@selector(SKFooterCellLikeBtnClick:)]) {
            [_footerDelegate SKFooterCellLikeBtnClick:btn];
        }
    }else if(btn.tag == 2){
        if (_footerDelegate && [_footerDelegate respondsToSelector:@selector(SKFooterCellCommentBtnClick:)]) {
            [_footerDelegate SKFooterCellCommentBtnClick:btn];
        }
    }
}
-(void)hideLoveBtn{
    self.commentBtn.frame = CGRectMake(kPadding+125, 5, 20, 20);
    [self.likeBtn removeFromSuperview];
    [self.likeNum removeFromSuperview];
    [self.commentNum removeFromSuperview];
    
}

@end

