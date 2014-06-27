//
//  MainController.m
//  USTCApp
//
//  Created by ChenHao on 6/5/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//


#define UIColorFromRGB(rgbValue)                                       \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:1.0]




#import "MainController.h"
#import <XHNewsFramework/XHMenu.h>
#import <XHNewsFramework/XHNewsDetail.h>
#import <XHNewsFramework/XHScrollBannerView.h>


#import "BannerView.h"
#import "myNewsCell.h"
#import "MainViewDataManage.h"

@interface MainController ()<XHContentViewRefreshingDelegate>


//主界面上的滑动图片
@property (nonatomic, strong) NSMutableArray * bannerViews;
@property (nonatomic, strong) XHScrollBannerView *scrollBannerView;


@end

@implementation MainController


- (void)myInitNavigationBar
{
    NSLog(@"myInitNavigationBar");
    UIColor  *navColor = [UIColor colorWithRed:16 /255.0 green:142 /255.0 blue:82/255.0 alpha:1.0];
    [[UINavigationBar appearance] setBarTintColor:navColor];
    NSShadow *shadow            = [[NSShadow alloc] init];
    shadow.shadowColor          = shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset         = CGSizeMake(0, 1);
    
}

#pragma mark
#pragma mark - action method

- (void)receiveScrollViewPanGestureRecognizerHandle:(UIPanGestureRecognizer *)scrollViewPanGestureRecognizer
{
    NSLog(@"receiveScrollViewPanGestureRecognizerHandle");
    [self.sideMenuViewController __panGestureRecognized:scrollViewPanGestureRecognizer];
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
//    [self myInitNavigationBar];
    // Do any additional setup after loading the view.
    
    self.title = @"软院助手";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_left_menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"right-arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];

    [self myInitNavigationBar];
    [self loadNetWorkDataSource:NULL];
    
    self.scrollBannerView = [[XHScrollBannerView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200) animationDuration:3.0f];
    
    
    __weak typeof(self) weakSelf = self;
    self.scrollBannerView.totalPagesCount = ^NSUInteger(void){
        return weakSelf.bannerViews.count;
    };
    self.scrollBannerView.fetchContentViewAtIndex = ^UIView *(NSUInteger pageIndex){
        return weakSelf.bannerViews[pageIndex];
    };
    self.scrollBannerView.fetchFocusTitle = ^NSString *(NSUInteger pageIndex) {
        if (pageIndex == 0) {
            return @"   软院美景";
        } else if (pageIndex == 1) {
            return @"   软院美景";
        } else if (pageIndex == 2) {
            return @"   软院美景";
        } else {
            return @"   软院美景";
        }
    };
    _scrollBannerView.didSelectCompled = ^(NSUInteger selectIndex) {
        NSLog(@"selectIndex : %d", selectIndex);
    };


    
}

- (NSMutableArray* )bannerViews
{
    NSLog(@"bannerViews");
    if (!_bannerViews) {
        NSLog(@"bannerViews2");
        _bannerViews = [[NSMutableArray alloc]init];
        assert(_bannerViews != nil);
        
        for (int i = 0; i < 6; i ++) {
            BannerView *view = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollBannerView.bounds), CGRectGetHeight(self.scrollBannerView.bounds))];
            
            assert(view != nil);
            
            [_bannerViews addObject:view];
            
        }

//        
//        [_bannerViews addObject:[[BannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollBannerView.bounds), CGRectGetHeight(self.scrollBannerView.bounds))]];
//        [_bannerViews addObject:[[BannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollBannerView.bounds), CGRectGetHeight(self.scrollBannerView.bounds))]];
//        [_bannerViews addObject:[[BannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollBannerView.bounds), CGRectGetHeight(self.scrollBannerView.bounds))]];
//        [_bannerViews addObject:[[BannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollBannerView.bounds), CGRectGetHeight(self.scrollBannerView.bounds))]];
//        [_bannerViews addObject:[[BannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollBannerView.bounds), CGRectGetHeight(self.scrollBannerView.bounds))]];
//        [_bannerViews addObject:[[BannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollBannerView.bounds), CGRectGetHeight(self.scrollBannerView.bounds))]];
    }
    return _bannerViews;
}
//
//- (XHScrollBannerView *)scrollBannerView
//{
//    NSLog(@"scrollBannerView");
//    if (!_scrollBannerView) {
//        __weak typeof(self) weakSelf = self;
//        _scrollBannerView = [[XHScrollBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200) animationDuration:3.0f];
//        self.scrollBannerView.totalPagesCount = ^NSUInteger(void){
//            return weakSelf.bannerViews.count;
//        };
//        self.scrollBannerView.fetchContentViewAtIndex = ^UIView *(NSUInteger pageIndex){
//            return weakSelf.bannerViews[pageIndex];
//        };
//        self.scrollBannerView.fetchFocusTitle = ^NSString *(NSUInteger pageIndex) {
//            if (pageIndex == 0) {
//                return @"   软院美景";
//            } else if (pageIndex == 1) {
//                return @"   软院美景";
//            } else if (pageIndex == 2) {
//                return @"   软院美景";
//            } else {
//                return @"   软院美景";
//            }
//        };
//        _scrollBannerView.didSelectCompled = ^(NSUInteger selectIndex) {
//            NSLog(@"selectIndex : %d", selectIndex);
//        };
//    }
//    return _scrollBannerView;
//}


