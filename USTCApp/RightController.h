//
//  RightController.h
//  USTCApp
//
//  Created by ChenHao on 6/5/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "InformationController.h"

@interface RightController : UIViewController<UITableViewDataSource,UITableViewDelegate,informationProtocal>

@property (nonatomic, strong) UIImageView *HeadImageView;
@property (nonatomic, strong) UILabel *label;

- (void)pushBack;

//@protocol rightControllerDelegate <NSObject>
//
//- (void)PushRightChildController:(UIViewController *)viewController;
//
//@end
@end


