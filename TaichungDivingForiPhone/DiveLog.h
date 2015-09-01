//
//  DiveLog.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DiveLog : NSManagedObject

@property (nonatomic, retain) NSString * current;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * dive_time;
@property (nonatomic, retain) NSString * end_pressure;
@property (nonatomic, retain) NSString * gas_type;
@property (nonatomic, retain) NSString * helium;
@property (nonatomic, retain) NSString * highppo2;
@property (nonatomic, retain) NSString * lowppo2;
@property (nonatomic, retain) NSString * max_depth;
@property (nonatomic, retain) NSString * mixture;
@property (nonatomic, retain) NSString * nitrogen;
@property (nonatomic, retain) NSString * oxygen;
@property (nonatomic, retain) NSString * site;
@property (nonatomic, retain) NSString * start_pressure;
@property (nonatomic, retain) NSString * temperature;
@property (nonatomic, retain) NSString * visibility;
@property (nonatomic, retain) NSString * waves;

@end
