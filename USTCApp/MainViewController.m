//
//  MainViewController.m
//  USTCApp
//
//  Created by ChenHao on 6/7/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewDataManage.h"
#import "TFHpple.h"
#import "UITableViewController+ShowName.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//#define mainViewColor [UIColor colorWithRed:16 /255.0 green:142 /255.0 blue:82/255.0 alpha:1.0]

@interface MainViewController ()

@end

@implementation MainViewController


@synthesize vc1,vc2;


//设置navgationcontrollerbar
- (void)myInitNavigationBar
{
    NSLog(@"myInitNavigationBar");
    // 设置navgationcontrollerbar的颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                
                                [UIColor whiteColor],
                                UITextAttributeTextColor,nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = @"科软助手";
    
    
    //设置Navgationcontrollerbar的外观
    self.navigationItem.leftBarButtonItem.customView.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile"] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];

    //改变导航栏的背景颜色和所有的字体和图片的颜色
    
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self myInitNavigationBar];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:self.view.frame];
    
    
    self.slideSwitchView.backgroundColor      = [UIColor clearColor];
    self.slideSwitchView.delegate             = self;
    [self.view addSubview:self.slideSwitchView];
    self.slideSwitchView.tabItemNormalColor   = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    //self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.tabItemSelectedColor = mainColor;
    self.slideSwitchView.shadowImage          = [[UIImage imageNamed:@"blue_line"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];

    
    self.vc1 = [[newsListViewController alloc] init];
    self.vc1.delegate = self;
    self.vc1.title = @"最新新闻";
    ASScroll *asScroll = [[ASScroll alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,200)];
    
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray * imagesArray = [[NSMutableArray alloc]init];
    for (int imageCount = 1; imageCount <= 4; imageCount++)
    {
        NSString *str = [NSString stringWithFormat:@"%d.jpg",imageCount];
        [imagesArray addObject:str];
    }
    [asScroll setArrOfImages:imagesArray];
    
    
    self.vc1.asscroll = asScroll;
    
    
    self.vc2 = [[NoticeListViewController alloc] init];
    self.vc2.title = @"通知公告";
    self.vc2.delegate = self;
    self.vc2.catalog = 1;
    
    
    self.vc3 = [[NoticeListViewController alloc] init];
    self.vc3.title = @"招生信息";
    self.vc3.delegate = self;
    self.vc3.catalog = 2;

    self.vc4 = [[NoticeListViewController alloc] init];
    self.vc4.title = @"就业信息";
    self.vc4.delegate = self;
    self.vc4.catalog = 3;

    [self.slideSwitchView buildUI];
    
    
    //[self loadNetWorkDataSource:NULL];

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    NSLog(@"DEMOFirstViewController will appear");
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"DEMOFirstViewController will disappear");
}

#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return 4;
}



- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{ 
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    }
    else if (number == 2) {
        return self.vc3;
    }
        else if (number == 3) {
        return self.vc4;
    }
    else
        return nil;
}


- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    UITableViewController *vc = nil;
    if (number == 0) {
        vc = (UITableViewController *)self.vc1;
    } else if (number == 1) {
        vc = self.vc2;
    }
    else if (number == 2) {
        vc = self.vc3;
    } else if (number == 3) {
        vc = self.vc4;
   }
    [vc viewDidCurrentView];
}


    

- (void)ClickedWithController:(DetailViewController *)controller
{
    [self.navigationController pushViewController:(UIViewController *)controller animated:YES];
}
- (void)NoticeClickedWithController:(DetailViewController *)controller
{
    [self.navigationController pushViewController:(UIViewController *)controller animated:YES];
}

@end