#pragma mark
#pragma mark - life cycle

- (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadNetWorkDataSource:(void (^)())compled {
    NSLog(@"loadNetWorkDataSource");
    
     __weak typeof(self) weakSelf = self;
    [[MainViewDataManage shareMainViewDataManage]loadNetDataSourcecompledBlock:^(NSMutableArray *datas) {
        
        NSArray *titles =  [NSArray arrayWithObjects:@"最新新闻",@"通知公告",@"招生就业",@"校园招聘", nil];
        
        
        NSMutableArray *items = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i ++) {
            XHMenu *item = [[XHMenu alloc] init];
            
            
            NSString *title = titles[i];
            item.title = title;
            item.titleNormalColor = [UIColor colorWithWhite:0.141 alpha:1.000];
            item.titleFont = [UIFont boldSystemFontOfSize:16];
            
            item.dataSources = [NSMutableArray arrayWithArray:datas];
            assert(item != nil);
            [items addObject:item];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.items = items;
            [weakSelf reloadDataSource];
            if (compled) {
                compled();
            }
        });
        
   
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    NSLog(@"MainViewController will appear");
}
- (id)init
{
    self = [super init];
    if (self) {
        self.isShowTopScrollToolBar = YES;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"MainViewController will disappear");
}
- (NSInteger)numberOfContentViews {
    NSLog(@"numberOfContentViews");
	int numberOfPanels = [self.items count];
	return numberOfPanels;
}

#pragma mark - contentView refreshControl delegate

- (void)pullDownRefreshingAction:(XHContentView *)contentView {
    NSLog(@"pullDownRefreshingAction");
    [self loadNetWorkDataSource:^{
        [contentView endPullDownRefreshing];
    }];
}

- (void)pullUpRefreshingAction:(XHContentView *)contentView {
    NSLog(@"pullUpRefreshingAction");
    [contentView performSelector:@selector(endPullUpRefreshing) withObject:nil afterDelay:3];
}
- (NSInteger)contentView:(XHContentView *)contentView numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    
    NSLog(@"contentView  numberOfRowsInPage");
    XHMenu *item = [self.items objectAtIndex:page];
	return [item.dataSources count];
}
- (UITableViewCell *)contentView:(XHContentView *)contentView cellForRowAtIndexPath:(XHPageIndexPath *)indexPath {
    
    
    NSLog(@"ontentView:(XHContentView *)contentView cellForRowAtIndexPath:(XHPageIndexPath *)indexPath");
	static NSString *cellIdentifier = @"cellIdentifier";
	myNewsCell *cell = [contentView.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[myNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    XHMenu *menu = [self.items lastObject];
    NewsData *newsModel = [menu.dataSources objectAtIndex:indexPath.row];
    
    cell.newsModel = newsModel;
	return cell;
}

- (void)contentView:(XHContentView *)contentView didSelectRowAtIndexPath:(XHPageIndexPath *)indexPath {
	NSLog(@"row : %d section : %d  page : %d", indexPath.row, indexPath.section, indexPath.page);
    [super contentView:contentView didSelectRowAtIndexPath:indexPath];
}
- (XHContentView *)contentViewForPage:(NSInteger)page {
    
    NSLog(@"(XHContentView *)contentViewForPage:(NSInteger)page {");
	static NSString *identifier = @"XHContentView";
	XHContentView *contentView = (XHContentView *)[self dequeueReusablePageWithIdentifier:identifier];
	if (contentView == nil) {
		contentView = [[XHContentView alloc] initWithIdentifier:identifier];
        contentView.pullDownRefreshed = YES;
        contentView.refreshControlDelegate = self;
	}
    if (!page)
        contentView.tableView.tableHeaderView = self.scrollBannerView;
    else
        contentView.tableView.tableHeaderView = nil;
	return contentView;
}
- (CGFloat)contentView:(XHContentView *)contentView heightForRowAtIndexPath:(XHPageIndexPath *)indexPath{
    return 80;
}
@end
