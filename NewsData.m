//
//  NewsData.m
//  USTCApp
//
//  Created by ChenHao on 6/8/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "NewsData.h"

@implementation NewsData

@synthesize thumb,title,date,contentString,urlAddress,picAddressArray;

- (NewsData *)init
{
    self = [super init];
    if (self) {
        self.picAddressArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)news
{
    assert(news != nil);
    if (self            = [super init]) {
    self.title          = [news objectForKey:@"title"];
    self.thumb          = [news objectForKey:@"thumb"];

    //获取当前时间
    NSDate *dateTime    = [NSDate date];
    NSTimeInterval sec  = [dateTime timeIntervalSinceNow];
    NSDate *currentDate = [[NSDate alloc]initWithTimeIntervalSinceNow:sec];
    NSDateFormatter *df = df = [[NSDateFormatter alloc] init ];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * na       = [df stringFromDate:currentDate];

    NSString *getData   = [news objectForKey:@"date"];
    self.date           = getData.length == 0 ? na : getData;

    self.contentString  = [news objectForKey:@"contentString"];
    self.urlAddress     = [news objectForKey:@"urlAddress"];
    }
    return self;
}
@end
