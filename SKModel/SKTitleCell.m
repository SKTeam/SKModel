//
//  SKTitleCell.m
//  diandi
//
//  Created by 陈建辉 on 15/6/23.
//  Copyright (c) 2015年 unipay. All rights reserved.
//

#import "SKTitleCell.h"
#define kLeftPadding 5
#define kTopPaddin 5
#define kImgSize 35
@implementation SKTitleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellWidth = [UIScreen mainScreen].bounds.size.width - 20;
        self.userInteractionEnabled = NO;
        self.layoutMargins = UIEdgeInsetsZero;
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.nameStrLable];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.subLable];
        
    }
    return self;
}


/*
 *实现cell各元素的get方法
 *UIImageView   imgView
 *UILabel       nameStrLable
 *UILabel       timeLabel
 *UILabel       subLable
 */
-(UIImageView*)imgView{
    if (_imgView == nil) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftPadding, kTopPaddin, kImgSize, kImgSize)];
        _imgView.image = [UIImage imageNamed:@"head.jpg"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}
-(UILabel*)nameStrLable{
    if (_nameStrLable == nil) {
        
        _nameStrLable = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + 2*kLeftPadding, kTopPaddin, 90, kImgSize/2)];
        _nameStrLable.textAlignment = NSTextAlignmentLeft;
        _nameStrLable.textColor = [UIColor blackColor];
        _nameStrLable.text = @"这是名字";
        _nameStrLable.font = [UIFont systemFontOfSize:16];
    }
    return _nameStrLable;
}
-(UILabel*)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth - 205, kTopPaddin+2, 200, kImgSize/2)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.text = @"2015-06-23 14:05";
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}
-(UILabel*)subLable{
    if (_subLable == nil) {
        _subLable = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width + 2*kLeftPadding, kTopPaddin+3+self.nameStrLable.frame.size.height, 280, kImgSize/2)];
        _subLable.textAlignment = NSTextAlignmentLeft;
        _subLable.textColor = [UIColor lightGrayColor];
        _subLable.text = @"SUB TITLE LABEL";
        _subLable.font = [UIFont systemFontOfSize:10];
    }
    return _subLable;
}
@end

