//
//  ModelControler.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "ModelControler.h"
#import "LogShowViewController.h"
#import "PageViewController.h"
#import "LogDatabase.h"
#import "AppDelegate.h"

@interface ModelControler (){
    
    AppDelegate *delegate;
    LogShowViewController *contentPage;
    
}

@end


@implementation ModelControler

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    contentPage = (LogShowViewController *)viewController;
    NSInteger currentPage = contentPage.contenPath.row;
    NSInteger currentSection = contentPage.contenPath.section;
    
    
    /*the section from tableview start with 0*/
    if (currentSection <1) {
        return nil;
    }else{
        
        //int page = currentPage;
        NSInteger page = currentPage;
        NSInteger pageSection = contentPage.contenPath.section-1;
        
        contentPage = [[LogShowViewController alloc] init];
        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
        
        return contentPage;
        
    }
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    contentPage = (LogShowViewController *)viewController;
    NSInteger currentPage = contentPage.contenPath.row;
    NSInteger currentSection = contentPage.contenPath.section;
    
    LogDatabase *logDatabase = [LogDatabase new];
    NSInteger total = [logDatabase numberOfPages];
    
    
    
    if (currentSection >= total-1) {
        return nil;
    }else{
        
        //int page = currentPage;
        NSInteger page = currentPage;
        NSInteger pageSection = contentPage.contenPath.section+1;
        contentPage = [[LogShowViewController alloc] init];
        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
        return contentPage;
        
    }
    
}



@end
