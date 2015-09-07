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
}

@end

@implementation LogCategoryViewController
@synthesize air_Button,nitrox_Button,closedCircuit_Button;

-(void)detectingDevice
{
    
    if(IS_IPHONE)
    {
        NSLog(@"IS_IPHONE");
    }
    if(IS_RETINA)
    {
        NSLog(@"IS_RETINA");
    }
    if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"IS_IPHONE_4_OR_LESS");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i4"]];
        [self.view addSubview:backgroundImg];
        /*
        UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [logBookButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/LogBookBtn_i4"] forState:UIControlStateNormal];
        [logBookButton setTitle:NSLocalizedString(@"LogPage", nil) forState:UIControlStateNormal];
        [logBookButton setFrame:CGRectMake(self.view.center.x-74, self.view.center.y-160,145, 45)];
        logBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [logBookButton addTarget:self action:@selector(fowardToLogBook:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logBookButton];
        
        UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [weatherButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/WeatherBtn_i4"] forState:UIControlStateNormal];
        [weatherButton setTitle:NSLocalizedString(@"Weather", nil) forState:UIControlStateNormal];
        [weatherButton setFrame:CGRectMake(self.view.center.x-74, self.view.center.y-60, 145, 45)];
        [weatherButton addTarget:self action:@selector(fowardToForecast:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weatherButton];
        
        UIButton *tourButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tourButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/TourBtn_i4"] forState:UIControlStateNormal];
        [tourButton setTitle:NSLocalizedString(@"Tour", nil) forState:UIControlStateNormal];
        [tourButton setFrame:CGRectMake(self.view.center.x-74, self.view.center.y+40, 145, 45)];
        [tourButton addTarget:self action:@selector(fowardToTourTable:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tourButton];
        */
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
        [self.view addSubview:backgroundImg];
        /*
        UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [logBookButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/LogBookBtn_i5"] forState:UIControlStateNormal];
        [logBookButton setTitle:NSLocalizedString(@"LogPage", nil) forState:UIControlStateNormal];
        [logBookButton setFrame:CGRectMake(self.view.center.x-94, self.view.center.y-180,190, 60)];
        logBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [logBookButton addTarget:self action:@selector(fowardToLogBook:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logBookButton];
        
        UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [weatherButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/WeatherBtn_i5"] forState:UIControlStateNormal];
        [weatherButton setTitle:NSLocalizedString(@"Weather", nil) forState:UIControlStateNormal];
        [weatherButton setFrame:CGRectMake(self.view.center.x-94, self.view.center.y-80, 190, 60)];
        [weatherButton addTarget:self action:@selector(fowardToForecast:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weatherButton];
        
        UIButton *tourButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tourButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/TourBtn_i5"] forState:UIControlStateNormal];
        [tourButton setTitle:NSLocalizedString(@"Tour", nil) forState:UIControlStateNormal];
        [tourButton setFrame:CGRectMake(self.view.center.x-94, self.view.center.y+20, 190, 60)];
        [tourButton addTarget:self action:@selector(fowardToTourTable:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tourButton];
        */
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
        [self.view addSubview:backgroundImg];
        /*
        UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [logBookButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/LogBookBtn_i6"] forState:UIControlStateNormal];
        [logBookButton setTitle:NSLocalizedString(@"LogPage", nil) forState:UIControlStateNormal];
        [logBookButton setFrame:CGRectMake(self.view.center.x-100, self.view.center.y-200,210, 70)];
        logBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [logBookButton addTarget:self action:@selector(fowardToLogBook:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logBookButton];
        
        UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [weatherButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/WeatherBtn_i6"] forState:UIControlStateNormal];
        [weatherButton setTitle:NSLocalizedString(@"Weather", nil) forState:UIControlStateNormal];
        [weatherButton setFrame:CGRectMake(self.view.center.x-100, self.view.center.y-80, 210, 70)];
        [weatherButton addTarget:self action:@selector(fowardToForecast:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weatherButton];
        
        UIButton *tourButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tourButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/TourBtn_i6"] forState:UIControlStateNormal];
        [tourButton setTitle:NSLocalizedString(@"Tour", nil) forState:UIControlStateNormal];
        [tourButton setFrame:CGRectMake(self.view.center.x-100, self.view.center.y+40, 210, 70)];
        [tourButton addTarget:self action:@selector(fowardToTourTable:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tourButton];
         */
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
        [self.view addSubview:backgroundImg];
        /*
        UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [logBookButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/LogBookBtn_i6P"] forState:UIControlStateNormal];
        [logBookButton setTitle:NSLocalizedString(@"LogPage", nil) forState:UIControlStateNormal];
        [logBookButton setFrame:CGRectMake(self.view.center.x-135, self.view.center.y-210,280, 80)];
        logBookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [logBookButton addTarget:self action:@selector(fowardToLogBook:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logBookButton];
        
        UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [weatherButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/WeatherBtn_i6P"] forState:UIControlStateNormal];
        [weatherButton setTitle:NSLocalizedString(@"Weather", nil) forState:UIControlStateNormal];
        [weatherButton setFrame:CGRectMake(self.view.center.x-135, self.view.center.y-80, 280, 80)];
        [weatherButton addTarget:self action:@selector(fowardToForecast:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weatherButton];
        
        UIButton *tourButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tourButton setBackgroundImage:[UIImage imageNamed:@"Button.bundle/TourBtn_i6P"] forState:UIControlStateNormal];
        [tourButton setTitle:NSLocalizedString(@"Tour", nil) forState:UIControlStateNormal];
        [tourButton setFrame:CGRectMake(self.view.center.x-135, self.view.center.y+50, 280, 80)];
        [tourButton addTarget:self action:@selector(fowardToTourTable:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tourButton];
        */
    }
}


-(void)loadView
{
    
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    logBookTableView = [[LogBookTableViewController alloc] init];
    logView = [[LogViewController alloc] init];
    
    [self detectingDevice];
    
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
