//
//  LogViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "LogViewController.h"
#import "DiveLog.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"
#import "LogCategoryViewController.h"
#import "PhotoViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "FBFunction.h"

#import "PhotoImagePicker.h"


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


@interface LogViewController ()<FBFunctionDelegate,PhotoImagePickerDelegate>{
    
    AppDelegate *delegate;
    LogBookTableViewController *logBookTableView;
    LogCategoryViewController *logCategory;
    PhotoViewController *photoRoll;
    FBFunction *fbFunction;
    NSString *fbLog;
    UIImage *fbPhotos;
    BOOL fromPostCancel;
    PhotoImagePicker *pickImage;
    
}


@end

static int const MIN_USER_GENERATED_PHOTO_DIMENSION = 480;

@implementation LogViewController

@synthesize managedObjectContext,scrollView,secondRow,selectedRow,siteField,staPreField,dateField,divetimeField,wavesField,currentField,mAndf,maxDepField,temperField,thirdRow,visiField,otherField,gasArr,gasField,dateFromData,wavesFromData,currentFromData,timeFromData,wavesArr,currentArr,logType,mixtureArr,mixtureField,oxygenField,nitrogenField,heliumField,lowppo2Field,lowppo2Label,highppo2Field,highppo2Label;

@synthesize dateImg,deptthImg,durationImg,siteImg,startImg,endImg,gasImg,visiImg,wavesImg,currentImg,tempImg,imgCurrent,imgDate,imgDepth,imgDuration,imgEnd,imgGas,imgSite,imgStart,imgTemp,imgVisi,imgWaves,mixImg,imgMix,oxyImg,imgOxy,nitImg,imgNit,helImg,imgHel,cameraImg,imgCamera;
@synthesize selectedImg,viewReserved;

-(void)detectingDevice
{
    
    if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"IS_IPHONE_4_OR_LESS");
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i4"]];
        [scrollBackground setFrame:scrollView.frame];
        [self.view insertSubview:scrollBackground belowSubview:scrollView];
        
        
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
       [scrollBackground setFrame:scrollView.frame];
        [self.view insertSubview:scrollBackground belowSubview:scrollView];
        
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
        //scrollBackground.contentMode = UIViewContentModeScaleAspectFit;
        [scrollBackground setFrame:scrollView.frame];
        [self.view insertSubview:scrollBackground belowSubview:scrollView];
        
        
        
        
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");
        UIImageView *scrollBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
        [scrollBackground setFrame:scrollView.frame];
        
        [self.view insertSubview:scrollBackground belowSubview:scrollView];
        
    }
}

-(void)images_ini
{
    imgDate = [UIImage imageNamed:@"LogImg.bundle/Date"];
    dateImg = [[UIImageView alloc] initWithImage:imgDate];
    
    imgSite = [UIImage imageNamed:@"LogImg.bundle/Location"];
    siteImg = [[UIImageView alloc] initWithImage:imgSite];
    
    imgWaves = [UIImage imageNamed:@"LogImg.bundle/Waves"];
    wavesImg = [[UIImageView alloc] initWithImage:imgWaves];
    
    imgCurrent = [UIImage imageNamed:@"LogImg.bundle/Current"];
    currentImg = [[UIImageView alloc] initWithImage:imgCurrent];
    
    imgGas = [UIImage imageNamed:@"LogImg.bundle/Diver"];
    gasImg = [[UIImageView alloc] initWithImage:imgGas];
    
    imgStart = [UIImage imageNamed:@"LogImg.bundle/FullTank"];
    startImg = [[UIImageView alloc] initWithImage:imgStart];
    
    imgEnd = [UIImage imageNamed:@"LogImg.bundle/EndTank"];
    endImg = [[UIImageView alloc] initWithImage:imgEnd];
    
    imgDepth = [UIImage imageNamed:@"LogImg.bundle/Depth"];
    deptthImg = [[UIImageView alloc] initWithImage:imgDepth];
    
    imgDuration = [UIImage imageNamed:@"LogImg.bundle/Duration"];
    durationImg = [[UIImageView alloc] initWithImage:imgDuration];
    
    imgTemp = [UIImage imageNamed:@"LogImg.bundle/WTemp"];
    tempImg =[[UIImageView alloc] initWithImage:imgTemp];
    
    imgVisi = [UIImage imageNamed:@"LogImg.bundle/Visibility"];
    visiImg = [[UIImageView alloc] initWithImage:imgVisi];
    
    imgMix = [UIImage imageNamed:@"LogImg.bundle/Mix"];
    mixImg = [[UIImageView alloc] initWithImage:imgMix];
    
    imgOxy = [UIImage imageNamed:@"LogImg.bundle/Oxy"];
    oxyImg = [[UIImageView alloc] initWithImage:imgOxy];
    
    imgNit = [UIImage imageNamed:@"LogImg.bundle/Nitro"];
    nitImg = [[UIImageView alloc] initWithImage:imgNit];
    
    imgHel = [UIImage imageNamed:@"LogImg.bundle/He"];
    helImg = [[UIImageView alloc] initWithImage:imgHel];
    
    imgCamera = [UIImage imageNamed:@"LogImg.bundle/Camera_roll"];
    cameraImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraImg setBackgroundImage:imgCamera forState:UIControlStateNormal];
    
}

-(void)fowardToPhoto:(id)sender
{
    /*
    [delegate.navi pushViewController:photoRoll animated:NO];
    viewReserved = 1;
    */
    pickImage = [[PhotoImagePicker alloc] init];
    pickImage.delegate = self;
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) && [sender isKindOfClass:[UIView class]]) {
        UIView *senderView = (UIView *)sender;
        UIView *view = self.view;
        [pickImage presentFromRect:[view convertRect:senderView.bounds fromView:senderView] inView:self.view];
        viewReserved = 1;
    } else {
        [pickImage presentWithViewController:self];
        viewReserved = 1;
    }
}

-(void)loadView
{
    
    [super loadView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1700);
    scrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:scrollView];
    
    [self detectingDevice];
    [self images_ini];
    
    gasArr = [NSArray arrayWithObjects:NSLocalizedString(@"Air", nil),NSLocalizedString(@"Nitro", nil),NSLocalizedString(@"CCR", nil), nil];
    _firstRow = [NSArray arrayWithObjects:@" ",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    secondRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    thirdRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _forthRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    mAndf = [NSArray arrayWithObjects:NSLocalizedString(@"Meter", nil),NSLocalizedString(@"Feet", nil), nil];
    _cAndf = [NSArray arrayWithObjects:@"°C",@"°F", nil];
    
    wavesArr = [NSArray arrayWithObjects:NSLocalizedString(@"Flat", nil),NSLocalizedString(@"Small", nil),NSLocalizedString(@"Medium", nil),NSLocalizedString(@"Strong", nil), nil];
    currentArr = [NSArray arrayWithObjects:NSLocalizedString(@"Yes", nil),NSLocalizedString(@"No", nil), nil];
    
    mixtureArr = [NSArray arrayWithObjects:NSLocalizedString(@"Air", nil),@"EAN32",@"EAN36",@"Trimix21/35",@"Trimix18/45",@"Trimix15/55", nil];
    
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"ic_save_black_24dp.png"] style:UIBarButtonItemStylePlain target:self action:@selector(publishALert)];
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
    
    
    
    delegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = delegate.managedObjectContext;
    
    logBookTableView = [[LogBookTableViewController alloc] init];
    logCategory = [[LogCategoryViewController alloc] init];
    photoRoll = [[PhotoViewController alloc] init];
    
    
    fromPostCancel = NO;
    
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.screenName = @"Log Input";
    
    switch (viewReserved) {
        case 0:
            
            switch (logType) {
                case 0:
                    
                    [self textAndLabel];
                    
                    break;
                    
                case 1:
                    
                    [self nitroxTextAndLabel];
                    
                    break;
                    
                case 2:
                    
                    [self closedCircuitTextAndLabel];
                    
                    break;
                    
                default:
                    break;
            }
            
            break;
            
        case 1:
            
            selectedImg.image = delegate.selectedCellImage;
            
            break;
            
        
            
        default:
            break;
    }
    
    
    
}

