//
//  SoftWareInformationController.m
//  USTCApp
//
//  Created by ChenHao on 6/5/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#define ustcInformationUrl = @"http://sse.ustc.edu.cn/pages/spage.php?type=0&pageid=11"

#import "SoftWareInformationController.h"
#import "Tool.h"


@interface SoftWareInformationController ()

@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) UIWebView               *webView;


@end

@implementation SoftWareInformationController

@synthesize webView,indicator;

@synthesize catlog;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view;
	self.title = @"学院信息";
    self.view.backgroundColor = [UIColor whiteColor];
    //改变导航栏的背景颜色和所有的字体和图片的颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                
                                [UIColor whiteColor],
                                UITextAttributeTextColor,nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"profile"] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    
    
    [self.view addSubview:({
        UIWebView *myWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        myWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        myWebView.scrollView.showsHorizontalScrollIndicator = NO;
        myWebView.detectsPhoneNumbers = YES;
        myWebView.delegate = self;
        
        self.webView = myWebView;
        self.webView;
        
    })];
    
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.frame = CGRectMake(150, 200, 50, 50);
    self.indicator.backgroundColor = [UIColor clearColor];
    self.indicator.color = [UIColor redColor];
    [self.indicator sizeToFit];
    [self.view addSubview:self.indicator];
    
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    [self loadUrl:catlog];
}
- (void)loadUrl:(NSInteger)catlog
{
    NSString *content ;
    switch (catlog) {
        case 1:
            content = xueyuanxinxi;
            break;
        case 2:
            content = jigoushezhi;
            break;
        case 3:
            content = zhuanyejieshao;
            break;
        case 4:
            content = zhaoshengwenda;
            break;
        default:
            break;
    }
    
    [self.webView loadHTMLString:content baseURL:nil];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self.indicator stopAnimating];
    
}



#pragma mark
#pragma -mark view cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"DEMOSecondViewController will appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"DEMOSecondViewController will disappear");
}

- (void)didReceiveMemoryWarning
{
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

@end
