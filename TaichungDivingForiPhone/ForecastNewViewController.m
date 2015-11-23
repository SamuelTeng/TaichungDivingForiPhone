//
//  ForecastNewViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "ForecastNewViewController.h"

@interface ForecastNewViewController (){
    
    UIToolbar *toolBar;
    UIBarButtonItem *forwardButton;
    UIBarButtonItem *backwardButton;
    UIBarButtonItem *refereshButton;
    UIBarButtonItem *stopButton;
    UIBarButtonItem *fixedSpace;
    UIBarButtonItem *flexibleSpace;
    
    UIActivityIndicatorView *spinner;
}


@end

@implementation ForecastNewViewController

@synthesize webView;

-(void)loadView
{
    [super loadView];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.delegate = self;
    NSString *addressString = @"http://www.cwb.gov.tw/V7/forecast/fishery/NSea.htm";
    NSURL *addressUrl = [NSURL URLWithString:addressString];
    NSURLRequest* addressRequest = [NSURLRequest requestWithURL:addressUrl];
    [self.webView loadRequest:addressRequest];
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-44, [[UIScreen mainScreen] bounds].size.width, 44)];
    [self updateBarBunttonItems];
    
    spinner=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.view addSubview:self.webView];
    [self.webView addSubview:toolBar];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.screenName = @"Weather Forecast";
    
    self.webView.frame=self.view.bounds;
    self.webView.scalesPageToFit = YES;
    spinner.frame=self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
    [self updateBarBunttonItems];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    spinner.color=[UIColor blackColor];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    [self updateBarBunttonItems];
}

-(void)updateBarBunttonItems
{
    UIBarButtonItem *refreshAndStopButton = self.webView.isLoading ? self.stopBarButton : self.refreshBarButton;
    
    fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons.bundle/SVWebViewControllerNext"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardTapped:)];
    forwardButton.enabled = self.webView.canGoForward;
    backwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons.bundle/SVWebViewControllerBack"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackwardTapped:)];
    backwardButton.enabled = self.webView.canGoBack;
    
    NSArray* items = [NSArray arrayWithObjects:fixedSpace,backwardButton,flexibleSpace,forwardButton,flexibleSpace,refreshAndStopButton,fixedSpace, nil];
    toolBar.barStyle= self.navigationController.navigationBar.barStyle;
    toolBar.tintColor = self.navigationController.navigationBar.tintColor;
    toolBar.items = items;
    
}

-(UIBarButtonItem*)refreshBarButton
{
    if (!refereshButton) {
        refereshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTapped:)];
    }
    return refereshButton;
}

-(UIBarButtonItem *)stopBarButton
{
    if (!stopButton) {
        stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopTapped:)];
    }
    return stopButton;
}

-(void)reloadTapped:(UIBarButtonItem*)sender
{
    [self.webView reload];
}

-(void)stopTapped:(UIBarButtonItem *)sender
{
    [self.webView stopLoading];
}

-(void)goForwardTapped:(UIBarButtonItem*)sender
{
    [self.webView goForward];
}

-(void)goBackwardTapped:(UIBarButtonItem*)sender
{
    [self.webView goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    stopButton = nil;
    refereshButton = nil;
    forwardButton = nil;
    backwardButton = nil;
    self.webView = nil;
    spinner = nil;
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