-(void)publishALert
{
    UIAlertView *publish = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Facebook", nil) message:NSLocalizedString(@"FacebookM", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Saved", nil) otherButtonTitles:NSLocalizedString(@"Post", nil), nil];
    [publish show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            if (fromPostCancel != NO) {
                
                
            }else{
                
                [self saveToData];
            }
            
            
            
            break;
            
        case 1:
            [self saveToData];
            if (fbPhotos == nil){
                
                //[fbFunction FBSharing:fbLog];
                
            }else{
                
                if (fbPhotos && ([fbPhotos size].height < MIN_USER_GENERATED_PHOTO_DIMENSION || [fbPhotos size].width < MIN_USER_GENERATED_PHOTO_DIMENSION)) {
                    
                    fromPostCancel = YES;
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:[NSString stringWithFormat:@"%@%d%@", @"This photo is too small. Choose a photo with dimensions larger than ", MIN_USER_GENERATED_PHOTO_DIMENSION, @"px."]
                                          message:nil
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                
                fbFunction = [[FBFunction alloc] initWithTitle:@"非潛不可" contents:fbLog photo:fbPhotos];
                fbFunction.delegate = self;
                [fbFunction start];

            }
            
            break;
            
        default:
            break;
    }
}

-(void)saveToData
{
    
    switch (logType) {
        case 0:
        {
            if (selectedImg.image == nil) {
                
                NSString *dateStr = dateField.text;
                NSLog(@"%@",dateStr);
                
                
                NSString *site = siteField.text;
                
                
                
                NSString *waves = wavesField.text;
                
                
                NSString *current= currentField.text;
                
                
                
                NSString *maxDepth = maxDepField.text;
                
                
                NSString *gasType = gasField.text;
                
                
                NSString *diveTime = divetimeField.text;
                NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
                [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
                
                
                NSString *visibility = visiField.text;
                
                
                NSString *temperature = temperField.text;
                
                
                NSString *startPressure = staPreField.text;
                
                
                
                NSString *endPressure = _endPreField.text;
                
                fbLog = [NSString stringWithFormat:NSLocalizedString(@"Log", nil), dateStr,site,diveTime,gasType,startPressure,endPressure,maxDepth,temperature,visibility,current,waves];
                
                dateField.text = nil;
                siteField.text = nil;
                wavesField.text = nil;
                currentField.text = nil;
                maxDepField.text = nil;
                gasField.text = nil;
                divetimeField.text = nil;
                visiField.text = nil;
                temperField.text = nil;
                staPreField.text = nil;
                _endPreField.text = nil;
                
                DiveLog *database = (DiveLog *)[NSEntityDescription insertNewObjectForEntityForName:@"DiveLog" inManagedObjectContext:managedObjectContext];
                
                database.date = dateStr;
                database.site = site;
                database.waves = waves;
                database.current = current;
                database.max_depth = maxDepth;
                database.gas_type = gasType;
                database.dive_time = _diveTime;
                database.visibility = visibility;
                database.temperature = temperature;
                database.start_pressure = startPressure;
                database.end_pressure = endPressure;
                
                
                
                NSError *error;
                if (![managedObjectContext save:&error]) {
                    NSLog(@"error:%@", [error localizedFailureReason]);
                }
                
                
                viewReserved = 0;
                
                
                [delegate.navi pushViewController:logBookTableView animated:YES];
                
            } else {
                
                NSString *dateStr = dateField.text;
                NSLog(@"%@",dateStr);
                
                
                NSString *site = siteField.text;
                
                
                
                NSString *waves = wavesField.text;
                
                
                NSString *current= currentField.text;
                
                
                
                NSString *maxDepth = maxDepField.text;
                
                
                NSString *gasType = gasField.text;
                
                
                NSString *diveTime = divetimeField.text;
                NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
                [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
                
                
                NSString *visibility = visiField.text;
                
                
                NSString *temperature = temperField.text;
                
                
                NSString *startPressure = staPreField.text;
                
                
                
                NSString *endPressure = _endPreField.text;
                
                NSData *photoData = [NSData dataWithData:UIImagePNGRepresentation(selectedImg.image)];
                
                fbLog = [NSString stringWithFormat:NSLocalizedString(@"Log", nil), dateStr,site,diveTime,gasType,startPressure,endPressure,maxDepth,temperature,visibility,current,waves];
                fbPhotos = selectedImg.image;
                
                dateField.text = nil;
                siteField.text = nil;
                wavesField.text = nil;
                currentField.text = nil;
                maxDepField.text = nil;
                gasField.text = nil;
                divetimeField.text = nil;
                visiField.text = nil;
                temperField.text = nil;
                staPreField.text = nil;
                _endPreField.text = nil;
                selectedImg.image = nil;
                delegate.selectedCellImage = nil;
                
                DiveLog *database = (DiveLog *)[NSEntityDescription insertNewObjectForEntityForName:@"DiveLog" inManagedObjectContext:managedObjectContext];
                
                database.date = dateStr;
                database.site = site;
                database.waves = waves;
                database.current = current;
                database.max_depth = maxDepth;
                database.gas_type = gasType;
                database.dive_time = _diveTime;
                database.visibility = visibility;
                database.temperature = temperature;
                database.start_pressure = startPressure;
                database.end_pressure = endPressure;
                database.photos = photoData;
                
                
                NSError *error;
                if (![managedObjectContext save:&error]) {
                    NSLog(@"error:%@", [error localizedFailureReason]);
                }
                
                
                viewReserved = 0;
                
                
                [delegate.navi pushViewController:logBookTableView animated:YES];
                
            }
            
            NSString *savedlog = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Air", nil), @"Saved"];
            [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Input Logs" action:@"Log Saved" label:savedlog value:nil]build]];
            
        }
            break;
            
        case 1:
        {
           
            if (selectedImg.image == nil) {
                
                NSString *dateStr = dateField.text;
                NSLog(@"%@",dateStr);
                
                
                NSString *site = siteField.text;
                
                
                
                NSString *waves = wavesField.text;
                
                
                NSString *current= currentField.text;
                
                
                
                NSString *maxDepth = maxDepField.text;
                
                
                NSString *gasType = gasField.text;
                
                
                NSString *diveTime = divetimeField.text;
                NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
                [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
                
                
                NSString *visibility = visiField.text;
                
                
                NSString *temperature = temperField.text;
                
                
                NSString *startPressure = staPreField.text;
                //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
                //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
                
                
                NSString *endPressure = _endPreField.text;
                //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
                NSString *_mixture = mixtureField.text;
                
                NSString *_oxygen = oxygenField.text;
                
                NSString *_nitrogen = nitrogenField.text;
                
                fbLog = [NSString stringWithFormat:NSLocalizedString(@"NitroL", nil), dateStr,site,diveTime,gasType,startPressure,endPressure,_mixture,_oxygen,_nitrogen,maxDepth,temperature,visibility,current,waves];
                
                dateField.text = nil;
                siteField.text = nil;
                wavesField.text = nil;
                currentField.text = nil;
                maxDepField.text = nil;
                gasField.text = nil;
                divetimeField.text = nil;
                visiField.text = nil;
                temperField.text = nil;
                staPreField.text = nil;
                _endPreField.text = nil;
                mixtureField.text = nil;
                oxygenField.text = nil;
                nitrogenField.text = nil;
                
                DiveLog *database = (DiveLog *)[NSEntityDescription insertNewObjectForEntityForName:@"DiveLog" inManagedObjectContext:managedObjectContext];
                
                database.date = dateStr;
                database.site = site;
                database.waves = waves;
                database.current = current;
                database.max_depth = maxDepth;
                database.gas_type = gasType;
                database.dive_time = _diveTime;
                database.visibility = visibility;
                database.temperature = temperature;
                database.start_pressure = startPressure;
                database.end_pressure = endPressure;
                database.mixture = _mixture;
                database.oxygen = _oxygen;
                database.nitrogen = _nitrogen;
                
                
                NSError *error;
                if (![managedObjectContext save:&error]) {
                    NSLog(@"error:%@", [error localizedFailureReason]);
                }
                
                
                viewReserved = 0;
                
                [delegate.navi pushViewController:logBookTableView animated:YES];
                

                
            } else {
                
                NSString *dateStr = dateField.text;
                NSLog(@"%@",dateStr);
                
                
                NSString *site = siteField.text;
                
                
                
                NSString *waves = wavesField.text;
                
                
                NSString *current= currentField.text;
                
                
                
                NSString *maxDepth = maxDepField.text;
                
                
                NSString *gasType = gasField.text;
                
                
                NSString *diveTime = divetimeField.text;
                NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
                [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
                
                
                NSString *visibility = visiField.text;
                
                
                NSString *temperature = temperField.text;
                
                
                NSString *startPressure = staPreField.text;
                //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
                //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
                
                
                NSString *endPressure = _endPreField.text;
                //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
                NSString *_mixture = mixtureField.text;
                
                NSString *_oxygen = oxygenField.text;
                
                NSString *_nitrogen = nitrogenField.text;
                
                NSData *photoData = [NSData dataWithData:UIImagePNGRepresentation(selectedImg.image)];
                
                fbLog = [NSString stringWithFormat:NSLocalizedString(@"NitroL", nil), dateStr,site,diveTime,gasType,startPressure,endPressure,_mixture,_oxygen,_nitrogen,maxDepth,temperature,visibility,current,waves];
                
                fbPhotos = selectedImg.image;
                
                dateField.text = nil;
                siteField.text = nil;
                wavesField.text = nil;
                currentField.text = nil;
                maxDepField.text = nil;
                gasField.text = nil;
                divetimeField.text = nil;
                visiField.text = nil;
                temperField.text = nil;
                staPreField.text = nil;
                _endPreField.text = nil;
                mixtureField.text = nil;
                oxygenField.text = nil;
                nitrogenField.text = nil;
                selectedImg.image = nil;
                delegate.selectedCellImage = nil;
                
                DiveLog *database = (DiveLog *)[NSEntityDescription insertNewObjectForEntityForName:@"DiveLog" inManagedObjectContext:managedObjectContext];
                
                database.date = dateStr;
                database.site = site;
                database.waves = waves;
                database.current = current;
                database.max_depth = maxDepth;
                database.gas_type = gasType;
                database.dive_time = _diveTime;
                database.visibility = visibility;
                database.temperature = temperature;
                database.start_pressure = startPressure;
                database.end_pressure = endPressure;
                database.mixture = _mixture;
                database.oxygen = _oxygen;
                database.nitrogen = _nitrogen;
                database.photos = photoData;
                
                
                NSError *error;
                if (![managedObjectContext save:&error]) {
                    NSLog(@"error:%@", [error localizedFailureReason]);
                }
                
                
                viewReserved = 0;
                
                [delegate.navi pushViewController:logBookTableView animated:YES];
                
                
            }
            
             NSString *savedlog = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Nitro", nil), @"Saved"];
            [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Input Logs" action:@"Log Saved" label:savedlog value:nil]build]];

                
            }
            
            break;
            
        case 2:
        {
            if (selectedImg.image == nil) {
                
                NSString *dateStr = dateField.text;
                NSLog(@"%@",dateStr);
                
                
                NSString *site = siteField.text;
                
                
                
                NSString *waves = wavesField.text;
                
                
                NSString *current= currentField.text;
                
                
                
                NSString *maxDepth = maxDepField.text;
                
                
                NSString *gasType = gasField.text;
                
                
                NSString *diveTime = divetimeField.text;
                NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
                [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
                
                
                NSString *visibility = visiField.text;
                
                
                NSString *temperature = temperField.text;
                
                
                NSString *startPressure = staPreField.text;
                //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
                //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
                
                
                NSString *endPressure = _endPreField.text;
                //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
                NSString *_mixture = mixtureField.text;
                
                NSString *_oxygen = oxygenField.text;
                
                NSString *_nitrogen = nitrogenField.text;
                
                NSString *_helium = heliumField.text;
                
                NSString *_lowPPO2 = lowppo2Field.text;
                
                NSString *_highPPO2 = highppo2Field.text;
                
                fbLog = [NSString stringWithFormat:NSLocalizedString(@"CCRL", nil), dateStr,site,diveTime,gasType,startPressure,endPressure,_mixture,_oxygen,_nitrogen,_helium,_lowPPO2,_highPPO2,maxDepth,temperature,visibility,current,waves];
                
                dateField.text = nil;
                siteField.text = nil;
                wavesField.text = nil;
                currentField.text = nil;
                maxDepField.text = nil;
                gasField.text = nil;
                divetimeField.text = nil;
                visiField.text = nil;
                temperField.text = nil;
                staPreField.text = nil;
                _endPreField.text = nil;
                mixtureField.text = nil;
                oxygenField.text = nil;
                nitrogenField.text = nil;
                heliumField.text = nil;
                lowppo2Field.text = nil;
                highppo2Field.text = nil;
                
                DiveLog *database = (DiveLog *)[NSEntityDescription insertNewObjectForEntityForName:@"DiveLog" inManagedObjectContext:managedObjectContext];
                
                database.date = dateStr;
                database.site = site;
                database.waves = waves;
                database.current = current;
                database.max_depth = maxDepth;
                database.gas_type = gasType;
                database.dive_time = _diveTime;
                database.visibility = visibility;
                database.temperature = temperature;
                database.start_pressure = startPressure;
                database.end_pressure = endPressure;
                database.mixture = _mixture;
                database.oxygen = _oxygen;
                database.nitrogen = _nitrogen;
                database.helium = _helium;
                database.lowppo2 = _lowPPO2;
                database.highppo2 = _highPPO2;
                
                NSError *error;
                if (![managedObjectContext save:&error]) {
                    NSLog(@"error:%@", [error localizedFailureReason]);
                }
                
                
                viewReserved = 0;
                
                [delegate.navi pushViewController:logBookTableView animated:YES];
                
            } else {
                
                NSString *dateStr = dateField.text;
                NSLog(@"%@",dateStr);
                
                
                NSString *site = siteField.text;
                
                
                
                NSString *waves = wavesField.text;
                
                
                NSString *current= currentField.text;
                
                
                
                NSString *maxDepth = maxDepField.text;
                
                
                NSString *gasType = gasField.text;
                
                
                NSString *diveTime = divetimeField.text;
                NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
                [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
                
                
                NSString *visibility = visiField.text;
                
                
                NSString *temperature = temperField.text;
                
                
                NSString *startPressure = staPreField.text;
                //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
                //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
                
                
                NSString *endPressure = _endPreField.text;
                //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
                //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
                NSString *_mixture = mixtureField.text;
                
                NSString *_oxygen = oxygenField.text;
                
                NSString *_nitrogen = nitrogenField.text;
                
                NSString *_helium = heliumField.text;
                
                NSString *_lowPPO2 = lowppo2Field.text;
                
                NSString *_highPPO2 = highppo2Field.text;
                
                NSData *photoData = [NSData dataWithData:UIImagePNGRepresentation(selectedImg.image)];
                
                fbLog = [NSString stringWithFormat:NSLocalizedString(@"CCRL", nil), dateStr,site,diveTime,gasType,startPressure,endPressure,_mixture,_oxygen,_nitrogen,_helium,_lowPPO2,_highPPO2,maxDepth,temperature,visibility,current,waves];
                
                fbPhotos = selectedImg.image;
                
                dateField.text = nil;
                siteField.text = nil;
                wavesField.text = nil;
                currentField.text = nil;
                maxDepField.text = nil;
                gasField.text = nil;
                divetimeField.text = nil;
                visiField.text = nil;
                temperField.text = nil;
                staPreField.text = nil;
                _endPreField.text = nil;
                mixtureField.text = nil;
                oxygenField.text = nil;
                nitrogenField.text = nil;
                heliumField.text = nil;
                lowppo2Field.text = nil;
                highppo2Field.text = nil;
                selectedImg.image = nil;
                delegate.selectedCellImage = nil;
                
                
                DiveLog *database = (DiveLog *)[NSEntityDescription insertNewObjectForEntityForName:@"DiveLog" inManagedObjectContext:managedObjectContext];
                
                database.date = dateStr;
                database.site = site;
                database.waves = waves;
                database.current = current;
                database.max_depth = maxDepth;
                database.gas_type = gasType;
                database.dive_time = _diveTime;
                database.visibility = visibility;
                database.temperature = temperature;
                database.start_pressure = startPressure;
                database.end_pressure = endPressure;
                database.mixture = _mixture;
                database.oxygen = _oxygen;
                database.nitrogen = _nitrogen;
                database.helium = _helium;
                database.lowppo2 = _lowPPO2;
                database.highppo2 = _highPPO2;
                database.photos = photoData;
                
                NSError *error;
                if (![managedObjectContext save:&error]) {
                    NSLog(@"error:%@", [error localizedFailureReason]);
                }
                
                
                viewReserved = 0;
                
                [delegate.navi pushViewController:logBookTableView animated:YES];
            }
            
            NSString *savedlog = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"CCR", nil), @"Saved"];
            [delegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Input Logs" action:@"Log Saved" label:savedlog value:nil]build]];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}

-(NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc ] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *formatData = [dateFormatter stringFromDate:date];
    return formatData;
    
}

-(void)updateDateField:(id)sender
{
    UIDatePicker *picker =(UIDatePicker *) dateField.inputView;
    dateField.text = [self formatDate:picker.date];
}

-(void)donePicking:(id)sender
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)aPickerView
{
    if (aPickerView.tag == 201) {
        return 1;
    }else if (aPickerView.tag == 202){
        return 3;
    }else if (aPickerView.tag == 203){
        return 3;
    }else if (aPickerView.tag == 204){
        return 5;
    }else if (aPickerView.tag == 205){
        return 5;
    }else if (aPickerView.tag == 206){
        return 4;
    }else if (aPickerView.tag == 207){
        return 1;
    }else if (aPickerView.tag == 208){
        return 1;
    }else if (aPickerView.tag == 209){
        return 1;
    }else if (aPickerView.tag == 210){
        return 3;
    }else if (aPickerView.tag == 211){
        return 3;
    }else if (aPickerView.tag == 212){
        return 3;
    }else if (aPickerView.tag == 213){
        return 3;
    }else if (aPickerView.tag == 214){
        return 3;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)_pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerView.tag == 201) {
        return [gasArr count];
    }else if (_pickerView.tag == 202){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 203){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 204){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [_forthRow count];
        }else if (component == 4){
            return [mAndf count];
        }
        
    }else if (_pickerView.tag == 205){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [_forthRow count];
        }else if (component == 4){
            return [_cAndf count];
        }
    }else if (_pickerView.tag == 206){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [mAndf count];
        }
        
    }else if (_pickerView.tag == 207){
        return [wavesArr count];
    }else if (_pickerView.tag == 208){
        return [currentArr count];
    }else if (_pickerView.tag == 209){
        return [mixtureArr count];
    }else if (_pickerView.tag == 210){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 211){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 212){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 213){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (_pickerView.tag == 214){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }
    
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)bPickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (bPickerView.tag == 207) {
        UILabel *waveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
        waveLabel.text = [wavesArr objectAtIndex:row];
        waveLabel.adjustsFontSizeToFitWidth = YES;
        waveLabel.textAlignment = NSTextAlignmentCenter;
        waveLabel.font = [UIFont systemFontOfSize:20];
        return waveLabel;
    }else if (bPickerView.tag == 208){
        UILabel *current_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
        current_Label.text = [currentArr objectAtIndex:row];
        current_Label.adjustsFontSizeToFitWidth = YES;
        current_Label.textAlignment = NSTextAlignmentCenter;
        current_Label.font = [UIFont systemFontOfSize:20];
        return current_Label;
    }else if (bPickerView.tag == 201){
        UILabel *gas_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
        gas_Label.text = [gasArr objectAtIndex:row];
        gas_Label.adjustsFontSizeToFitWidth = YES;
        gas_Label.textAlignment = NSTextAlignmentCenter;
        gas_Label.font = [UIFont systemFontOfSize:20.0];
        return gas_Label;
    }else if (bPickerView.tag == 202){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }else if (bPickerView.tag == 203){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
    }else if (bPickerView.tag == 204){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }else if (component == 3){
            UILabel *forth_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            forth_row.text = [_forthRow objectAtIndex:row];
            forth_row.adjustsFontSizeToFitWidth = YES;
            forth_row.textAlignment = NSTextAlignmentCenter;
            forth_row.font = [UIFont systemFontOfSize:20.0];
            return forth_row;
        }else if (component == 4){
            UILabel *parameter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            parameter.text = [mAndf objectAtIndex:row];
            parameter.adjustsFontSizeToFitWidth = YES;
            parameter.textAlignment = NSTextAlignmentCenter;
            parameter.font = [UIFont systemFontOfSize:20.0];
            return parameter;
        }
    }else if (bPickerView.tag == 205){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }else if (component == 3){
            UILabel *forth_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            forth_row.text = [_forthRow objectAtIndex:row];
            forth_row.adjustsFontSizeToFitWidth = YES;
            forth_row.textAlignment = NSTextAlignmentCenter;
            forth_row.font = [UIFont systemFontOfSize:20.0];
            return forth_row;
        }else if (component == 4){
            UILabel *temperture = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            temperture.text = [_cAndf objectAtIndex:row];
            temperture.adjustsFontSizeToFitWidth = YES;
            temperture.textAlignment = NSTextAlignmentCenter;
            temperture.font = [UIFont systemFontOfSize:20.0];
            return temperture;
        }
    }else if (bPickerView.tag == 206){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }else if (component == 3){
            UILabel *parameter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            parameter.text = [mAndf objectAtIndex:row];
            parameter.adjustsFontSizeToFitWidth = YES;
            parameter.textAlignment = NSTextAlignmentCenter;
            parameter.font = [UIFont systemFontOfSize:20.0];
            return parameter;
        }
        
    }else if (bPickerView.tag == 209){
        UILabel *mixture_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
        mixture_Label.text = [mixtureArr objectAtIndex:row];
        mixture_Label.adjustsFontSizeToFitWidth = YES;
        mixture_Label.textAlignment = NSTextAlignmentCenter;
        mixture_Label.font = [UIFont systemFontOfSize:20.0];
        return mixture_Label;
    }else if (bPickerView.tag == 210){
        
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }else if (bPickerView.tag == 211){
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }else if (bPickerView.tag == 211){
        
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }else if (bPickerView.tag == 212){
        
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }else if (bPickerView.tag == 213){
        
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }else if (bPickerView.tag == 214){
        
        if (component == 0) {
            UILabel *first_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            first_row.text = [_firstRow objectAtIndex:row];
            first_row.adjustsFontSizeToFitWidth = YES;
            first_row.textAlignment = NSTextAlignmentCenter;
            first_row.font = [UIFont systemFontOfSize:20.0];
            return first_row;
            
        }else if (component == 1){
            UILabel *second_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            second_row.text = [secondRow objectAtIndex:row];
            second_row.adjustsFontSizeToFitWidth = YES;
            second_row.textAlignment = NSTextAlignmentCenter;
            second_row.font = [UIFont systemFontOfSize:20.0];
            return second_row;
        }else if (component == 2){
            UILabel *third_row = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [bPickerView rowSizeForComponent:component].width, [bPickerView rowSizeForComponent:component].height)];
            third_row.text = [thirdRow objectAtIndex:row];
            third_row.adjustsFontSizeToFitWidth = YES;
            third_row.textAlignment = NSTextAlignmentCenter;
            third_row.font = [UIFont systemFontOfSize:20.0];
            return third_row;
        }
        
    }
    return NULL;
}


