//
//  FBLoginViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/12/8.
//  Copyright © 2015年 Samuel Teng. All rights reserved.
//

#import "FBLoginViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

#import "AppDelegate.h"
#import "MainViewController.h"

#import "FBFunction.h"

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

@interface FBLoginViewController ()<FBSDKLoginButtonDelegate>{
    
    
    //UIButton *loginBtn;
    UIButton *withoutLoginBtn;
    AppDelegate *delegate;
    MainViewController *mainViewController;
}

@end

@implementation FBLoginViewController

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
        
        UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-60@2x.png"]];
        [iconImg setFrame:CGRectMake(self.view.center.x-58, self.view.center.y-130, 120, 120)];
        [self.view addSubview:iconImg];
        
        
        
        
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
        [self.view addSubview:backgroundImg];
        
        UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-60@2x.png"]];
        [iconImg setFrame:CGRectMake(self.view.center.x-58, self.view.center.y-130, 120, 120)];
        [self.view addSubview:iconImg];
        
        
        
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
        [self.view addSubview:backgroundImg];
        
        UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-60@2x.png"]];
        [iconImg setFrame:CGRectMake(self.view.center.x-58, self.view.center.y-170, 120, 120)];
        [self.view addSubview:iconImg];
        
        
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
        [self.view addSubview:backgroundImg];
        
        UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-60@3x.png"]];
        [iconImg setFrame:CGRectMake(self.view.center.x-83, self.view.center.y-170, 180, 180)];
        [self.view addSubview:iconImg];
        
        
        
    }
}

-(void)loadView
{
    [super loadView];
    [self detectingDevice];
   
    FBSDKLoginButton *loginBtn = [[FBSDKLoginButton alloc] init];
    
    loginBtn.center = CGPointMake(self.view.center.x, self.view.center.y+20);
    //loginBtn.readPermissions = @[@"public_profile"];
    loginBtn.publishPermissions = @[@"publish_actions"];
    loginBtn.delegate = self;
    [self.view addSubview:loginBtn];
    
    withoutLoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    withoutLoginBtn.backgroundColor = [UIColor clearColor];
    [withoutLoginBtn setFrame:CGRectMake(self.view.center.x-88, self.view.center.y+45, loginBtn.frame.size.width, loginBtn.frame.size.height)];
    [withoutLoginBtn setTitle:NSLocalizedString(@"WithoutLogin", nil) forState:UIControlStateNormal];
    [withoutLoginBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [withoutLoginBtn addTarget:self action:@selector(fowardToMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:withoutLoginBtn];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = NSLocalizedString(@"DivingBook", nil);
    
    /*making navigation bar transparent*/
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    delegate = [[UIApplication sharedApplication] delegate];
    mainViewController = [[MainViewController alloc] init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"登入頁面";
    // Do any additional setup after loading the view.
   
    //FBSDKLoginButton *loginBtn = [[FBSDKLoginButton alloc] init];
    
    
    
}

-(void)fowardToMain
{
    
    [delegate.navi pushViewController:mainViewController animated:NO];
    [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FB Login" action:@"No Login" label:@"Proceed without Login" value:nil]build]];
}


#pragma mark - FBSDKLoginButtonDelegate

- (BOOL) loginButtonWillLogin:(FBSDKLoginButton *)loginButton
{
    return YES;
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
 
    
    if (error) {
        
        NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: NSLocalizedString(@"LoginError", nil);
        NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FB Login" action:@"Error" label:@"Login Error" value:nil]build]];
        
    }else if (result.isCancelled){
        
        [delegate.navi pushViewController:mainViewController animated:NO];
        [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FB Login" action:@"Caceled" label:@"Login Canceled" value:nil]build]];
        
    }else{
        
        if ([result.grantedPermissions containsObject:@"public_profile"]) {
            
            [delegate.navi pushViewController:mainViewController animated:NO];
            
            [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FB Login" action:@"With permission" label:@"Proceed with access to profile at least" value:nil]build]];
            
        }
        
    }
    
    
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
