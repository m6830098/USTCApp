//
//  LeftController.m
//  USTCApp
//
//  Created by ChenHao on 6/5/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import "LeftController.h"
#import "MainController.h"
#import "SoftWareInformationController.h"
#import "MainViewController.h"


@interface LeftController ()

@property (strong, readwrite, nonatomic) UITableView                   *tableView;
@property (strong, nonatomic           ) SoftWareInformationController *infoViewController;

@end

@implementation LeftController

@synthesize infoViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = ({
        UITableView *tableView     = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate         = self;
        tableView.dataSource       = self;
        tableView.opaque           = NO;
        tableView.backgroundColor  = [UIColor clearColor];
        tableView.backgroundView   = nil;
        tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
        tableView.bounces          = NO;
        tableView;
    });
    
    infoViewController = [[SoftWareInformationController alloc]init];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UINavigationController *nav;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath row]) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[[MainViewController alloc]init ]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            
            infoViewController.catlog = 1;
            nav = [[UINavigationController alloc]initWithRootViewController:infoViewController];
            
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            infoViewController.catlog = 2;
            nav = [[UINavigationController alloc]initWithRootViewController:infoViewController];
            
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            infoViewController.catlog = 3;
            nav = [[UINavigationController alloc]initWithRootViewController:infoViewController];
            
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 4:
            infoViewController.catlog = 4;
            nav = [[UINavigationController alloc]initWithRootViewController:infoViewController];
            
            [self.sideMenuViewController setContentViewController:nav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell                                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor                = [UIColor clearColor];
        cell.textLabel.font                 = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor            = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView         = [[UIView alloc] init];
    }
    
    
    NSArray *titles      = @[@"主页", @"学院介绍", @"机构设置", @"专业介绍", @"招生问答"];
    NSArray *images      = @[@" Home", @"favorite", @"IconProfile", @"IconSettings", @"star"];
    cell.textLabel.text  = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
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