- (void)pickerView:(UIPickerView *)aPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (aPickerView.tag == 201) {
        NSInteger row = [aPickerView selectedRowInComponent:0];
        selectedRow = [gasArr objectAtIndex:row];
        gasField.text = selectedRow;
    }else if (aPickerView.tag == 202){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        staPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 203){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        _endPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 204){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        NSInteger row4 = [aPickerView selectedRowInComponent:3];
        NSInteger row5 = [aPickerView selectedRowInComponent:4];
        maxDepField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
    }else if (aPickerView.tag == 205){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        NSInteger row4 = [aPickerView selectedRowInComponent:3];
        NSInteger row5 = [aPickerView selectedRowInComponent:4];
        temperField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[_cAndf objectAtIndex:row5]];
    }else if (aPickerView.tag == 206){
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        NSInteger row4 = [aPickerView selectedRowInComponent:3];
        visiField.text = [NSString stringWithFormat:@"%@%@%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
    }else if (aPickerView.tag == 207){
        NSInteger row = [aPickerView selectedRowInComponent:0];
        selectedRow = [wavesArr objectAtIndex:row];
        wavesField.text = selectedRow;
    }else if (aPickerView.tag == 208){
        NSInteger row = [aPickerView selectedRowInComponent:0];
        selectedRow = [currentArr objectAtIndex:row];
        currentField.text = selectedRow;
    }else if (aPickerView.tag == 209){
        
        NSInteger row = [aPickerView selectedRowInComponent:0];
        selectedRow = [mixtureArr objectAtIndex:row];
        mixtureField.text = selectedRow;
    }else if (aPickerView.tag == 210){
        
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        oxygenField.text = [NSString stringWithFormat:@"%@ %@ %@ %%",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 211){
        
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        nitrogenField.text = [NSString stringWithFormat:@"%@ %@ %@ %%",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 212){
        
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        heliumField.text = [NSString stringWithFormat:@"%@ %@ %@ %%",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 213){
        
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        lowppo2Field.text = [NSString stringWithFormat:@"%@. %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (aPickerView.tag == 214){
        
        NSInteger row1 = [aPickerView selectedRowInComponent:0];
        NSInteger row2 = [aPickerView selectedRowInComponent:1];
        NSInteger row3 = [aPickerView selectedRowInComponent:2];
        highppo2Field.text = [NSString stringWithFormat:@"%@. %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
    if (aTextField.tag == 101) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;//UIDatePickerModeDate;
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:-31536000];
        //[NSDate dateWithTimeIntervalSinceNow:-31536000];
        [datePicker setDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
        aTextField.inputView = datePicker;
        aTextField.text = [self formatDate:datePicker.date];
        
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 102){
        
        aTextField.returnKeyType = UIReturnKeyDone;
        
    }else if (aTextField.tag == 103){
        
        UIPickerView *wavePicker = [[UIPickerView alloc] init];
        wavePicker.delegate = self;
        wavePicker.dataSource = self;
        wavePicker.showsSelectionIndicator = YES;
        [wavePicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [wavePicker setTag:207];
        
        aTextField.inputView = wavePicker;
        NSInteger row = [wavePicker selectedRowInComponent:0];
        aTextField.text = [wavesArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 104){
        
        UIPickerView *currentPicker = [[UIPickerView alloc] init];
        currentPicker.delegate = self;
        currentPicker.dataSource = self;
        currentPicker.showsSelectionIndicator = YES;
        [currentPicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [currentPicker setTag:208];
        
        aTextField.inputView = currentPicker;
        NSInteger row = [currentPicker selectedRowInComponent:0];
        aTextField.text = [currentArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 105){
        
        UIPickerView *gasPicker = [[UIPickerView alloc] init];
        gasPicker.delegate = self;
        gasPicker.dataSource = self;
        gasPicker.showsSelectionIndicator = YES;
        [gasPicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [gasPicker setTag:201];
        
        aTextField.inputView = gasPicker;
        NSInteger row = [gasPicker selectedRowInComponent:0];
        aTextField.text = [gasArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 106){
        
        UIPickerView *staPre = [[UIPickerView alloc] init];
        staPre.delegate = self;
        staPre.dataSource = self;
        staPre.showsSelectionIndicator = YES;
        [staPre setFrame:CGRectMake(0, 480, 320, 180)];
        [staPre setTag:202];
        
        aTextField.inputView = staPre;
        NSInteger row1 = [staPre selectedRowInComponent:0];
        NSInteger row2 = [staPre selectedRowInComponent:1];
        NSInteger row3 = [staPre selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 107){
        
        UIPickerView *endPre = [[UIPickerView alloc] init];
        endPre.delegate = self;
        endPre.dataSource = self;
        endPre.showsSelectionIndicator = YES;
        [endPre setFrame:CGRectMake(0, 480, 320, 180)];
        [endPre setTag:203];
        
        aTextField.inputView = endPre;
        NSInteger row1 = [endPre selectedRowInComponent:0];
        NSInteger row2 = [endPre selectedRowInComponent:1];
        NSInteger row3 = [endPre selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 108){
        
        UIPickerView *maxD = [[UIPickerView alloc] init];
        maxD.delegate = self;
        maxD.dataSource = self;
        maxD.showsSelectionIndicator = YES;
        [maxD setFrame:CGRectMake(0, 480, 320, 180)];
        [maxD setTag:204];
        
        aTextField.inputView = maxD;
        NSInteger row1 = [maxD selectedRowInComponent:0];
        NSInteger row2 = [maxD selectedRowInComponent:1];
        NSInteger row3 = [maxD selectedRowInComponent:2];
        NSInteger row4 = [maxD selectedRowInComponent:3];
        NSInteger row5 = [maxD selectedRowInComponent:4];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 109){
        UIPickerView *temp = [[UIPickerView alloc] init];
        temp.delegate = self;
        temp.dataSource = self;
        temp.showsSelectionIndicator = YES;
        [temp setFrame:CGRectMake(0, 480, 320, 180)];
        [temp setTag:205];
        
        aTextField.inputView = temp;
        NSInteger row1 = [temp selectedRowInComponent:0];
        NSInteger row2 = [temp selectedRowInComponent:1];
        NSInteger row3 = [temp selectedRowInComponent:2];
        NSInteger row4 = [temp selectedRowInComponent:3];
        NSInteger row5 = [temp selectedRowInComponent:4];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[_cAndf objectAtIndex:row5]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 110){
        UIPickerView *visi = [[UIPickerView alloc] init];
        visi.delegate = self;
        visi.dataSource = self;
        visi.showsSelectionIndicator = YES;
        [visi setFrame:CGRectMake(0, 480, 320, 180)];
        [visi setTag:206];
        
        aTextField.inputView = visi;
        NSInteger row1 = [visi selectedRowInComponent:0];
        NSInteger row2 = [visi selectedRowInComponent:1];
        NSInteger row3 = [visi selectedRowInComponent:2];
        NSInteger row4 = [visi selectedRowInComponent:3];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 111){
        
        aTextField.keyboardType = UIKeyboardTypeNumberPad;//UIKeyboardTypeNumbersAndPunctuation;
        aTextField.returnKeyType = UIReturnKeyDone;
        
    }else if (aTextField.tag == 112){
        
        UIPickerView *mixturePicker = [[UIPickerView alloc] init];
        mixturePicker.delegate = self;
        mixturePicker.dataSource = self;
        mixturePicker.showsSelectionIndicator = YES;
        [mixturePicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [mixturePicker setTag:209];
        
        aTextField.inputView = mixturePicker;
        NSInteger row = [mixturePicker selectedRowInComponent:0];
        aTextField.text = [mixtureArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
        
        
    }else if (aTextField.tag == 113){
        
        UIPickerView *oxygen = [[UIPickerView alloc] init];
        oxygen.delegate = self;
        oxygen.dataSource = self;
        oxygen.showsSelectionIndicator = YES;
        [oxygen setFrame:CGRectMake(0, 480, 320, 180)];
        [oxygen setTag:210];
        
        aTextField.inputView = oxygen;
        NSInteger row1 = [oxygen selectedRowInComponent:0];
        NSInteger row2 = [oxygen selectedRowInComponent:1];
        NSInteger row3 = [oxygen selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@ %%",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 114){
        
        UIPickerView *nitrogen = [[UIPickerView alloc] init];
        nitrogen.delegate = self;
        nitrogen.dataSource = self;
        nitrogen.showsSelectionIndicator = YES;
        [nitrogen setFrame:CGRectMake(0, 480, 320, 180)];
        [nitrogen setTag:211];
        
        aTextField.inputView = nitrogen;
        NSInteger row1 = [nitrogen selectedRowInComponent:0];
        NSInteger row2 = [nitrogen selectedRowInComponent:1];
        NSInteger row3 = [nitrogen selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@ %%",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 115){
        
        UIPickerView *helium = [[UIPickerView alloc] init];
        helium.delegate = self;
        helium.dataSource = self;
        helium.showsSelectionIndicator = YES;
        [helium setFrame:CGRectMake(0, 480, 320, 180)];
        [helium setTag:212];
        
        aTextField.inputView = helium;
        NSInteger row1 = [helium selectedRowInComponent:0];
        NSInteger row2 = [helium selectedRowInComponent:1];
        NSInteger row3 = [helium selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@ %%",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 116){
        
        UIPickerView *lowppO2 = [[UIPickerView alloc] init];
        lowppO2.delegate = self;
        lowppO2.dataSource = self;
        lowppO2.showsSelectionIndicator = YES;
        [lowppO2 setFrame:CGRectMake(0, 480, 320, 180)];
        [lowppO2 setTag:213];
        
        aTextField.inputView = lowppO2;
        NSInteger row1 = [lowppO2 selectedRowInComponent:0];
        NSInteger row2 = [lowppO2 selectedRowInComponent:1];
        NSInteger row3 = [lowppO2 selectedRowInComponent:2];
        
        aTextField.text = [NSString stringWithFormat:@"%@.%@%@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 116){
        
        UIPickerView *highppO2 = [[UIPickerView alloc] init];
        highppO2.delegate = self;
        highppO2.dataSource = self;
        highppO2.showsSelectionIndicator = YES;
        [highppO2 setFrame:CGRectMake(0, 480, 320, 180)];
        [highppO2 setTag:214];
        
        aTextField.inputView = highppO2;
        NSInteger row1 = [highppO2 selectedRowInComponent:0];
        NSInteger row2 = [highppO2 selectedRowInComponent:1];
        NSInteger row3 = [highppO2 selectedRowInComponent:2];
        
        aTextField.text = [NSString stringWithFormat:@"%@.%@%@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (logType) {
        case 0:
            if ((dateField.text.length > 0) && (wavesField.text.length > 0) && (currentField.text.length > 0)
                && (gasField.text.length > 0) && (staPreField.text.length > 0) &&
                (_endPreField.text.length > 0) && (maxDepField.text.length > 0) && (divetimeField.text.length >0) && (temperField.text.length > 0) && (visiField.text.length > 0)) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            else{
                
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
            }
            
            break;
            
        case 1:
            
            if (textField.tag == 112) {
                if ([textField.text isEqualToString:NSLocalizedString(@"Air", nil)]) {
                    NSLog(@"O2:21%% , NO2:79%%");
                    oxygenField.text = @"21%";
                    nitrogenField.text = @"79%";
                }else if ([textField.text isEqualToString:@"EAN32"]){
                    
                    oxygenField.text = @"32%";
                    nitrogenField.text = @"68%";
                }else if ([textField.text isEqualToString:@"EAN36"]){
                    
                    oxygenField.text = @"36%";
                    nitrogenField.text = @"64%";
                }else if ([textField.text isEqualToString:@"Trimix21/35"]){
                    oxygenField.text = @"21%";
                    nitrogenField.text = @"44%";
                }else if ([textField.text isEqualToString:@"Trimix18/45"]){
                    oxygenField.text = @"18%";
                    nitrogenField.text = @"37%";
                }else if ([textField.text isEqualToString:@"Trimix15/55"]){
                    oxygenField.text = @"15%";
                    nitrogenField.text = @"30%";
                }
            }
            if ((dateField.text.length > 0) && (wavesField.text.length > 0) && (currentField.text.length > 0)
                && (gasField.text.length > 0) && (staPreField.text.length > 0) &&
                (_endPreField.text.length > 0) && (maxDepField.text.length > 0) && (divetimeField.text.length >0) && (temperField.text.length > 0) && (visiField.text.length > 0) && (mixtureField.text.length >0) && (oxygenField.text.length >0) && (nitrogenField.text.length > 0)) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            else{
                
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
            }
            break;
            
        case 2:
            
            if (textField.tag == 112) {
                if ([textField.text isEqualToString:NSLocalizedString(@"Air", nil)]) {
                    NSLog(@"O2:21%% , NO2:79%%");
                    oxygenField.text = @"21%";
                    nitrogenField.text = @"79%";
                    heliumField.text = @"0%";
                    lowppo2Field.text = @"0.70";
                    highppo2Field.text = @"1.30";
                }else if ([textField.text isEqualToString:@"EAN32"]){
                    oxygenField.text = @"21%";
                    nitrogenField.text = @"79%";
                    heliumField.text = @"0%";
                    lowppo2Field.text = @"0.70";
                    highppo2Field.text = @"1.30";
                }else if ([textField.text isEqualToString:@"EAN36"]){
                    oxygenField.text = @"21%";
                    nitrogenField.text = @"79%";
                    heliumField.text = @"0%";
                    lowppo2Field.text = @"0.70";
                    highppo2Field.text = @"1.30";
                }else if ([textField.text isEqualToString:@"Trimix21/35"]){
                    oxygenField.text = @"21%";
                    nitrogenField.text = @"44%";
                    heliumField.text = @"35%";
                    lowppo2Field.text = @"0.70";
                    highppo2Field.text = @"1.30";
                }else if ([textField.text isEqualToString:@"Trimix18/45"]){
                    oxygenField.text = @"18%";
                    nitrogenField.text = @"37%";
                    heliumField.text = @"45%";
                    lowppo2Field.text = @"0.70";
                    highppo2Field.text = @"1.30";
                }else if ([textField.text isEqualToString:@"Trimix15/55"]){
                    oxygenField.text = @"15%";
                    nitrogenField.text = @"30%";
                    heliumField.text = @"55%";
                    lowppo2Field.text = @"0.70";
                    highppo2Field.text = @"1.30";
                }
            }
            
            if ((dateField.text.length > 0) && (wavesField.text.length > 0) && (currentField.text.length > 0)
                && (gasField.text.length > 0) && (staPreField.text.length > 0) &&
                (_endPreField.text.length > 0) && (maxDepField.text.length > 0) && (divetimeField.text.length >0) && (temperField.text.length > 0) && (visiField.text.length > 0) && (mixtureField.text.length >0) && (oxygenField.text.length >0) && (nitrogenField.text.length > 0) && (heliumField.text.length > 0) && (lowppo2Field.text.length > 0) && (highppo2Field.text.length > 0)) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            else{
                
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
            }
            break;
            
        default:
            break;
    }
    
}

-(void)textAndLabel
{
   
    [dateImg setFrame:CGRectMake(60, 75, imgDate.size.width, imgDate.size.height)];
    [scrollView addSubview:dateImg];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 75, 150, 30)];
    dateField.backgroundColor = [UIColor clearColor];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd HH:mm";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
   
    [siteImg setFrame:CGRectMake(60, 157, imgSite.size.width, imgSite.size.height)];
    [scrollView addSubview:siteImg];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 157, 97, 30)];
    siteField.backgroundColor = [UIColor clearColor];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = NSLocalizedString(@"Site", nil);
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    //siteField.textAlignment = NSTextAlignmentCenter;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    
    [wavesImg setFrame:CGRectMake(60, 229, imgWaves.size.width, imgWaves.size.height)];
    [scrollView addSubview:wavesImg];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 239, 97, 30)];
    wavesField.backgroundColor = [UIColor clearColor];
    [wavesField setTag:103];
    wavesField.delegate = self;
    wavesField.placeholder = NSLocalizedString(@"Waves", nil);
    
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    wavesField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:wavesField];
    
    [currentImg setFrame:CGRectMake(60, 321, imgCurrent.size.width, imgCurrent.size.height)];
    [scrollView addSubview:currentImg];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 321, 97, 30)];
    currentField.backgroundColor = [UIColor clearColor];
    [currentField setTag:104];
    currentField.delegate = self;
    currentField.placeholder = NSLocalizedString(@"Current", nil);
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    currentField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:currentField];
    
    [gasImg setFrame:CGRectMake(60, 383, imgGas.size.width, imgGas.size.height)];
    [scrollView addSubview:gasImg];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 383, 97, 30)];
    [gasField setTag:105];
    [gasField setText:NSLocalizedString(@"Air", nil)];
    gasField.delegate = self;
    gasField.placeholder = NSLocalizedString(@"Gas", nil);
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.textAlignment = NSTextAlignmentCenter;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    [startImg setFrame:CGRectMake(60, 465, imgStart.size.width, imgStart.size.height)];
    [scrollView addSubview:startImg];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 465, 97, 30)];
    staPreField.backgroundColor = [UIColor clearColor];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = NSLocalizedString(@"BPres", nil);
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    [endImg setFrame:CGRectMake(60, 547, imgEnd.size.width, imgEnd.size.height)];
    [scrollView addSubview:endImg];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 547, 97, 30)];
    _endPreField.backgroundColor = [UIColor clearColor];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = NSLocalizedString(@"EPres", nil);
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    [deptthImg setFrame:CGRectMake(60, 639, imgDepth.size.width, imgDepth.size.height)];
    [scrollView addSubview:deptthImg];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 639, 97, 30)];
    maxDepField.backgroundColor = [UIColor clearColor];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = NSLocalizedString(@"Max", nil);
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    [durationImg setFrame:CGRectMake(60, 732, imgDuration.size.width, imgDuration.size.height)];
    [scrollView addSubview:durationImg];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 732, 97, 30)];
    divetimeField.backgroundColor = [UIColor clearColor];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = NSLocalizedString(@"DTime", nil);
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
   
    [tempImg setFrame:CGRectMake(60, 824, imgTemp.size.width, imgTemp.size.height)];
    [scrollView addSubview:tempImg];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 824, 97, 30)];
    temperField.backgroundColor = [UIColor clearColor];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = NSLocalizedString(@"Temp", nil);
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.textAlignment = NSTextAlignmentCenter;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    [visiImg setFrame:CGRectMake(60, 926, imgVisi.size.width, imgVisi.size.height)];
    [scrollView addSubview:visiImg];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 926, 97, 30)];
    visiField.backgroundColor = [UIColor clearColor];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = NSLocalizedString(@"Visi", nil);
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.textAlignment = NSTextAlignmentCenter;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    
    [cameraImg setFrame:CGRectMake(225, 980, imgCamera.size.width, imgCamera.size.height)];
    [cameraImg addTarget:self action:@selector(fowardToPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cameraImg];
    
    selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(70, 980, 90, 90)];
    selectedImg.image = delegate.selectedCellImage;
    [scrollView addSubview:selectedImg];
    
    
}

