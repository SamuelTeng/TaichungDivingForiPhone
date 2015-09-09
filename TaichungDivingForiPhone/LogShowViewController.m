//
//  LogShowViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "LogShowViewController.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"
#import "LogDatabase.h"

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

@interface LogShowViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logTableview;
    LogDatabase *logDatabase;
}
@property (nonatomic,strong) UITextView *log;
@end

@implementation LogShowViewController
@synthesize  date,site,time,airType,preSta,preEnd,maxDep,temp,visib,logShowView,waves,current,mixture,oxygen,nitrogen,helium,lowppo2,highppo2;
@synthesize contenPath,log;

-(void)toLogRecord:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

-(void)lodeLog
{
    date = [logDatabase date:contenPath];
    
    site = [logDatabase site:contenPath];
    
    time = [logDatabase time:contenPath];
    
    airType = [logDatabase gas:contenPath];
    
    preSta = [logDatabase startPressure:contenPath];
    
    preEnd = [logDatabase endPressure:contenPath];
    
    maxDep = [logDatabase depth:contenPath];
    
    temp = [logDatabase temprature:contenPath];
    
    visib = [logDatabase visibility:contenPath];
    
    
    waves = [logDatabase waves:contenPath];
    
    current = [logDatabase current:contenPath];
    
    mixture = [logDatabase mixture:contenPath];
    
    oxygen = [logDatabase oxygen:contenPath];
    
    nitrogen = [logDatabase nitrogen:contenPath];
    
    helium = [logDatabase helium:contenPath];
    
    lowppo2 = [logDatabase lowppO2:contenPath];
    
    highppo2 = [logDatabase highppO2:contenPath];
    
    if ([airType isEqualToString:NSLocalizedString(@"CCR", nil)]) {
        NSString *_log = [NSString stringWithFormat:NSLocalizedString(@"CCRL", nil), date,site,time,airType,preSta,preEnd,mixture,oxygen,nitrogen,helium,lowppo2,highppo2,maxDep,temp,visib,current,waves];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blackColor];
        log.backgroundColor = [UIColor clearColor];
        
        [log setFont:[UIFont fontWithName:@"Baskerville" size:20.0]];
        //[log setFont:[UIFont systemFontOfSize:20.0]];
        log.editable = NO;
        [logShowView addSubview:log];
        
        CGFloat scrollViewHeight = 0.0f;
        for (UIView *view in logShowView.subviews) {
            scrollViewHeight += view.frame.size.height;
        }
        
        logShowView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                             scrollViewHeight//self.view.bounds.size.height+10
                                             );
        
        
        self.view.backgroundColor = [UIColor clearColor];
        
    }else if ([airType isEqualToString:NSLocalizedString(@"Nitro", nil)]){
        
        NSString *_log = [NSString stringWithFormat:NSLocalizedString(@"NitroL", nil), date,site,time,airType,preSta,preEnd,mixture,oxygen,nitrogen,maxDep,temp,visib,current,waves];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 900)];
        [log setText:_log];
        log.textColor = [UIColor blackColor];
        log.backgroundColor = [UIColor clearColor];
        
        [log setFont:[UIFont fontWithName:@"Baskerville" size:20.0]];
        //[log setFont:[UIFont systemFontOfSize:20.0]];
        log.editable = NO;
        [logShowView addSubview:log];
        
        CGFloat scrollViewHeight = 0.0f;
        for (UIView *view in logShowView.subviews) {
            scrollViewHeight += view.frame.size.height;
        }
        
        logShowView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                             scrollViewHeight//self.view.bounds.size.height+10
                                             );
        
        
        self.view.backgroundColor = [UIColor clearColor];
    }else{
        
        NSString *_log = [NSString stringWithFormat:NSLocalizedString(@"Log", nil), date,site,time,airType,preSta,preEnd,maxDep,temp,visib,current,waves];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 800)];
        [log setText:_log];
        log.textColor = [UIColor blackColor];
        log.backgroundColor = [UIColor clearColor];
        
        [log setFont:[UIFont fontWithName:@"Baskerville" size:20.0]];
        //[log setFont:[UIFont systemFontOfSize:20.0]];
        log.editable = NO;
        [logShowView addSubview:log];
        
        CGFloat scrollViewHeight = 0.0f;
        for (UIView *view in logShowView.subviews) {
            scrollViewHeight += view.frame.size.height;
        }
        
        logShowView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                             scrollViewHeight//self.view.bounds.size.height+10
                                             );
        
        
        
        self.view.backgroundColor = [UIColor clearColor];
    }

    
}

-(void)detectingDevice
{
    
        if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"IS_IPHONE_4_OR_LESS");
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i4"]];
        scrollBackground.contentMode = UIViewContentModeScaleAspectFit;
        [self.view insertSubview:scrollBackground belowSubview:logShowView];
        
        
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
        scrollBackground.contentMode = UIViewContentModeScaleAspectFit;
        [self.view insertSubview:scrollBackground belowSubview:logShowView];
        
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
        //scrollBackground.contentMode = UIViewContentModeScaleAspectFit;
        [scrollBackground setFrame:logShowView.frame];
        [self.view insertSubview:scrollBackground belowSubview:logShowView];
        
        
        
        
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
        scrollBackground.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view insertSubview:scrollBackground belowSubview:logShowView];
        
    }
}


-(void)loadView
{
    [super loadView];
    delegate = [[UIApplication sharedApplication] delegate];
    //logRecordViewController = [[LogRecordViewController alloc] init];
    logTableview = [[LogBookTableViewController alloc] init];
    
    logDatabase = [LogDatabase new];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    
    logShowView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    [self detectingDevice];
    
    
    [self.view addSubview:logShowView];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self lodeLog];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    date = nil;
    site = nil;
    time = nil;
    airType = nil;
    preSta = nil;
    preEnd = nil;
    maxDep = nil;
    temp = nil;
    visib = nil;
    mixture = nil;
    oxygen = nil;
    nitrogen = nil;
    helium = nil;
    lowppo2 = nil;
    highppo2 = nil;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    logDatabase = nil;
    date = nil;
    site = nil;
    time = nil;
    airType = nil;
    preSta = nil;
    preEnd = nil;
    maxDep = nil;
    temp = nil;
    visib = nil;
    mixture = nil;
    oxygen = nil;
    nitrogen = nil;
    helium = nil;
    lowppo2 = nil;
    highppo2 = nil;
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
