//
//  LogViewController.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (readonly , strong ,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UILabel *lowppo2Label;
@property (nonatomic,strong) UILabel *highppo2Label;

@property (nonatomic,strong) UIImageView *dateImg;
@property (nonatomic,strong) UIImage *imgDate;
@property (nonatomic,strong) UIImageView *siteImg;
@property (nonatomic,strong) UIImage *imgSite;
@property (nonatomic,strong) UIImageView *wavesImg;
@property (nonatomic,strong) UIImage *imgWaves;
@property (nonatomic,strong) UIImageView *currentImg;
@property (nonatomic,strong) UIImage *imgCurrent;
@property (nonatomic,strong) UIImageView *gasImg;
@property (nonatomic,strong) UIImage * imgGas;
@property (nonatomic,strong) UIImageView *startImg;
@property (nonatomic,strong) UIImage *imgStart;
@property (nonatomic,strong) UIImageView *endImg;
@property (nonatomic,strong) UIImage *imgEnd;
@property (nonatomic,strong) UIImageView *deptthImg;
@property (nonatomic,strong) UIImage *imgDepth;
@property (nonatomic,strong) UIImageView *durationImg;
@property (nonatomic,strong) UIImage *imgDuration;
@property (nonatomic,strong) UIImageView *tempImg;
@property (nonatomic,strong) UIImage *imgTemp;
@property (nonatomic,strong) UIImageView *visiImg;
@property (nonatomic,strong) UIImage *imgVisi;
@property (nonatomic,strong) UIImageView *mixImg;
@property (nonatomic,strong) UIImage *imgMix;
@property (nonatomic,strong) UIImageView *oxyImg;
@property (nonatomic,strong) UIImage *imgOxy;
@property (nonatomic,strong) UIImageView *nitImg;
@property (nonatomic,strong) UIImage *imgNit;
@property (nonatomic,strong) UIImageView *helImg;
@property (nonatomic,strong) UIImage *imgHel;
@property (nonatomic,strong) UIButton *cameraImg;
@property (nonatomic,strong) UIImage *imgCamera;

@property (nonatomic,strong) UITextField *dateField;
@property (nonatomic,strong) UITextField *siteField;
@property (nonatomic,strong) UITextField *wavesField;
@property (nonatomic,strong) UITextField *currentField;
@property (nonatomic,strong) UITextField *maxDepField;
@property (nonatomic,strong) UITextField *gasField;
@property (nonatomic,strong) UITextField *divetimeField;
@property (nonatomic,strong) UITextField *visiField;
@property (nonatomic,strong) UITextField *temperField;
@property (nonatomic,strong) UITextField *staPreField;
@property (nonatomic,strong) UITextField *endPreField;
@property (nonatomic,strong) UITextField *otherField;
@property (nonatomic,strong) UITextField *mixtureField;
@property (nonatomic,strong) UITextField *oxygenField;
@property (nonatomic,strong) UITextField *nitrogenField;
@property (nonatomic,strong) UITextField *heliumField;
@property (nonatomic,strong) UITextField *lowppo2Field;
@property (nonatomic,strong) UITextField *highppo2Field;

@property (nonatomic,strong) NSString *selectedRow;
@property (nonatomic,strong) NSArray *gasArr;
@property (nonatomic,strong) NSArray *firstRow;
@property (nonatomic,strong) NSArray *secondRow;
@property (nonatomic,strong) NSArray *thirdRow;
@property (nonatomic,strong) NSArray *forthRow;
@property (nonatomic,strong) NSArray *mAndf;
@property (nonatomic,strong) NSArray *cAndf;
@property (nonatomic,strong) NSArray *wavesArr;
@property (nonatomic,strong) NSArray *currentArr;
@property (nonatomic,strong) NSArray *mixtureArr;



@property (nonatomic,strong) NSString *dateFromData;
@property (nonatomic,strong) NSString *wavesFromData;
@property (nonatomic,strong) NSString *currentFromData;
@property (nonatomic,strong) NSString *timeFromData;

@property (nonatomic,assign)NSUInteger logType;

@property (nonatomic,strong) UIImageView *selectedImg;

@property (nonatomic,assign) NSUInteger viewReserved;


@end