-(void)nitroxTextAndLabel
{
    [dateImg setFrame:CGRectMake(60, 75, imgDate.size.width, imgDate.size.height)];
    [scrollView addSubview:dateImg];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 75, 150, 30)];
    dateField.backgroundColor = [UIColor clearColor];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd HH:mm";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    [siteImg setFrame:CGRectMake(60, 157, imgSite.size.width, imgSite.size.height)];
    [scrollView addSubview:siteImg];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 157, 97, 30)];
    siteField.backgroundColor = [UIColor clearColor];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = NSLocalizedString(@"Site", nil);
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    //siteField.textAlignment = NSTextAlignmentCenter;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    
    [wavesImg setFrame:CGRectMake(60, 229, imgWaves.size.width, imgWaves.size.height)];
    [scrollView addSubview:wavesImg];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 239, 97, 30)];
    wavesField.backgroundColor = [UIColor clearColor];
    [wavesField setTag:103];
    wavesField.delegate = self;
    wavesField.placeholder = NSLocalizedString(@"Waves", nil);
    
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    wavesField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:wavesField];
    
    [currentImg setFrame:CGRectMake(60, 321, imgCurrent.size.width, imgCurrent.size.height)];
    [scrollView addSubview:currentImg];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 321, 97, 30)];
    currentField.backgroundColor = [UIColor clearColor];
    [currentField setTag:104];
    currentField.delegate = self;
    currentField.placeholder = NSLocalizedString(@"Current", nil);
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    currentField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:currentField];
    
    [gasImg setFrame:CGRectMake(60, 383, imgGas.size.width, imgGas.size.height)];
    [scrollView addSubview:gasImg];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 383, 97, 30)];
    [gasField setTag:105];
    [gasField setText:NSLocalizedString(@"Nitro", nil)];
    gasField.delegate = self;
    gasField.placeholder = NSLocalizedString(@"Gas", nil);
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.textAlignment = NSTextAlignmentCenter;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    [startImg setFrame:CGRectMake(60, 465, imgStart.size.width, imgStart.size.height)];
    [scrollView addSubview:startImg];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 465, 97, 30)];
    staPreField.backgroundColor = [UIColor clearColor];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = NSLocalizedString(@"BPres", nil);
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    [endImg setFrame:CGRectMake(60, 547, imgEnd.size.width, imgEnd.size.height)];
    [scrollView addSubview:endImg];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 547, 97, 30)];
    _endPreField.backgroundColor = [UIColor clearColor];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = NSLocalizedString(@"EPres", nil);
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    [mixImg setFrame:CGRectMake(60, 629, imgMix.size.width, imgMix.size.height)];
    [scrollView addSubview:mixImg];
    
    mixtureField = [[UITextField alloc] initWithFrame:CGRectMake(130, 629, 97, 30)];
    mixtureField.backgroundColor = [UIColor clearColor];
    [mixtureField setTag:112];
    mixtureField.delegate = self;
    mixtureField.placeholder = NSLocalizedString(@"Mix", nil);
    mixtureField.borderStyle = UITextBorderStyleRoundedRect;
    mixtureField.adjustsFontSizeToFitWidth = YES;
    mixtureField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:mixtureField];
    
    [oxyImg setFrame:CGRectMake(60, 711, imgOxy.size.width, imgOxy.size.height)];
    [scrollView addSubview:oxyImg];
    
    oxygenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 711, 97, 30)];
    oxygenField.backgroundColor = [UIColor clearColor];
    [oxygenField setTag:113];
    oxygenField.delegate = self;
    oxygenField.placeholder = NSLocalizedString(@"Oxy", nil);
    oxygenField.borderStyle = UITextBorderStyleRoundedRect;
    oxygenField.adjustsFontSizeToFitWidth = YES;
    oxygenField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:oxygenField];
    
    [nitImg setFrame:CGRectMake(60, 793, imgNit.size.width, imgNit.size.height)];
    [scrollView addSubview:nitImg];
    
    nitrogenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 793, 97, 30)];
    nitrogenField.backgroundColor = [UIColor clearColor];
    [nitrogenField setTag:114];
    nitrogenField.delegate = self;
    nitrogenField.placeholder = NSLocalizedString(@"Nitrox", nil);
    nitrogenField.borderStyle = UITextBorderStyleRoundedRect;
    nitrogenField.textAlignment = NSTextAlignmentCenter;
    nitrogenField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:nitrogenField];
    
    [deptthImg setFrame:CGRectMake(60, 875, imgDepth.size.width, imgDepth.size.height)];
    [scrollView addSubview:deptthImg];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 875, 97, 30)];
    maxDepField.backgroundColor = [UIColor clearColor];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = NSLocalizedString(@"Max", nil);
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    [durationImg setFrame:CGRectMake(60, 957, imgDuration.size.width, imgDuration.size.height)];
    [scrollView addSubview:durationImg];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 957, 97, 30)];
    divetimeField.backgroundColor = [UIColor clearColor];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = NSLocalizedString(@"DTime", nil);
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
    
    [tempImg setFrame:CGRectMake(60, 1039, imgTemp.size.width, imgTemp.size.height)];
    [scrollView addSubview:tempImg];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1039, 97, 30)];
    temperField.backgroundColor = [UIColor clearColor];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = NSLocalizedString(@"Temp", nil);
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.textAlignment = NSTextAlignmentCenter;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    [visiImg setFrame:CGRectMake(60, 1121, imgVisi.size.width, imgVisi.size.height)];
    [scrollView addSubview:visiImg];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1121, 97, 30)];
    visiField.backgroundColor = [UIColor clearColor];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = NSLocalizedString(@"Visi", nil);
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.textAlignment = NSTextAlignmentCenter;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    
    [cameraImg setFrame:CGRectMake(225, 1176, imgCamera.size.width, imgCamera.size.height)];
    [cameraImg addTarget:self action:@selector(fowardToPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cameraImg];
    
    selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(70, 1176, 90, 90)];
    selectedImg.image = delegate.selectedCellImage;
    [scrollView addSubview:selectedImg];
    
}

