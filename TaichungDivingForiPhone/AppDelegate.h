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
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    Reachability *reachability;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UINavigationController *navi;
@property (strong,nonatomic) MainViewController *mainViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

