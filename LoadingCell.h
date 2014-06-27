//
//  LoadingCell.h
//  USTCApp
//
//  Created by ChenHao on 6/16/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
