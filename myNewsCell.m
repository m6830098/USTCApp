//
//  myNewsCell.m
//  USTCApp
//
//  Created by ChenHao on 6/8/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "myNewsCell.h"

@implementation myNewsCell

- (void)setNewsModel:(NewsData *)newsModel
{
    self.newsTitle.text = newsModel.title;
    self.newsPublishDate.text = newsModel.date;
    //self.newsDescriptionLabel.text = newsModel.summary;
    
    self.newsThumb.image = [UIImage imageNamed:@" Home"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newsModel.pic]];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               self.newsThumb.image = [UIImage imageWithData:data];
//                           }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
