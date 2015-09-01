//
//  LogCategoryViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "LogCategoryViewController.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"
#import "LogViewController.h"

@interface LogCategoryViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBookTableView;
    LogViewController *logView;
}

@end

@implementation LogCategoryViewController
@synthesize air_Button,nitrox_Button,closedCircuit_Button;

-(void)loadView
{
    
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    logBookTableView = [[LogBookTableViewController alloc] init];
    logView = [[LogViewController alloc] init];
    
    air_Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [air_Button setTitle:NSLocalizedString(@"Air", nil) forState:UIControlStateNormal];
    [air_Button setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-170,180, 60)];
    [air_Button addTarget:self action:@selector(air) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:air_Button];
    
    nitrox_Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nitrox_Button setTitle:NSLocalizedString(@"Nitro", nil) forState:UIControlStateNormal];
    [nitrox_Button setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-110, 180, 60)];
    [nitrox_Button addTarget:self action:@selector(nitrox) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nitrox_Button];
    
    closedCircuit_Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closedCircuit_Button setTitle:NSLocalizedString(@"CCR", nil) forState:UIControlStateNormal];
    [closedCircuit_Button setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-40, 180, 60)];
    [closedCircuit_Button addTarget:self action:@selector(closedCircuit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closedCircuit_Button];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)air
{
    NSInteger air_tag = 0;
    
    logView.logType = air_tag;
    
    [delegate.navi pushViewController:logView animated:NO];
}

-(void)nitrox
{
    NSInteger nirox_tag = 1;
    
    logView.logType = nirox_tag;
    
    [delegate.navi pushViewController:logView animated:NO];
}

-(void)closedCircuit
{
    NSInteger closedCircuit = 2;
    
    logView.logType = closedCircuit;
    
    [delegate.navi pushViewController:logView animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    logView = nil;
    air_Button = nil;
    nitrox_Button = nil;
    closedCircuit_Button = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
