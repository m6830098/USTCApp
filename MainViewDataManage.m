//
//  MainViewDataManage.m
//  USTCApp
//
//  Created by ChenHao on 6/8/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "MainViewDataManage.h"
#import <XHNewsFramework/XHOperationNetworkKit.h>
#import "TFHpple.h"
#import "NewsData.h"


@interface MainViewDataManage()

@property (nonatomic) dispatch_queue_t dueJSONDataQueue;


@end

@implementation MainViewDataManage

+(instancetype)shareMainViewDataManage
{
    static MainViewDataManage *mainViewDataManage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainViewDataManage = [[MainViewDataManage alloc] init];
    });
    return mainViewDataManage;
}

// 使用block来设置加载完成后的刷新操作

- (void)loadNetDataSourcecompledBlock:(void (^)(NSMutableArray *datas))compled
{    
    
    //把解析的工作放到后台线程中操作.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    
        NSStringEncoding gbEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);


        NSURL *tutorialsUrl         = [NSURL URLWithString:@"http://www.sse.ustc.edu.cn/pages/xinw.php" ];
        NSData *tutorialsHtmData    = [NSData dataWithContentsOfURL:tutorialsUrl ];


        NSString *val               = [[NSString alloc]initWithData:tutorialsHtmData encoding:gbEncoding];
    
        NSString *utf8HtmlStr = [val stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-type\" content=\"text/html; charset=gb2312\" />"
                                                           withString:@"<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />"];
    

        tutorialsHtmData           = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
        //
        TFHpple *tutorialParser    = [TFHpple hppleWithHTMLData:tutorialsHtmData];

        NSString *xPathQueryString = @"//div[@class='body']/div[@class='main']/div[@class='column']/ul[@class='list1 news']/li/a";
        
        NSArray *tutorialsNodes    = [tutorialParser searchWithXPathQuery:xPathQueryString];

        assert(tutorialsNodes != nil);
    
        NSMutableArray *newTutorials = [[NSMutableArray alloc]initWithCapacity:0];
        for (TFHppleElement *element in tutorialsNodes) {
            NewsData *news = [[NewsData alloc]init];
            news.title = [element content];
            news.urlAddress   = [element objectForKey:@"href"];
            news.urlAddress = [NSString stringWithFormat:@"http://www.sse.ustc.edu.cn/pages/%@",news.urlAddress];
            
            news.date  = [[element firstChild]content];
        
        //提取每个news 对应的url中的content的内容,采用的是最普通的方法
        
        
//            NSURL *url = [NSURL URLWithString:news.urlAddress];
//            NSData *da = [NSData dataWithContentsOfURL:url];
//            NSString *res = [[NSString alloc]initWithData:da encoding:gbEncoding];
//        
//
//        
//            NSString *searchStartString=@"<div class=\"content\">";
//            NSString *searchEndString=@"<!-- @content -->";
//        
//            NSInteger Start = [res rangeOfString:searchStartString].location ;
//            NSInteger End = [res rangeOfString:searchEndString].location;
//        
//            NSInteger num = res.length;
//        
//        
//            assert( Start !=NSNotFound && End != NSNotFound  && Start < num && End < num);
//        
//        
//            NSRange rng = NSMakeRange(Start, End - Start);
//            //NSLog(@"start=%i,end=%i",Start,End - Start);
//            NSString *cuthtml =[res substringWithRange:rng];
//        
//        
//        
//            news.contentString = [self buildHTMLString:cuthtml];
//
        
        
            
            [newTutorials addObject:news];
            
        }
        ///跳到传递进来的compled ,然后去跳到主线程 去更新ui的界面,然后继续在后台线程处理data.
        compled(newTutorials);
    });
}

+ (NSString *)buildHTMLString:(NSString *)begin
{
    
    NSString * end = [[HEAD_HTML stringByAppendingString:begin]stringByAppendingString:END_HTML];
    
    //构造最后的需要加载的html字符串
    
    NSString *result = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@</body>",HTML_Style, @"",@"",end,HTML_Bottom];
    
    return result;
    
}
@end
