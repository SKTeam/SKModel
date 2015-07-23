//
//  SKRefreshTableViewController.m
//  2015-07-21 TableViewController
//
//  Created by 陈建辉 on 15/7/22.
//  Copyright (c) 2015年 Sakura. All rights reserved.
//

#import "SKRefreshTableViewController.h"

#import <MagicalRecord.h>

#import "SKTitleCell.h"
#import "SKMainCell.h"
#import "SKFooterCell.h"
#import "SKCellDataEntity.h"
#import "SKCellFactory.h"

@interface SKRefreshTableViewController ()<UITableViewDataSource,UITableViewDelegate,SKRefreshTableDelegate,SKFooterCellDelegate>

@end

@implementation SKRefreshTableViewController

@synthesize table = table;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTable];
}

- (void)setupTable{
    table = [[SKRefreshTable alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    table.SKRefreshDelegate = self;
    [self.view addSubview:table];
    cellArray = @[@"SKTitleCell",@"SKMainCell",@"SKFooterCell"];
    for (NSString *cellName in cellArray) {
        [table registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
    }

    self.view.backgroundColor = table.backgroundColor;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellArray.count;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }
    if (indexPath.row == 1) {
        return 80;
    }
    return 30;
}

//在创建cell和给cell赋值时，其实采用的就是策略设计模式
//在此设计模式下只需要一个create函数和一个setData函数就可以为所有的cell创建和赋值
//让cell于table独立开，cell的变更不会影响到table
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellName = cellArray[indexPath.row];
  
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (nil == cell) {
        cell = [SKCellFactory createCellWithName:cellName identifier:cellName];
    }
    
    [SKCellFactory setDelegate:self forCell:cell];
    
    SKCellDataEntity *entity = [SKCellDataEntity MR_createEntity];
    entity.titleImgName = @"head.jpg";
    entity.titleName = @"NAME";
    entity.titleSubName = @"SUB NAME";
    entity.titleTime = @"2015-07-23 10:08";
    entity.mainText = @"This is the main text ...";
    entity.mainImgUrl = @"";
    entity.footerLikeNum = @10;
    entity.footerCommentNum = @2;

    [SKCellFactory setDataForCell:cell withEntity:entity];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -
#pragma mark SKRefreshTable delegate
-(void)SKRefreshPullDown{
    NSLog(@"pull down");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [table.header endRefreshing];
    });
}
-(void)SKRefreshPullUp{
    NSLog(@"pull up");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [table.footer endRefreshing];
    });
}
#pragma mark -
#pragma mark SKFooterCell delegate
-(void)SKFooterCellCommentBtnClick:(UIButton *)btn{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT" message:@"CHANGE TO COMMENT ..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)SKFooterCellLikeBtnClick:(UIButton *)btn{
    [btn setImage:[UIImage imageNamed:@"heart_red.png"] forState:UIControlStateNormal];
}
@end
