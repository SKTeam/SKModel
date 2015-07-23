//
//  SKMainCell.h
//  diandi
//
//  Created by 陈建辉 on 15/6/23.
//  Copyright (c) 2015年 unipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKMainCell : UITableViewCell{
    CGFloat cellWidth;//当cell的宽度没有屏幕宽时记录cell宽度
}


@property (nonatomic,retain) UITextView *textView;
@property (nonatomic,retain) UIImageView *imgView;

-(void)resetTextViewHeight;
-(void)resetTextViewHeight:(CGFloat)height;
-(void)resetTextViewHeightWithString:(NSString*)str;

@end
