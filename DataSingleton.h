//
//  DataSingleton.h
//  HTMLParaseExample
//
//  Created by ChenHao on 6/14/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoadingCell.h"


@interface DataSingleton : NSObject

#pragma 单例模式

+ (DataSingleton *)Instance;
+ (id)allocWithZone:(struct _NSZone *)zone;

//返回标示正在加载的选项
//返回标示正在加载的选项
- (UITableViewCell *)getLoadMoreCell:(UITableView *)tableView
                       andIsLoadOver:(BOOL)isLoadOver
                   andLoadOverString:(NSString *)loadOverString
                    andLoadingString:(NSString *)loadingString
                        andIsLoading:(BOOL)isLoading;


@end
