//
//  NoticeListViewController.m
//  USTCApp
//
//  Created by ChenHao on 6/16/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "NoticeListViewController.h"
#import "HTMLParser.h"
#import "Tool.h"
#import "NoticeCell.h"
#import "DataSingleton.h"
#import "DetailViewController.h"


static NSString *identifier = @"listIdentifier";

@interface NoticeListViewController ()
{
    //用来同步修改 几个bool类型的值
    dispatch_queue_t _serialQueue;

}
@end

@implementation NoticeListViewController

@synthesize catalog;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark
#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //新闻的数目开始的时候为0
    allCount = 0;
    //后台串行队列
    _serialQueue = dispatch_queue_create("com.example.name", DISPATCH_QUEUE_SERIAL);
    
    if (_refreshHeadView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc]initWithFrame:
                                           CGRectMake(0.0f, -320.0f, self.view.frame.size.width, 320.0f)];
        
        view.delegate = self;
        [self.view addSubview:view];
        _refreshHeadView = view;
    }
    [_refreshHeadView refreshLastUpdatedDate];
    //
    //初始为20个
    _objects = [[NSMutableArray alloc]initWithCapacity:20];
    
    
    //去加载新闻,不是刷新的
    [self loadTutorials:YES];
    self.tableView.backgroundColor = [Tool getBackgroundColor];
    
    //适配iOS7uinavigationbar遮挡tableView的问题
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clear
{
    allCount = 0;
    [_objects removeAllObjects];
    isLoadOver = NO;
}

- (void)viewDidUnload
{
    self.tableView = nil;
    _refreshHeadView = nil;
    [_objects removeAllObjects];
    _objects = nil;
    [super viewDidUnload];
}

