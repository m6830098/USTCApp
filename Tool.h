//
//  Tool.h
//  HTMLParaseExample
//
//  Created by ChenHao on 6/15/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject


+ (UIColor *)getBackgroundColor;

/**
 *  把数据存储到本地缓存,方便没有网络的时候加载
    type:
 1 -- 最新新闻
 2 -- 通知公告
 
 
 */
+ (void)saveCache:(int)type andNSArray:(NSArray *)arr;
+ (NSArray *)getCache:(int)type andNSArray:(NSArray *)arr;

//给url构造html格式的内容

+ (NSString *)buildHTMLString:(NSString *)begin;

//获取url 地址中的content部分
+ (NSString *)urlAddressToContentString:(NSString *)urlString;


@end
