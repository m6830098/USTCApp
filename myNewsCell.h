//
//  myNewsCell.h
//  USTCApp
//
//  Created by ChenHao on 6/8/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "NewsCell.h"
#import "NewsData.h"

@interface myNewsCell : NewsCell

//一个news中的信息
@property (nonatomic, strong) NewsData *newsModel;


@end
