//
//  MainViewDataManage.h
//  USTCApp
//
//  Created by ChenHao on 6/8/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsData.h"

@interface MainViewDataManage : NSObject

+ (instancetype)shareMainViewDataManage;
- (void)loadNetDataSourcecompledBlock:(void (^)(NSMutableArray *datas))compled;


@end
