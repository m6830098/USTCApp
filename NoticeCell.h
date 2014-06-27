//
//  NoticeCell.h
//  USTCApp
//
//  Created by ChenHao on 6/16/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  每一个tableview的cell  布局,这个是notice新闻列表的布局.只包含新闻题目和新闻发布日期
 */
@interface NoticeCell : UITableViewCell



//新闻标题
@property (nonatomic, strong) UILabel *newsTitle;

//新闻发表时间
@property (nonatomic, strong) UILabel *newsPublishDate;





@end
