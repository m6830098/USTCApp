//
//  NoticeCell.m
//  USTCApp
//
//  Created by ChenHao on 6/16/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "NoticeCell.h"

#define lightGreyColor  [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f  blue:80.0f/255.0f alpha:1.0f]
#define cccColor        [UIColor colorWithRed:236.0/255.0f green:238.0/255.0f blue:239.0/255.0f  alpha:1.0f]

@interface NoticeCell ()

//单元格背景
@property (nonatomic, strong) UIImageView *centerImageView;


@end
@implementation NoticeCell

@synthesize newsPublishDate,newsTitle;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
        
        
        //设置cell的长度和位置,这个方法覆盖默认方法,采用卡片式设计
        
        [self setFrame:self.bounds];
        
        //设置背景
        UIImage *centerImage = [UIImage imageNamed:@"feed_cell_bg@2x.png"];
        //拉伸图片背景，
        centerImage = [centerImage stretchableImageWithLeftCapWidth:15 topCapHeight:9];
        
        
        self.centerImageView = [[UIImageView alloc] initWithImage:centerImage];
        self.backgroundView = self.centerImageView;
        
        //设置高亮状态
        UIImage *centerImage2 = [UIImage imageNamed:@"feed_cell_bg_hl@2x.png"];
        //拉伸图片背景
        centerImage2 = [centerImage2 stretchableImageWithLeftCapWidth:15 topCapHeight:9];
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:centerImage2];
        self.selectedBackgroundView = imageView2;
        
      
        //新闻标题
        self.newsTitle = [UILabel new];
        self.newsTitle.frame = CGRectMake(19, 10, 300, 48);
        self.newsTitle.numberOfLines = 0;
        //self.newsTitle.text = @"北京天文馆朱金表示，神十将在明晚7时左右过境北京，天文爱好者可以观看";
        self.newsTitle.textColor = lightGreyColor;
        self.newsTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.newsTitle.text = [self.newsTitle.text substringToIndex:21];
        self.newsTitle.text = [NSString stringWithFormat:@"%@ .....",self.newsTitle.text];
        self.newsTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        self.newsTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.newsTitle];
        
        
        //发表时间
        self.newsPublishDate = [UILabel new];
        self.newsPublishDate.frame = CGRectMake(240, 60, 120, 14);
        self.newsPublishDate.font = [UIFont fontWithName:@"Arial" size:12];
        self.newsPublishDate.textColor = [UIColor grayColor];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YY-MM-dd HH:mm"];
        self.newsPublishDate.text = [dateFormatter stringFromDate:[NSDate date]];
        self.newsPublishDate.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.newsPublishDate];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected)
    {
        //看过之后，新闻标题变灰
        self.newsTitle.textColor = [UIColor grayColor];
    }
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        
    }
    // 必须要设置这个，不然高亮背景显示不出来
    [super setHighlighted:highlighted];
}


//重写该方法,采用卡片式设计
- (void)setFrame:(CGRect)frame
{
    frame.origin.x    -= 5;
    frame.size.width  += 10;
    frame.size.height += 8;
    [super setFrame:frame];
}


@end
