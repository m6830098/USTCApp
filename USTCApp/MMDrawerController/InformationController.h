//
//  InformationController.h
//  USTCApp
//
//  Created by ChenHao on 6/26/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//  这个是表示加载信息平台登录界面之后的 新闻列表下面.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"
#import "NewsData.h"
#import "TFHpple.h"

@protocol informationProtocal;


@interface InformationController : UITableViewController<EGORefreshTableHeaderDelegate,MBProgressHUDDelegate>
{
    NSMutableArray *_objects;
    
    //判断是否正在加载
    BOOL isLoading;
    
    
    //判断是否已经全部加载完毕
    BOOL isLoadOver;
    
    //记录加载的新闻的总个数
    int allCount;
    
 
    
    
    //下拉刷新
    EGORefreshTableHeaderView *_refreshHeadView;
    
    BOOL _reloading;
}

@property (strong, nonatomic) UITableView *tableview;

@property (strong, nonatomic) id<informationProtocal> delegate;

//用来标记该去加载哪个部门的信息
@property  int catalog;



//加载新闻客户端

- (void)loadNews:(BOOL)noRefresh;

//清空
- (void)clear;

//下拉刷新
- (void)refresh;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end


@protocol informationProtocal <NSObject>

- (void)returnToLastView;


@end