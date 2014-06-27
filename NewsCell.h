//
//  NewsCell.h
//  USTCApp
//
//  Created by ChenHao on 6/8/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <UIKit/UIKit.h>




/**
 *  每一个tableview的cell  布局
 */
@interface NewsCell : UITableViewCell



//新闻缩略图
@property (nonatomic, strong) UIImageView *newsThumb;

//新闻标题
@property (nonatomic, strong) UILabel *newsTitle;

//新闻发表时间
@property (nonatomic, strong) UILabel *newsPublishDate;


@end