- (void)loadTutorials:(BOOL)noRefresh
{
    NSAssert(catalog != 0, @"Catlog is 0,reset the value ");
    
    //如果发现正在加载或已经加载完毕,就不再加载了
    if (isLoading || isLoadOver) {
        return;
    }
    //用noRefresh来表示是否整个列表都需要重新加载
    //noRefresh为yes的时候,不需要刷新,为no则需要刷新，allcount设置为0
    //下拉的时候需要重新刷新内容,上拉的时候不需要刷新内容
    
    if (!noRefresh) {
        allCount = 0;
    }
    NSString *urlNews = @"";
    //20个信息一页
    int  pageIndex = allCount / 20 + 1;
    //加载中科大软件学院的最近新闻列表
    switch (catalog) {
        case 1:
            urlNews = [NSString stringWithFormat:@"http://sse.ustc.edu.cn/pages/tonz.php?pageno=%d&classid=",pageIndex ];
            break;
        case 2:
            urlNews = [NSString stringWithFormat:@"http://www.sse.ustc.edu.cn/pages/tonz.php?pageno=%d&classid=3",pageIndex ];
            break;
        case 3:
            urlNews = [NSString stringWithFormat:@"http://www.sse.ustc.edu.cn/pages/tonz.php?pageno=%d&classid=4",pageIndex];
            break;
        default:
            break;
    }

    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        isLoading = YES;
        NSStringEncoding gbEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSURL *tutorialsUrl         = [NSURL URLWithString:urlNews];
        NSData *tutorialsHtmData    = [NSData dataWithContentsOfURL:tutorialsUrl ];
        NSString *val               = [[NSString alloc]initWithData:tutorialsHtmData encoding:gbEncoding];
        NSString *utf8HtmlStr = [val stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-type\" content=\"text/html; charset=gb2312\" />"
                                                               withString:@"<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />"];
        
        tutorialsHtmData = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
        
        
        TFHpple *tutorialParser = [TFHpple hppleWithHTMLData:tutorialsHtmData];
        //解析路径
        NSString *xPathQueryString = @"//div[@class='body']/div[@class='main']/div[@class='column']/ul[@class='list1']/li/a";
        //
        NSArray *tutorialsNodes = [tutorialParser searchWithXPathQuery:xPathQueryString];
        NSMutableArray *newTutorials = [[NSMutableArray alloc]initWithCapacity:0];
        
        //NSMutableArray  *urlAddressArray = [[NSMutableArray alloc]init];
        
        for (TFHppleElement *element in tutorialsNodes) {
            
            NewsData *tutorial  = [[NewsData alloc]init];
            tutorial.title      = [element content];
            
            
            if ([tutorial.title isEqualToString:lastNoticeTitle]) {
                // 如果最后一个题目相同,则表示加载到最后
                isLoadOver = YES;
            }
            if ([tutorial.title isEqualToString:lastJobTitle]) {
                // 如果最后一个题目相同,则表示加载到最后
                isLoadOver = YES;
            }
            if ([tutorial.title isEqualToString:lastRecruitTitle]) {
                // 如果最后一个题目相同,则表示加载到最后
                isLoadOver = YES;
            }
            tutorial.urlAddress = [element objectForKey:@"href"];
            tutorial.urlAddress = [NSString stringWithFormat:@"http://www.sse.ustc.edu.cn/pages/%@",tutorial.urlAddress];
            
            tutorial.date       = [[element firstChild]content];
            tutorial.thumb      = @"";
            tutorial.contentString = nil;
            
            [newTutorials addObject:tutorial];
        }
        if (!noRefresh) {
            [self clear];
        }
        allCount += tutorialsNodes.count;
        [_objects addObjectsFromArray:newTutorials];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
        NewsData *obc;
        
        int beginNum = _objects.count - tutorialsNodes.count;
        
        for (int i = beginNum; i <= _objects.count - 1; i++) {
            obc = _objects[i];
            
            assert(obc.urlAddress.length != 0);
            
            NSStringEncoding gbEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSURL *url = [NSURL URLWithString:obc.urlAddress];
            NSData *daDetial = [NSData dataWithContentsOfURL:url];
            NSString *res = [[NSString alloc]initWithData:daDetial encoding:gbEncoding];
            
            NSString *searchStartString=@"<div class=\"content\">";
            NSString *searchEndString=@"<!-- @content -->";
            
            NSInteger Start = [res rangeOfString:searchStartString].location ;
            NSInteger End = [res rangeOfString:searchEndString].location;
            
            NSInteger num = res.length;
            
            
//            assert( Start !=NSNotFound && End != NSNotFound  && Start < num && End < num);
            
            
            NSRange rng = NSMakeRange(Start, End - Start);
            //NSLog(@"start=%i,end=%i",Start,End - Start);
            NSString *cuthtml =[res substringWithRange:rng];
            
            
            
            cuthtml = [Tool buildHTMLString:cuthtml];
            obc.contentString = cuthtml;
        }
        
        

        [self doneLoadingTableViewData];
        
        //如果是第一页则缓存到本地,以便没有网络也方便加载
        if (_objects.count <= 20) {
            //缓存到本地
            //[Tool saveCache:1 andNSArray:_objects ];
            
        }
        
        isLoading = NO;


    });
    

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    //如果没有加载完,则显示加载更多那一栏,如果加载完毕了就不在显示
    if (isLoadOver) {
        return  _objects.count == 0 ? 1: _objects.count + 1;
    }
    else
        return _objects.count + 1;
    //return _objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_objects count] > 0) {
        if ([indexPath row] < [_objects count]) {
            int row = indexPath.row;
            NoticeCell *cell = (NoticeCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[NoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            //assert(self.data.count != 0);
            
            NewsData *news            = [_objects objectAtIndex:row];
            
            cell.newsTitle.text       = news.title;
            cell.newsPublishDate.text = news.date;
            NSString *str = @"http://www.sse.ustc.edu.cn/data/uploadfile/2014/20140421022522671.jpg";
//            if (news.thumb.length != 0) {
//                [cell.newsThumb setImageWithURL:[NSURL URLWithString:news.thumb] placeholderImage:[UIImage imageNamed:@"cell_photo_default_small.png"]];
//                [cell setFlickPhoto:news.thumb];
//            }
//            else
//            {
//                                [cell.newsThumb setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"cell_photo_default_small.png"]];
//            }
            return cell;
        }
        else
        {
            //isLoading 如果为true 显示正在加载,如果为false.加载另外20个新闻
            return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:isLoadOver andLoadOverString:@"已经加载全部新闻" andLoadingString:(isLoading ? loadingTip : loadNext20Tip) andIsLoading:isLoading];
        }
    }
    else
    {
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:isLoadOver andLoadOverString:@"已经加载全部新闻" andLoadingString:(isLoading ? loadingTip : loadNext20Tip) andIsLoading:isLoading];
    }
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NewsData *news = [_objects objectAtIndex:row];
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.title = @"通知公告";
    
    //NSString *name = NSStringFromClass(self.navigationController);
    
    
    [self.delegate NoticeClickedWithController:detail];
    [detail LoadHtmlString:news.contentString];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 77;
}

#pragma
#pragma 下拉刷新  EGORefresh delegate
- (void)reloadTableViewDataSource
{
    //[self loadTutorials:YES];
    //表示正在loading
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeadView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeadView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeadView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self refresh];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}
- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}


//集成了上拉刷新的功能.
- (void)egoRefreshTableHeaderDidTriggerToBottom
{
    if (!isLoading) {
        [self loadTutorials:YES];
    }
}
- (void)refresh
{
    //    if ([Config Instance].isNetworkRunning) {
    isLoadOver = NO;
    [self loadTutorials:NO];
    //    }
    //    //无网络连接则读取缓存
    //    else {
    //        NSString *value = [Tool getCache:5 andID:self.catalog];
    //        if (value)
    //        {
    //            NSMutableArray *newNews = [Tool readStrNewsArray:value andOld:news];
    //            if (newNews == nil) {
    //                [self.tableNews reloadData];
    //            }
    //            else if(newNews.count <= 0){
    //                [self.tableNews reloadData];
    //                isLoadOver = YES;
    //            }
    //            else if(newNews.count < 20){
    //                isLoadOver = YES;
    //            }
    //            [news addObjectsFromArray:newNews];
    //            [self.tableNews reloadData];
    //            [self doneLoadingTableViewData];
    //        }
    //    }
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
- (void)viewDidCurrentView
{
    NSLog(@"加载为当前视图 = %@",self.title);
    
}
@end
