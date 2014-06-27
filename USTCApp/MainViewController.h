//
//  MainViewController.h
//  USTCApp
//
//  Created by ChenHao on 6/7/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <XHNewsFramework/XHNewsContainerViewController.h>

#import "RESideMenu.h"
#import "QCSlideSwitchView.h"
#import "newsListViewController.h"
#import "NoticeListViewController.h"


@interface MainViewController : UIViewController<QCSlideSwitchViewDelegate,ListViewControllerClickDelegate,NoticeListViewControllerClickDelegate>
{
    
}


/**
 *  加载4个页面和一个slideview
 */
@property (nonatomic, strong) QCSlideSwitchView        *slideSwitchView;


@property (nonatomic, strong) newsListViewController   *vc1;
@property (nonatomic, strong) NoticeListViewController *vc2;
@property (nonatomic, strong) NoticeListViewController *vc3;
@property (nonatomic, strong) NoticeListViewController *vc4;


@end