-(void)closedCircuitTextAndLabel
{
    [dateImg setFrame:CGRectMake(60, 75, imgDate.size.width, imgDate.size.height)];
    [scrollView addSubview:dateImg];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 75, 150, 30)];
    dateField.backgroundColor = [UIColor clearColor];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd HH:mm";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    [siteImg setFrame:CGRectMake(60, 157, imgSite.size.width, imgSite.size.height)];
    [scrollView addSubview:siteImg];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 157, 97, 30)];
    siteField.backgroundColor = [UIColor clearColor];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = NSLocalizedString(@"Site", nil);
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    //siteField.textAlignment = NSTextAlignmentCenter;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    
    [wavesImg setFrame:CGRectMake(60, 229, imgWaves.size.width, imgWaves.size.height)];
    [scrollView addSubview:wavesImg];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 239, 97, 30)];
    wavesField.backgroundColor = [UIColor clearColor];
    [wavesField setTag:103];
    wavesField.delegate = self;
    wavesField.placeholder = NSLocalizedString(@"Waves", nil);
    
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    wavesField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:wavesField];
    
    [currentImg setFrame:CGRectMake(60, 321, imgCurrent.size.width, imgCurrent.size.height)];
    [scrollView addSubview:currentImg];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 321, 97, 30)];
    currentField.backgroundColor = [UIColor clearColor];
    [currentField setTag:104];
    currentField.delegate = self;
    currentField.placeholder = NSLocalizedString(@"Current", nil);
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    currentField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:currentField];
    
    [gasImg setFrame:CGRectMake(60, 383, imgGas.size.width, imgGas.size.height)];
    [scrollView addSubview:gasImg];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 383, 97, 30)];
    [gasField setTag:105];
    [gasField setText:NSLocalizedString(@"CCR", nil)] ;
    gasField.delegate = self;
    gasField.placeholder = NSLocalizedString(@"Gas", nil);
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.textAlignment = NSTextAlignmentCenter;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    [startImg setFrame:CGRectMake(60, 465, imgStart.size.width, imgStart.size.height)];
    [scrollView addSubview:startImg];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 465, 97, 30)];
    staPreField.backgroundColor = [UIColor clearColor];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = NSLocalizedString(@"BPres", nil);
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    [endImg setFrame:CGRectMake(60, 547, imgEnd.size.width, imgEnd.size.height)];
    [scrollView addSubview:endImg];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 547, 97, 30)];
    _endPreField.backgroundColor = [UIColor clearColor];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = NSLocalizedString(@"EPres", nil);
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    [mixImg setFrame:CGRectMake(60, 629, imgMix.size.width, imgMix.size.height)];
    [scrollView addSubview:mixImg];
    
    mixtureField = [[UITextField alloc] initWithFrame:CGRectMake(130, 629, 97, 30)];
    mixtureField.backgroundColor = [UIColor clearColor];
    [mixtureField setTag:112];
    mixtureField.delegate = self;
    mixtureField.placeholder = NSLocalizedString(@"Mix", nil);
    mixtureField.borderStyle = UITextBorderStyleRoundedRect;
    mixtureField.adjustsFontSizeToFitWidth = YES;
    mixtureField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:mixtureField];
    
    [oxyImg setFrame:CGRectMake(60, 711, imgOxy.size.width, imgOxy.size.height)];
    [scrollView addSubview:oxyImg];
    
    oxygenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 711, 97, 30)];
    oxygenField.backgroundColor = [UIColor clearColor];
    [oxygenField setTag:113];
    oxygenField.delegate = self;
    oxygenField.placeholder = NSLocalizedString(@"Oxy", nil);
    oxygenField.borderStyle = UITextBorderStyleRoundedRect;
    oxygenField.adjustsFontSizeToFitWidth = YES;
    oxygenField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:oxygenField];
    
    [nitImg setFrame:CGRectMake(60, 793, imgNit.size.width, imgNit.size.height)];
    [scrollView addSubview:nitImg];
    
    nitrogenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 793, 97, 30)];
    nitrogenField.backgroundColor = [UIColor clearColor];
    [nitrogenField setTag:114];
    nitrogenField.delegate = self;
    nitrogenField.placeholder = NSLocalizedString(@"Nitrox", nil);
    nitrogenField.borderStyle = UITextBorderStyleRoundedRect;
    nitrogenField.textAlignment = NSTextAlignmentCenter;
    nitrogenField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:nitrogenField];
    
    [helImg setFrame:CGRectMake(60, 875, imgHel.size.width, imgHel.size.height)];
    [scrollView addSubview:helImg];
    
    heliumField = [[UITextField alloc] initWithFrame:CGRectMake(130, 875, 97, 30)];
    heliumField.backgroundColor = [UIColor clearColor];
    [heliumField setTag:115];
    heliumField.delegate = self;
    heliumField.placeholder = NSLocalizedString(@"Helium", nil);
    heliumField.borderStyle = UITextBorderStyleRoundedRect;
    heliumField.adjustsFontSizeToFitWidth = YES;
    heliumField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:heliumField];
    
    
    lowppo2Label = [[UILabel alloc] initWithFrame:CGRectMake(30, 957, 100, 21)];
    lowppo2Label.backgroundColor = [UIColor clearColor];
    [lowppo2Label setText:NSLocalizedString(@"LowP", nil)];
    [scrollView addSubview:lowppo2Label];
    
    lowppo2Field = [[UITextField alloc] initWithFrame:CGRectMake(130, 954, 97, 30)];
    lowppo2Field.backgroundColor = [UIColor clearColor];
    [lowppo2Field setTag:116];
    lowppo2Field.delegate = self;
    lowppo2Field.borderStyle = UITextBorderStyleRoundedRect;
    lowppo2Field.adjustsFontSizeToFitWidth = YES;
    lowppo2Field.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:lowppo2Field];
    
    highppo2Label = [[UILabel alloc] initWithFrame:CGRectMake(30, 1039, 100, 21)];
    highppo2Label.backgroundColor = [UIColor clearColor];
    [highppo2Label setText:NSLocalizedString(@"HighP", nil)];
    [scrollView addSubview:highppo2Label];
    
    highppo2Field = [[UITextField alloc] initWithFrame:CGRectMake(130, 1036, 97, 30)];
    highppo2Field.backgroundColor = [UIColor clearColor];
    [highppo2Field setTag:117];
    highppo2Field.delegate = self;
    highppo2Field.placeholder = @"";
    highppo2Field.borderStyle = UITextBorderStyleRoundedRect;
    highppo2Field.textAlignment = NSTextAlignmentCenter;
    highppo2Field.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:highppo2Field];
    
    [deptthImg setFrame:CGRectMake(60, 1121, imgDepth.size.width, imgDepth.size.height)];
    [scrollView addSubview:deptthImg];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1121, 97, 30)];
    maxDepField.backgroundColor = [UIColor clearColor];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = NSLocalizedString(@"Max", nil);
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    [durationImg setFrame:CGRectMake(60, 1203, imgDuration.size.width, imgDuration.size.height)];
    [scrollView addSubview:durationImg];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1203, 97, 30)];
    divetimeField.backgroundColor = [UIColor clearColor];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = NSLocalizedString(@"DTime", nil);
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
    
    [tempImg setFrame:CGRectMake(60, 1285, imgTemp.size.width, imgTemp.size.height)];
    [scrollView addSubview:tempImg];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1285, 97, 30)];
    temperField.backgroundColor = [UIColor clearColor];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = NSLocalizedString(@"Temp", nil);
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.textAlignment = NSTextAlignmentCenter;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    [visiImg setFrame:CGRectMake(60, 1367, imgVisi.size.width, imgVisi.size.height)];
    [scrollView addSubview:visiImg];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1367, 97, 30)];
    visiField.backgroundColor = [UIColor clearColor];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = NSLocalizedString(@"Visi", nil);
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.textAlignment = NSTextAlignmentCenter;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    
    [cameraImg setFrame:CGRectMake(225, 1422, imgCamera.size.width, imgCamera.size.height)];
    [cameraImg addTarget:self action:@selector(fowardToPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cameraImg];
    
    selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(70, 1422, 90, 90)];
    selectedImg.image = delegate.selectedCellImage;
    [scrollView addSubview:selectedImg];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        delegate.selectedCellImage = nil;
    }
    
    
}



