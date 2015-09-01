//
//  LogBookTableViewController.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface LogBookTableViewController : UITableViewController<UIAlertViewDelegate,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) NSFetchedResultsController *resultController;


@end
