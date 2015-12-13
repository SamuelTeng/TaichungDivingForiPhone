//
//  AppDelegate.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MainViewController.h"
#import "FBLoginViewController.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    Reachability *reachability;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UINavigationController *navi;
@property (strong,nonatomic) MainViewController *mainViewController;
@property (strong,nonatomic) FBLoginViewController *loginViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,strong) UIImage *selectedCellImage;

@property (nonatomic) id<GAITracker> tracker;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)reportStatus:(NSString *)pattern;


@end

