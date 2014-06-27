//
//  newsListViewController.h
//  USTCApp
//
//  Created by ChenHao on 6/16/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "NewsData.h"
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"
#import "ASScroll.h"

@class DetailViewController;

@protocol ListViewControllerClickDelegate <NSObject>


- (void)ClickedWithController:(DetailViewController *)controller;


@end


@interface newsListViewController : UITableViewController<EGORefreshTableHeaderDelegate,MBProgressHUDDelegate>
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
//delegate 当在list中点击一行,则由主函数处理
//页面上方的广告滑动窗口
@property (strong, nonatomic) ASScroll *asscroll;
@property (nonatomic, strong) id<ListViewControllerClickDelegate> delegate;
@property  int catalog;



- (void)viewDidCurrentView;


- (void)loadTutorials :(BOOL)noRefresh;

//清空
- (void)clear;

//下拉刷新
- (void)refresh;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
