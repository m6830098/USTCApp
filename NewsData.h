//
//  NewsData.h
//  USTCApp
//
//  Created by ChenHao on 6/8/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  每一行显示的news的model
 */
@interface NewsData : NSObject



//新闻的题目
@property (nonatomic, copy) NSString *title;
//新闻发表的日期
@property (nonatomic, copy) NSString *date;

//新闻缩略图地址
@property (nonatomic, copy) NSString *thumb;

//新闻的链接url
@property (nonatomic, copy) NSString *urlAddress;

//新闻链接url的 html  content代码,方便用webview直接加载
@property (nonatomic, copy) NSString *contentString;

@property (nonatomic, strong) NSMutableArray *picAddressArray;


- (instancetype)initWithDictionary:(NSDictionary *)news;
- (NewsData *)init;

@end
