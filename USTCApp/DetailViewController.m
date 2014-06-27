//
//  DetailViewController.m
//  USTCApp
//
//  Created by ChenHao on 6/12/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "DetailViewController.h"
#import "Tool.h"


@interface DetailViewController ()


@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) UIWebView               *webView;

@end

@implementation DetailViewController

@synthesize urlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        // Custom initialization
        
        self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        
        self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        self.webView.detectsPhoneNumbers = YES;
        //self.webView.scalesPageToFit = YES;
        self.webView.delegate = self;
        
        self.webView.frame = self.view.bounds;
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        
        [self.view addSubview:self.webView];
        
        self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.frame = CGRectMake(100, 200, 50, 50);
        self.indicator.backgroundColor = [UIColor clearColor];
        self.indicator.color = [UIColor redColor];
        [self.indicator sizeToFit];
        
        [self.view addSubview:self.indicator];
        //[self LoadHtmlString:urlString];
        
    }
    return self;
}
- (void)LoadHtmlString:(NSString *)htmlString
{
    [self.indicator startAnimating];
    int64_t delay = 2.0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    
    if (htmlString.length == 0) {
        dispatch_after(time, dispatch_get_main_queue(), ^(void){
            [self.webView loadHTMLString:htmlString baseURL:nil];
            // Or put the code from doSomethingLater: inline here
        });
    }
    else
        [self.webView loadHTMLString:htmlString baseURL:nil];
    
}


- (void)LoadContentString:(NSString *)contentString withPictureArray:(NSArray *)picArray;
{
    //替换contentstring中的字符串
    
    if (0 != picArray.count) {
        for (int i = 0; i < picArray.count; i++) {
            if ([contentString rangeOfString:picArray[i]].location == NSNotFound) {
                
                NSString *strBegin = [picArray[i] copy];
                
                NSString *str = [strBegin stringByReplacingOccurrencesOfString:@"http://sse.ustc.edu.cn" withString:@""];
                 contentString = [contentString stringByReplacingOccurrencesOfString:str withString:strBegin ];
            }
        }
        [self.webView loadHTMLString:contentString baseURL:nil];
    }
    else
        [self.webView loadHTMLString:contentString baseURL:nil];
        
    
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
