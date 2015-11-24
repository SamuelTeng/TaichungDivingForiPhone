//
//  LogShowViewController.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface LogShowViewController : GAITrackedViewController//UIViewController

@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *site;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *airType;
@property (nonatomic,strong) NSString *preSta;
@property (nonatomic,strong) NSString *preEnd;
@property (nonatomic,strong) NSString *maxDep;
@property (nonatomic,strong) NSString *temp;
@property (nonatomic,strong) NSString *visib;
@property (nonatomic,strong) NSString *waves;
@property (nonatomic,strong) NSString *current;
@property (nonatomic,strong) NSString *mixture;
@property (nonatomic,strong) NSString *oxygen;
@property (nonatomic,strong) NSString *nitrogen;
@property (nonatomic,strong) NSString *helium;
@property (nonatomic,strong) NSString *lowppo2;
@property (nonatomic,strong) NSString *highppo2;
@property (nonatomic,strong) NSData *photos;

@property (nonatomic,strong) UIScrollView *logShowView;

@property (nonatomic,strong) NSIndexPath *contenPath;




@end
