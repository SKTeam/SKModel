//
//  SKRefreshTableViewController.h
//  2015-07-21 TableViewController
//
//  Created by 陈建辉 on 15/7/22.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKRefreshTable.h"
@interface SKRefreshTableViewController : UIViewController{
    SKRefreshTable *table;
    NSArray *dataArray;
    NSArray *cellArray;
}
@property (nonatomic,strong) SKRefreshTable *table;
@end
