//
//  ViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"
#import "TourTableViewController.h"
#import "Reachability.h"
#import "ForecastNewViewController.h"
#import "FBLoginViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

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

@interface MainViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBook;
    ForecastNewViewController *forecastNewViewController;
    TourTableViewController *tourTableView;
    Reachability *networkReachability;
    UIButton *logoutBtn;
    FBLoginViewController *loginViewController;
}

@end

@implementation MainViewController

-(void)detectingDevice
{
    
    if(IS_IPHONE)
    {
        //NSLog(@"IS_IPHONE");
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
        
        logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logoutBtn setTitle:NSLocalizedString(@"Logout", nil) forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [logoutBtn setFrame:CGRectMake(self.view.center.x-74, self.view.center.y+95, 145, 45)];
        if (![FBSDKAccessToken currentAccessToken]) {
            
            logoutBtn.hidden = YES;
            
        }else{
            
            logoutBtn.hidden = NO;
            [logoutBtn addTarget:self action:@selector(log_out) forControlEvents:UIControlEventTouchUpInside];
        }

        [self.view addSubview:logoutBtn];

    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
        [self.view addSubview:backgroundImg];
        
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
        
        logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logoutBtn setTitle:NSLocalizedString(@"Logout", nil) forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [logoutBtn setFrame:CGRectMake(self.view.center.x-94, self.view.center.y+100, 190, 60)];
        
        if (![FBSDKAccessToken currentAccessToken]) {
            
            logoutBtn.hidden = YES;
            
        }else{
            
            logoutBtn.hidden = NO;
            [logoutBtn addTarget:self action:@selector(log_out) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.view addSubview:logoutBtn];

    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
        [self.view addSubview:backgroundImg];
        
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
        
        logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logoutBtn setTitle:NSLocalizedString(@"Logout", nil) forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [logoutBtn setFrame:CGRectMake(self.view.center.x-100, self.view.center.y+130, 210, 70)];
        if (![FBSDKAccessToken currentAccessToken]) {
            
            logoutBtn.hidden = YES;
            
        }else{
            
            logoutBtn.hidden = NO;
            [logoutBtn addTarget:self action:@selector(log_out) forControlEvents:UIControlEventTouchUpInside];
        }

        [self.view addSubview:logoutBtn];
        
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
        [self.view addSubview:backgroundImg];
        
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
        
        logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logoutBtn setTitle:NSLocalizedString(@"Logout", nil) forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [logoutBtn setFrame:CGRectMake(self.view.center.x-135, self.view.center.y+150, 280, 80)];
        if (![FBSDKAccessToken currentAccessToken]) {
            
            logoutBtn.hidden = YES;
            
        }else{
            
            logoutBtn.hidden = NO;
            [logoutBtn addTarget:self action:@selector(log_out) forControlEvents:UIControlEventTouchUpInside];
        }

        [self.view addSubview:logoutBtn];

    }
}


-(void)loadView
{
    
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    logBook = [[LogBookTableViewController alloc] init];
    forecastNewViewController = [[ForecastNewViewController alloc] init];
    tourTableView = [[TourTableViewController alloc] init];
    loginViewController = [[FBLoginViewController alloc] init];
    
    [self detectingDevice];
    
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = NSLocalizedString(@"DivingBook", nil);
    
    /*making navigation bar transparent*/
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *backToHome = [[UIBarButtonItem alloc] init];
    backToHome.title = @"首頁";
    self.navigationItem.backBarButtonItem = backToHome;
    self.screenName = @"首頁";

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netWorkStatus = [networkReachability currentReachabilityStatus];
    
    if (netWorkStatus == NotReachable) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"注意" message:@"無法連結網路\n請檢查wifi或行動網路設定" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    }
}

-(void)fowardToLogBook:(id)sender
{
    [delegate.navi pushViewController:logBook animated:NO];
    //[pick monitorRegions];
    
}

-(void)fowardToForecast:(id)sender
{
    //[delegate.navi pushViewController:forecastView animated:NO];
    [delegate.navi pushViewController:forecastNewViewController animated:NO];
}

-(void)fowardToTourTable:(id)sender
{
    [delegate.navi pushViewController:tourTableView animated:NO];
}

-(void)log_out
{
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    [manager logOut];
    logoutBtn.hidden = YES;
    logoutBtn.enabled = NO;
    [delegate.navi pushViewController:loginViewController animated:NO];
    
    [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FB Login" action:@"Logout" label:@"Logout & foward to Login page" value:nil]build]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
