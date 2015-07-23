//
//  SKRefreshTable.m
//  2015-06-24 RefreshTableViewComtroller
//
//  Created by 陈建辉 on 15/6/24.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import "SKRefreshTable.h"

@implementation SKRefreshTable
-(instancetype)init{
    self = [super init];
    if (self) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsZero;
        self.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
        self.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsZero;
        self.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
        self.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsZero;
        self.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
        self.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
    }
    return self;
}
#pragma mark -
#pragma mark pull delegate
-(void)pullDown{
    if (self.SKRefreshDelegate && [self.SKRefreshDelegate respondsToSelector:@selector(SKRefreshPullDown)]) {
        [self.SKRefreshDelegate SKRefreshPullDown];
    }
}
-(void)pullUp{
    if (self.SKRefreshDelegate && [self.SKRefreshDelegate respondsToSelector:@selector(SKRefreshPullUp)]) {
        [self.SKRefreshDelegate SKRefreshPullUp];
    }
}
@end
