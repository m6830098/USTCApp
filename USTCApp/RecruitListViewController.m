//
//  RecruitListViewController.m
//  USTCApp
//
//  Created by ChenHao on 6/16/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "RecruitListViewController.h"
#import "HTMLParser.h"
#import "Tool.h"
#import "NoticeCell.h"
#import "DataSingleton.h"
#import "Tool.h"
#import "DetailViewController.h"


static NSString *identifier = @"listIdentifier";

@interface RecruitListViewController ()
{
    //用来同步修改 几个bool类型的值
    dispatch_queue_t _serialQueue;
}
@end

@implementation RecruitListViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
