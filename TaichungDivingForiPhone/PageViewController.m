//
//  PageViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "PageViewController.h"
#import "ModelControler.h"
#import "LogShowViewController.h"
#import "LogDatabase.h"

@interface PageViewController (){
    
    ModelControler *modelController;
    LogDatabase *logDatabase;
    LogShowViewController *logShowViewController;
    
}

@end

@implementation PageViewController
@synthesize startPage,_section;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    modelController = [[ModelControler alloc] init];
    self.dataSource = modelController;
    
    logDatabase = [LogDatabase new];
    
    /*this is related to AutoLayout but doesn't resolve transition effect issue*/
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    /*The below fix the problem that contents will appear behind the navigation bar and status bar when UIPageView finish the transition effect*/
    self.navigationController.navigationBar.translucent = NO;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    logShowViewController = [[LogShowViewController alloc] init];
    
    logShowViewController.contenPath = [NSIndexPath indexPathForRow:self.startPage inSection:self._section];
    
    //NSLog(@"Page:%li Row & %li Section", startPage,_section);
    
    
    /*set "animated" to "NO" to prevent "UIWindow" issue from happening*/
    
    [self setViewControllers:[NSArray arrayWithObjects:logShowViewController, nil] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    logDatabase = nil;
    logShowViewController = nil;
    modelController = nil;
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
