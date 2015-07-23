//
//  SKRefreshTable.h
//  2015-06-24 RefreshTableViewComtroller
//
//  Created by 陈建辉 on 15/6/24.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@protocol SKRefreshTableDelegate<NSObject>
@optional
-(void)SKRefreshPullDown;
-(void)SKRefreshPullUp;
@end
@interface SKRefreshTable : UITableView
@property (nonatomic,assign) id<SKRefreshTableDelegate> SKRefreshDelegate;
@end
