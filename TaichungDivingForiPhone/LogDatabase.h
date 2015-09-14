//
//  LogDatabase.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LogDatabase : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSFetchedResultsController *resultController;
@property (nonatomic,strong) NSManagedObject *_managedObject;

@property(nonatomic,strong) NSString *logDate;
@property(nonatomic,strong) NSString *logSite;
@property(nonatomic,strong) NSString *logTime;
@property(nonatomic,strong) NSString *logDepth;
@property(nonatomic,strong) NSString *logGas;
@property(nonatomic,strong) NSString *logVisibility;
@property(nonatomic,strong) NSString *logTemperature;
@property(nonatomic,strong) NSString *logStartPressure;
@property(nonatomic,strong) NSString *logEndPressure;
@property(nonatomic,strong) NSString *logWaves;
@property(nonatomic,strong) NSString *logCurrent;
@property(nonatomic,strong) NSString *logMixture;
@property(nonatomic,strong) NSString *logOxygen;
@property(nonatomic,strong) NSString *logNitrogen;
@property(nonatomic,strong) NSString *logHelium;
@property(nonatomic,strong) NSString *logLowppO2;
@property(nonatomic,strong) NSString *logHighppO2;
@property(nonatomic,strong) NSData *logImg;


@property (nonatomic)NSUInteger pages;

-(void)fetchData;
-(NSInteger)numberOfPages;

-(NSString *)date:(NSIndexPath *)indexpath;
-(NSString *)site:(NSIndexPath *)indexpath;
-(NSString *)time:(NSIndexPath *)indexpath;
-(NSString *)depth:(NSIndexPath *)indexpath;
-(NSString *)gas:(NSIndexPath *)indexpath;
-(NSString *)visibility:(NSIndexPath *)indexpath;
-(NSString *)temprature:(NSIndexPath *)indexpath;
-(NSString *)startPressure:(NSIndexPath *)indexpath;
-(NSString *)endPressure:(NSIndexPath *)indexpath;
-(NSString *)waves:(NSIndexPath *)indexpath;
-(NSString *)current:(NSIndexPath *)indexpath;
-(NSString *)mixture:(NSIndexPath *)indexpath;
-(NSString *)oxygen:(NSIndexPath *)indexpath;
-(NSString *)nitrogen:(NSIndexPath *)indexpath;
-(NSString *)helium:(NSIndexPath *)indexpath;
-(NSString *)lowppO2:(NSIndexPath *)indexpath;
-(NSString *)highppO2:(NSIndexPath *)indexpath;
-(NSData *)images:(NSIndexPath *)indexpath;



@end
