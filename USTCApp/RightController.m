//
//  RightController.m
//  USTCApp
//
//  Created by ChenHao on 6/5/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "RightController.h"
#import "MainController.h"
#import "SoftWareInformationController.h"
#import "MainViewController.h"
#import "UIView+i7Rotate360.h"
#import "XHLoginViewController3.h"
#import "UIViewController+MJPopupViewController.h"

#import "MFSideMenuContainerViewController.h"
#import "InformationController.h"
#import "RightSelectTypeController.h"


@interface RightController ()

@property (strong, nonatomic, readwrite) UITableView    *tableView;
@property (strong, nonatomic           ) NSMutableArray *datas;
@property (strong, nonatomic)            XHLoginViewController3 *logInController;
@end

@implementation RightController

@synthesize HeadImageView;
@synthesize label;
@synthesize datas;
@synthesize logInController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(143, (self.view.frame.size.height - 54 * 3 ) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
    self.HeadImageView = [[UIImageView alloc]init];
    self.HeadImageView.backgroundColor = [UIColor clearColor];
    self.HeadImageView.frame = CGRectMake(160, 40, 80, 80);
    self.HeadImageView.layer.cornerRadius = 40.0;
    self.HeadImageView.layer.borderWidth = 1.0;
    self.HeadImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.HeadImageView.layer.masksToBounds = YES;
    self.HeadImageView.image = [UIImage imageNamed:@"head1.jpg"];
    [self.view addSubview:self.HeadImageView];
    
    self.label = [[UILabel alloc]init];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.frame = CGRectMake(160, 125, 80, 40);
    self.label.text = @"立即登录";
    self.label.font = [UIFont boldSystemFontOfSize:20.0f];
    self.label.textColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    NSArray *titles = @[@"全部通知",@"实习进度",@"实习进度",@"实习进度",@"文档下载"];
    self.datas = [[NSMutableArray alloc]initWithArray:titles];
    
    
    
    UITapGestureRecognizer *imageClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhoto:)];
    [self.HeadImageView addGestureRecognizer:imageClick];
    [self.label addGestureRecognizer:imageClick];
    CALayer *bottomBorder = [CALayer layer];
    float height=self.view.frame.size.height-1.0f;
    float width=self.view.frame.size.width;
    bottomBorder.frame = CGRectMake(0.0f, height, width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    [self.HeadImageView.layer addSublayer:bottomBorder];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)clickPhoto:(UITapGestureRecognizer*)recognizer
{
    [self performSelector:@selector(headPhotoAnimation) withObject:nil afterDelay:0.6 ];
    
}

- (void)headPhotoAnimation
{
    [self.HeadImageView rotate360WithDuration:2.0 repeatCount:1 timingMode:i7Rotate360TimingModeLinear];
    self.HeadImageView.animationDuration = 2.0;
    self.HeadImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"head1.jpg"],
                                      [UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head2.jpg"],
                                      [UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head2.jpg"],
                                      [UIImage imageNamed:@"head1.jpg"], nil];
    self.HeadImageView.animationRepeatCount = 1;
    [self.HeadImageView startAnimating];
}
#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath row]) {
        case 0:
        {

            logInController = [[XHLoginViewController3 alloc]init];
            
//            logInController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(pushBack)];
//            logInController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//            [self.navigationController pushViewController:logInController animated:YES];
            
////            [self.delegate PushRightChildController:logInController];
            [self presentPopupViewController:logInController animationType:MJPopupViewAnimationSlideBottomTop];
        
                         break;
        }
        case 1:
        {
            RightSelectTypeController *rightSelectController = [[RightSelectTypeController alloc]init];
            InformationController *info = [[InformationController alloc]init];
            info.delegate = self;
            MFSideMenuContainerViewController * container = [MFSideMenuContainerViewController containerWithCenterViewController:[[UINavigationController alloc] initWithRootViewController:info] leftMenuViewController:nil rightMenuViewController:rightSelectController];
           
            [self presentPopupViewController:(UIViewController*)container animationType:MJPopupViewAnimationSlideRightRight];
//            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[[SoftWareInformationController alloc]init]]animated:YES];
//            [self.sideMenuViewController hideMenuViewController];
            
            
            break;
        }
        default:
            break;
    }

}
- (void)pushBack
{
    
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - 
#pragma mark UITableview DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    
    cell.textLabel.text = datas[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;

}

- (void)returnToLastView
{
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftRight];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end