//
//  Tool.m
//  HTMLParaseExample
//
//  Created by ChenHao on 6/15/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "Tool.h"

@implementation Tool


+ (UIColor *)getBackgroundColor
{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
}
+ (void)saveCache:(int)type andNSArray:(NSArray *)arr;
{
    NSUserDefaults *settting = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"type:%d",type];
    [settting setObject:arr forKey:key];
    [settting synchronize];
}
+ (NSArray *)getCache:(int)type andNSArray:(NSArray *)arr
{
    NSUserDefaults *settting = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"type:%d",type];
    NSArray *value = [settting objectForKey:key];
    return value;
}


+ (NSString *)urlAddressToContentString:(NSString *)urlString
{
    NSStringEncoding gbEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *da = [NSData dataWithContentsOfURL:url];
    NSString *res = [[NSString alloc]initWithData:da encoding:gbEncoding];
    
    NSString *searchStartString=@"<div class=\"content\">";
    NSString *searchEndString=@"<!-- @content -->";
    
    NSInteger Start = [res rangeOfString:searchStartString].location ;
    NSInteger End = [res rangeOfString:searchEndString].location;
    
    NSInteger num = res.length;
    
    NSRange rng = NSMakeRange(Start, End - Start);
    NSString *cuthtml =[res substringWithRange:rng];
    
    
    
    cuthtml = [Tool buildHTMLString:cuthtml];
    return cuthtml;

}


//把读取的新闻信息都构造成html的形式供webview加载
+ (NSString *)buildHTMLString:(NSString *)begin
{
    
    NSString * end = [[HEAD_HTML stringByAppendingString:begin]stringByAppendingString:END_HTML];
    
    //构造最后的需要加载的html字符串
    
    NSString *result = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@</body>",HTML_Style, @"",@"",end,HTML_Bottom];
    
    return result;
    
}
@end
