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

@interface MainViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBook;
    ForecastNewViewController *forecastNewViewController;
    TourTableViewController *tourTableView;
    Reachability *networkReachability;
}

@end

@implementation MainViewController

-(void)loadView
{
    
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    logBook = [[LogBookTableViewController alloc] init];
    forecastNewViewController = [[ForecastNewViewController alloc] init];
    tourTableView = [[TourTableViewController alloc] init];
    
    UIButton *logBookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBookButton setBackgroundImage:[UIImage imageNamed:@"ic_class_black_48dp.png"] forState:UIControlStateNormal];
    [logBookButton setTitle:NSLocalizedString(@"LogPage", nil) forState:UIControlStateNormal];
    [logBookButton setFrame:CGRectMake(self.view.center.x-20, self.view.center.y-150,48, 48)];
    [logBookButton addTarget:self action:@selector(fowardToLogBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logBookButton];
    
    UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [weatherButton setTitle:NSLocalizedString(@"Weather", nil) forState:UIControlStateNormal];
    [weatherButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-90, 180, 60)];
    [weatherButton addTarget:self action:@selector(fowardToForecast:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weatherButton];
    
    UIButton *tourButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tourButton setTitle:NSLocalizedString(@"Tour", nil) forState:UIControlStateNormal];
    [tourButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-40, 180, 60)];
    [tourButton addTarget:self action:@selector(fowardToTourTable:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tourButton];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
