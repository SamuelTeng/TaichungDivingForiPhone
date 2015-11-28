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
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface LogCategoryViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBookTableView;
    LogViewController *logView;
    
    NSUInteger view_tag;
    
    
}

@end

@implementation LogCategoryViewController
@synthesize air_Button,nitrox_Button,closedCircuit_Button;

-(void)detectingDevice
{
    
    if(IS_IPHONE)
    {
       // NSLog(@"IS_IPHONE");
    }
    if(IS_RETINA)
    {
        //NSLog(@"IS_RETINA");
    }
    if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"IS_IPHONE_4_OR_LESS");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i4"]];
        [self.view addSubview:backgroundImg];
        
        air_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [air_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/AirBtn_i4"] forState:UIControlStateNormal];
        [air_Button setTitle:NSLocalizedString(@"Air", nil) forState:UIControlStateNormal];
        [air_Button setFrame:CGRectMake(self.view.center.x-74, self.view.center.y-160,145, 45)];
        air_Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [air_Button addTarget:self action:@selector(air) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:air_Button];
        
        nitrox_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [nitrox_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/NitroBtn_i4"] forState:UIControlStateNormal];
        [nitrox_Button setTitle:NSLocalizedString(@"Nitro", nil) forState:UIControlStateNormal];
        [nitrox_Button setFrame:CGRectMake(self.view.center.x-74, self.view.center.y-60, 145, 45)];
        [nitrox_Button addTarget:self action:@selector(nitrox) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nitrox_Button];
        
        closedCircuit_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [closedCircuit_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/CcrBtn_i4"] forState:UIControlStateNormal];
        [closedCircuit_Button setTitle:NSLocalizedString(@"CCR", nil) forState:UIControlStateNormal];
        [closedCircuit_Button setFrame:CGRectMake(self.view.center.x-74, self.view.center.y+40, 145, 45)];
        [closedCircuit_Button addTarget:self action:@selector(closedCircuit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closedCircuit_Button];
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
        [self.view addSubview:backgroundImg];
        
        air_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [air_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/AirBtn_i5"] forState:UIControlStateNormal];
        [air_Button setTitle:NSLocalizedString(@"Air", nil) forState:UIControlStateNormal];
        [air_Button setFrame:CGRectMake(self.view.center.x-94, self.view.center.y-180,190, 60)];
        air_Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [air_Button addTarget:self action:@selector(air) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:air_Button];
        
        nitrox_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [nitrox_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/NitroBtn_i5"] forState:UIControlStateNormal];
        [nitrox_Button setTitle:NSLocalizedString(@"Nitro", nil) forState:UIControlStateNormal];
        [nitrox_Button setFrame:CGRectMake(self.view.center.x-94, self.view.center.y-80, 190, 60)];
        [nitrox_Button addTarget:self action:@selector(nitrox) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nitrox_Button];
        
        closedCircuit_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [closedCircuit_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/CcrBtn_i5"] forState:UIControlStateNormal];
        [closedCircuit_Button setTitle:NSLocalizedString(@"CCR", nil) forState:UIControlStateNormal];
        [closedCircuit_Button setFrame:CGRectMake(self.view.center.x-94, self.view.center.y+20, 190, 60)];
        [closedCircuit_Button addTarget:self action:@selector(closedCircuit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closedCircuit_Button];
       
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
        [self.view addSubview:backgroundImg];
        
        air_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [air_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/AirBtn_i6"] forState:UIControlStateNormal];
        [air_Button setTitle:NSLocalizedString(@"Air", nil) forState:UIControlStateNormal];
        [air_Button setFrame:CGRectMake(self.view.center.x-100, self.view.center.y-200,210, 70)];
        air_Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [air_Button addTarget:self action:@selector(air) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:air_Button];
        
        nitrox_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [nitrox_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/NitroBtn_i6"] forState:UIControlStateNormal];
        [nitrox_Button setTitle:NSLocalizedString(@"Nitro", nil) forState:UIControlStateNormal];
        [nitrox_Button setFrame:CGRectMake(self.view.center.x-100, self.view.center.y-80, 210, 70)];
        [nitrox_Button addTarget:self action:@selector(nitrox) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nitrox_Button];
        
        closedCircuit_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [closedCircuit_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/CcrBtn_i6"] forState:UIControlStateNormal];
        [closedCircuit_Button setTitle:NSLocalizedString(@"CCR", nil) forState:UIControlStateNormal];
        [closedCircuit_Button setFrame:CGRectMake(self.view.center.x-100, self.view.center.y+40, 210, 70)];
        [closedCircuit_Button addTarget:self action:@selector(closedCircuit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closedCircuit_Button];
        
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
        [self.view addSubview:backgroundImg];
        
        air_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [air_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/AirBtn_i6P"] forState:UIControlStateNormal];
        [air_Button setTitle:NSLocalizedString(@"Air", nil) forState:UIControlStateNormal];
        [air_Button setFrame:CGRectMake(self.view.center.x-135, self.view.center.y-210,280, 80)];
        air_Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [air_Button addTarget:self action:@selector(air) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:air_Button];
        
        nitrox_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [nitrox_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/NitroBtn_i6P"] forState:UIControlStateNormal];
        [nitrox_Button setTitle:NSLocalizedString(@"Nitro", nil) forState:UIControlStateNormal];
        [nitrox_Button setFrame:CGRectMake(self.view.center.x-135, self.view.center.y-80, 280, 80)];
        [nitrox_Button addTarget:self action:@selector(nitrox) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nitrox_Button];
        
        closedCircuit_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [closedCircuit_Button setBackgroundImage:[UIImage imageNamed:@"Button.bundle/CcrBtn_i6P"] forState:UIControlStateNormal];
        [closedCircuit_Button setTitle:NSLocalizedString(@"CCR", nil) forState:UIControlStateNormal];
        [closedCircuit_Button setFrame:CGRectMake(self.view.center.x-135, self.view.center.y+50, 280, 80)];
        [closedCircuit_Button addTarget:self action:@selector(closedCircuit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closedCircuit_Button];
            }
}


-(void)loadView
{
    
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    logBookTableView = [[LogBookTableViewController alloc] init];
    logView = [[LogViewController alloc] init];
    
    view_tag = 0;
    
    [self detectingDevice];
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*helps understanding the flow of behavior*/
    self.screenName = NSLocalizedString(@"LogCat", nil);
}

-(void)air
{
    NSUInteger air_tag = 0;
    
    logView.viewReserved = view_tag;
    
    logView.logType = air_tag;
    
    [delegate.navi pushViewController:logView animated:NO];
    
    [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Input Logs" action:@"Log Category Selected" label:NSLocalizedString(@"Air", nil) value:nil]build]];
}

-(void)nitrox
{
    NSUInteger nirox_tag = 1;
    
    logView.viewReserved = view_tag;
    
    logView.logType = nirox_tag;
    
    [delegate.navi pushViewController:logView animated:NO];
    
    [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Input Logs" action:@"Log Category Selected" label:NSLocalizedString(@"Nitro", nil) value:nil]build]];
    
}

-(void)closedCircuit
{
    NSUInteger closedCircuit = 2;
    
    logView.viewReserved = view_tag;
    
    logView.logType = closedCircuit;
    
    [delegate.navi pushViewController:logView animated:NO];
    
    [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Input Logs" action:@"Log Category Selected" label:NSLocalizedString(@"CCR", nil) value:nil]build]];
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
