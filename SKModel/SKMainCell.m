//
//  SKMainCell.m
//  diandi
//
//  Created by 陈建辉 on 15/6/23.
//  Copyright (c) 2015年 unipay. All rights reserved.
//

#import "SKMainCell.h"

@implementation SKMainCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellWidth = [UIScreen mainScreen].bounds.size.width - 20;
        self.layoutMargins = UIEdgeInsetsZero;
        [self.contentView addSubview:self.textView];
        
    }
    return self;
}



-(UITextView*)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(2, 3, cellWidth-4, 80)];
        _textView.editable = NO;
        _textView.text = @"SD卡家福克斯的飞机上开的房间卡速度就飞快的，割绒查斯特纪念盘文件和噶形成规模还是得，看好公司北京库骄傲的韩国花了近的话公司的，觉得是个哈时间个股家福克斯的飞机上开的房间卡速度就飞快的，割绒查斯特纪念盘文件和噶形成规模还是得，看好公司北京库骄傲的韩国花了近的话公司的，觉得是个哈时间个股家福克斯的飞机上开的房间卡速度就飞快的，割绒查斯特纪念盘文件和噶形成规模还是得，看好公司北京库骄傲的韩国花了近的话公司的，觉得是个哈时间个股家福克斯";
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor grayColor];
        _textView.scrollEnabled = NO;
        _textView.userInteractionEnabled = NO;
      
    }
    return _textView;
}
-(void)resetTextViewHeight:(CGFloat)height{
    self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, height);
}

-(void)resetTextViewHeight{
    [self resetTextViewHeightWithString:self.textView.text];
}

-(void)resetTextViewHeightWithString:(NSString *)str{
    [self resetTextViewHeight:[self heightTextOfString:str]];
}
-(CGFloat)heightTextOfString:(NSString*)str{
    CGSize constrainsize = CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX);
    CGRect size = [str boundingRectWithSize:constrainsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5]} context:nil];
    return size.size.height + 28;
}



@end