-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    
    
    switch (viewReserved) {
        case 0:
            [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            break;
        
        case 1:
            
            break;
        
        default:
            break;
    }
    
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    dateField.text = nil;
    siteField.text = nil;
    wavesField.text = nil;
    currentField.text = nil;
    maxDepField.text = nil;
    gasField.text = nil;
    divetimeField.text = nil;
    visiField.text = nil;
    temperField.text = nil;
    staPreField.text = nil;
    _endPreField.text = nil;
    fbLog = nil;
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma FBFunctionDelegate
- (void)shareUtility:(FBFunction *)shareUtility didFailWithError:(NSError *)error
{
    if (!error.userInfo[FBSDKErrorLocalizedDescriptionKey]) {
    NSLog(@"Unexpected error when sharing : %@", error);
    [[[UIAlertView alloc] initWithTitle:@"Oops"
                                message:@"There was a problem sharing. Please try again later."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    }
}
- (void)shareUtilityWillShare:(FBFunction *)shareUtility{}
- (void)shareUtilityDidCompleteShare:(FBFunction *)shareUtility{}
- (void)shareUtilityUserShouldLogin:(FBFunction *)shareUtility{}

#pragma mark - PhotoImageDelegate

- (void)imagePicker:(PhotoImagePicker *)imagePicker didSelectImage:(UIImage *)image
{
    delegate.selectedCellImage = image;
    pickImage = nil;
    
}

- (void)imagePickerDidCancel:(PhotoImagePicker *)imagePicker
{
    pickImage = nil;
}

@end
