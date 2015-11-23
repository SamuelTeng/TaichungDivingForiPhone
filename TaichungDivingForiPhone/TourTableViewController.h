//
//  TourTableViewController.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface TourTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray * domesticTour;
@property(nonatomic,strong) NSMutableArray *foreignTour;

@end
