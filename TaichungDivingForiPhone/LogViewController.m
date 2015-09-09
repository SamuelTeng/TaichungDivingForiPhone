//
//  LogViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "LogViewController.h"
#import "DiveLog.h"
#import "AppDelegate.h"
#import "LogBookTableViewController.h"
#import "LogCategoryViewController.h"

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


@interface LogViewController (){
    
    AppDelegate *delegate;
    LogBookTableViewController *logBookTableView;
    LogCategoryViewController *logCategory;
    
}


@end

@implementation LogViewController

@synthesize managedObjectContext,scrollView,secondRow,selectedRow,siteField,siteLabel,staPreField,staPrelabel,dateField,dateLabel,divetimeField,divetimeLabel,wavesField,wavesLabel,currentField,currentLabel,mAndf,maxDepField,maxDepLabel,temperField,temperLabel,thirdRow,visiField,visiLabel,otherField,otherLabel,gasArr,gasField,gasLabel,dateFromData,wavesFromData,currentFromData,timeFromData,wavesArr,currentArr,logType,mixtureArr,mixtureField,mixtureLabel,oxygenField,oxygenLabel,nitrogenField,nitrogenLabel,heliumField,heliumLabel,lowppo2Field,lowppo2Label,highppo2Field,highppo2Label;

-(void)loadView
{
    
    [super loadView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1500);
    scrollView.backgroundColor = [UIColor whiteColor];
    //scrollView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"scroll_background.png"]];
    [self.view addSubview:scrollView];
    
    
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
    
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"ic_save_black_24dp.png"] style:UIBarButtonItemStylePlain target:self action:@selector(saveToData)];
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
    
    
    
    delegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = delegate.managedObjectContext;
    
    logBookTableView = [[LogBookTableViewController alloc] init];
    logCategory = [[LogCategoryViewController alloc] init];
    
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
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

    
}

-(void)saveToData
{
    
    switch (logType) {
        case 0:
        {
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
            
            
            
            
            [delegate.navi pushViewController:logBookTableView animated:YES];
            
            
        }
            break;
            
        case 1:
        {
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
            
            
            
            
            [delegate.navi pushViewController:logBookTableView animated:YES];
            
            
        }
            
            break;
            
        case 2:
        {
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
            
            
            
            
            [delegate.navi pushViewController:logBookTableView animated:YES];
            
            
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
        
        aTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
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
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 88, 80, 21)];
    dateLabel.backgroundColor = [UIColor clearColor];
    [dateLabel setText:NSLocalizedString(@"Date", nil)];
    [scrollView addSubview:dateLabel];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 85, 150, 30)];
    dateField.backgroundColor = [UIColor clearColor];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd HH:mm";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 154, 80, 21)];
    siteLabel.backgroundColor = [UIColor clearColor];
    [siteLabel setText:NSLocalizedString(@"Site", nil)];
    [scrollView addSubview:siteLabel];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 151, 97, 30)];
    siteField.backgroundColor = [UIColor clearColor];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = @"Site Name";
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    //siteField.textAlignment = NSTextAlignmentCenter;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];

    wavesLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 220, 100, 21)];
    wavesLabel.backgroundColor = [UIColor clearColor];
    [wavesLabel setText:NSLocalizedString(@"Waves", nil)];
    [scrollView addSubview:wavesLabel];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 217, 97, 30)];
    wavesField.backgroundColor = [UIColor clearColor];
    [wavesField setTag:103];
    wavesField.delegate = self;
    //wavesField.placeholder = @"25.061033";
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    wavesField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:wavesField];
    
    currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 286, 100, 21)];
    currentLabel.backgroundColor = [UIColor clearColor];
    [currentLabel setText:NSLocalizedString(@"Current", nil)];
    [scrollView addSubview:currentLabel];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 283, 97, 30)];
    currentField.backgroundColor = [UIColor clearColor];
    [currentField setTag:104];
    currentField.delegate = self;
    //currentField.placeholder = @"121.646056";
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    currentField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:currentField];
    
    gasLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 352, 100, 21)];
    gasLabel.backgroundColor = [UIColor clearColor];
    [gasLabel setText:NSLocalizedString(@"Gas", nil)];
    [scrollView addSubview:gasLabel];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 349, 97, 30)];
    [gasField setTag:105];
    [gasField setText:NSLocalizedString(@"Air", nil)];
    gasField.delegate = self;
    //gasField.placeholder = @"氣源";
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.textAlignment = NSTextAlignmentCenter;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    staPrelabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 428, 200, 21)];
    staPrelabel.backgroundColor = [UIColor clearColor];
    [staPrelabel setText:NSLocalizedString(@"BPres", nil)];
    [scrollView addSubview:staPrelabel];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 425, 97, 30)];
    staPreField.backgroundColor = [UIColor clearColor];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = @"200 bar";
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    _endPreLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 494, 200, 21)];
    _endPreLabel.backgroundColor = [UIColor clearColor];
    [_endPreLabel setText:NSLocalizedString(@"EPres", nil)];
    [scrollView addSubview:_endPreLabel];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 491, 97, 30)];
    _endPreField.backgroundColor = [UIColor clearColor];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = @"60 bar";
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    
    maxDepLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 560, 100, 21)];
    maxDepLabel.backgroundColor = [UIColor clearColor];
    [maxDepLabel setText:NSLocalizedString(@"Max", nil)];
    [scrollView addSubview:maxDepLabel];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 557, 97, 30)];
    maxDepField.backgroundColor = [UIColor clearColor];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = @"40 M";
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    divetimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 626, 100, 21)];
    divetimeLabel.backgroundColor = [UIColor clearColor];
    [divetimeLabel setText:NSLocalizedString(@"DTime", nil)];
    [scrollView addSubview:divetimeLabel];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 623, 97, 30)];
    divetimeField.backgroundColor = [UIColor clearColor];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = @"in minutes";
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
    
    temperLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 692, 100, 21)];
    temperLabel.backgroundColor = [UIColor clearColor];
    [temperLabel setText:NSLocalizedString(@"Temp", nil)];
    [scrollView addSubview:temperLabel];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 689, 97, 30)];
    temperField.backgroundColor = [UIColor clearColor];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = @"";
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.textAlignment = NSTextAlignmentCenter;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    visiLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 758, 100, 21)];
    visiLabel.backgroundColor = [UIColor clearColor];
    [visiLabel setText:NSLocalizedString(@"Visi", nil)];
    [scrollView addSubview:visiLabel];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 755, 97, 30)];
    visiField.backgroundColor = [UIColor clearColor];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = @"15M";
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.textAlignment = NSTextAlignmentCenter;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    
    
    
}

-(void)nitroxTextAndLabel
{
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 88, 80, 21)];
    dateLabel.backgroundColor = [UIColor clearColor];
    [dateLabel setText:NSLocalizedString(@"Date", nil)];
    [scrollView addSubview:dateLabel];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 85, 150, 30)];
    dateField.backgroundColor = [UIColor clearColor];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd HH:mm";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 154, 80, 21)];
    siteLabel.backgroundColor = [UIColor clearColor];
    [siteLabel setText:NSLocalizedString(@"Site", nil)];
    [scrollView addSubview:siteLabel];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 151, 97, 30)];
    siteField.backgroundColor = [UIColor clearColor];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = @"Site Name";
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    //siteField.textAlignment = NSTextAlignmentCenter;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    
    wavesLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 220, 100, 21)];
    wavesLabel.backgroundColor = [UIColor clearColor];
    [wavesLabel setText:NSLocalizedString(@"Waves", nil)];
    [scrollView addSubview:wavesLabel];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 217, 97, 30)];
    wavesField.backgroundColor = [UIColor clearColor];
    [wavesField setTag:103];
    wavesField.delegate = self;
    //wavesField.placeholder = @"25.061033";
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    wavesField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:wavesField];
    
    currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 286, 100, 21)];
    currentLabel.backgroundColor = [UIColor clearColor];
    [currentLabel setText:NSLocalizedString(@"Current", nil)];
    [scrollView addSubview:currentLabel];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 283, 97, 30)];
    currentField.backgroundColor = [UIColor clearColor];
    [currentField setTag:104];
    currentField.delegate = self;
    //currentField.placeholder = @"121.646056";
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    currentField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:currentField];
    
    gasLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 352, 100, 21)];
    gasLabel.backgroundColor = [UIColor clearColor];
    [gasLabel setText:NSLocalizedString(@"Gas", nil)];
    [scrollView addSubview:gasLabel];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 349, 97, 30)];
    [gasField setTag:105];
    [gasField setText:NSLocalizedString(@"Nitro", nil)];
    gasField.delegate = self;
    //gasField.placeholder = @"氣源";
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.textAlignment = NSTextAlignmentCenter;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    staPrelabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 428, 200, 21)];
    staPrelabel.backgroundColor = [UIColor clearColor];
    [staPrelabel setText:NSLocalizedString(@"BPres", nil)];
    [scrollView addSubview:staPrelabel];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 425, 97, 30)];
    staPreField.backgroundColor = [UIColor clearColor];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = @"200 bar";
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    _endPreLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 494, 200, 21)];
    _endPreLabel.backgroundColor = [UIColor clearColor];
    [_endPreLabel setText:NSLocalizedString(@"EPres", nil)];
    [scrollView addSubview:_endPreLabel];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 491, 97, 30)];
    _endPreField.backgroundColor = [UIColor clearColor];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = @"60 bar";
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    mixtureLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 560, 100, 21)];
    mixtureLabel.backgroundColor = [UIColor clearColor];
    [mixtureLabel setText:NSLocalizedString(@"Mix", nil)];
    [scrollView addSubview:mixtureLabel];
    
    mixtureField = [[UITextField alloc] initWithFrame:CGRectMake(130, 557, 97, 30)];
    mixtureField.backgroundColor = [UIColor clearColor];
    [mixtureField setTag:112];
    mixtureField.delegate = self;
    mixtureField.borderStyle = UITextBorderStyleRoundedRect;
    mixtureField.adjustsFontSizeToFitWidth = YES;
    mixtureField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:mixtureField];
    
    oxygenLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 626, 100, 21)];
    oxygenLabel.backgroundColor = [UIColor clearColor];
    [oxygenLabel setText:NSLocalizedString(@"Oxy", nil)];
    [scrollView addSubview:oxygenLabel];
    
    oxygenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 623, 97, 30)];
    oxygenField.backgroundColor = [UIColor clearColor];
    [oxygenField setTag:113];
    oxygenField.delegate = self;
    oxygenField.placeholder = @"";
    oxygenField.borderStyle = UITextBorderStyleRoundedRect;
    oxygenField.adjustsFontSizeToFitWidth = YES;
    oxygenField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:oxygenField];
    
    nitrogenLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 692, 100, 21)];
    nitrogenLabel.backgroundColor = [UIColor clearColor];
    [nitrogenLabel setText:NSLocalizedString(@"Nitrox", nil)];
    [scrollView addSubview:nitrogenLabel];
    
    nitrogenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 689, 97, 30)];
    nitrogenField.backgroundColor = [UIColor clearColor];
    [nitrogenField setTag:114];
    nitrogenField.delegate = self;
    nitrogenField.placeholder = @"";
    nitrogenField.borderStyle = UITextBorderStyleRoundedRect;
    nitrogenField.textAlignment = NSTextAlignmentCenter;
    nitrogenField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:nitrogenField];
    
    maxDepLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 758, 100, 21)];
    maxDepLabel.backgroundColor = [UIColor clearColor];
    [maxDepLabel setText:NSLocalizedString(@"Max", nil)];
    [scrollView addSubview:maxDepLabel];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 755, 97, 30)];
    maxDepField.backgroundColor = [UIColor clearColor];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = @"40 M";
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    divetimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 824, 100, 21)];
    divetimeLabel.backgroundColor = [UIColor clearColor];
    [divetimeLabel setText:NSLocalizedString(@"DTime", nil)];
    [scrollView addSubview:divetimeLabel];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 821, 97, 30)];
    divetimeField.backgroundColor = [UIColor clearColor];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = @"in minutes";
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
    
    temperLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 890, 100, 21)];
    temperLabel.backgroundColor = [UIColor clearColor];
    [temperLabel setText:NSLocalizedString(@"Temp", nil)];
    [scrollView addSubview:temperLabel];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 887, 97, 30)];
    temperField.backgroundColor = [UIColor clearColor];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = @"";
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.textAlignment = NSTextAlignmentCenter;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    visiLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 956, 100, 21)];
    visiLabel.backgroundColor = [UIColor clearColor];
    [visiLabel setText:NSLocalizedString(@"Visi", nil)];
    [scrollView addSubview:visiLabel];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 953, 97, 30)];
    visiField.backgroundColor = [UIColor clearColor];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = @"15M";
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.textAlignment = NSTextAlignmentCenter;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    
}

-(void)closedCircuitTextAndLabel
{
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 88, 80, 21)];
    dateLabel.backgroundColor = [UIColor clearColor];
    [dateLabel setText:NSLocalizedString(@"Date", nil)];
    [scrollView addSubview:dateLabel];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 85, 150, 30)];
    dateField.backgroundColor = [UIColor clearColor];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 154, 80, 21)];
    siteLabel.backgroundColor = [UIColor clearColor];
    [siteLabel setText:NSLocalizedString(@"Site", nil)];
    [scrollView addSubview:siteLabel];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 151, 97, 30)];
    siteField.backgroundColor = [UIColor clearColor];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = @"Site Name";
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    siteField.textAlignment = NSTextAlignmentCenter;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    /*
     siteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [siteButton setTitle:@"Auto" forState:UIControlStateNormal];
     [siteButton setFrame:CGRectMake(210, 124, 80, 80)];
     [siteButton addTarget:self action:@selector(locateSite) forControlEvents:UIControlEventTouchUpInside];
     [scrollView addSubview:siteButton];
     */
    wavesLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 220, 100, 21)];
    wavesLabel.backgroundColor = [UIColor clearColor];
    [wavesLabel setText:NSLocalizedString(@"Waves", nil)];
    [scrollView addSubview:wavesLabel];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 217, 97, 30)];
    wavesField.backgroundColor = [UIColor clearColor];
    [wavesField setTag:103];
    wavesField.delegate = self;
    //wavesField.placeholder = @"25.061033";
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    wavesField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:wavesField];
    
    currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 286, 100, 21)];
    currentLabel.backgroundColor = [UIColor clearColor];
    [currentLabel setText:NSLocalizedString(@"Current", nil)];
    [scrollView addSubview:currentLabel];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 283, 97, 30)];
    currentField.backgroundColor = [UIColor clearColor];
    [currentField setTag:104];
    currentField.delegate = self;
    //currentField.placeholder = @"121.646056";
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    currentField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:currentField];
    
    gasLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 352, 100, 21)];
    gasLabel.backgroundColor = [UIColor clearColor];
    [gasLabel setText:NSLocalizedString(@"Gas", nil)];
    [scrollView addSubview:gasLabel];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 349, 97, 30)];
    [gasField setTag:105];
    [gasField setText:NSLocalizedString(@"CCR", nil)] ;
    gasField.delegate = self;
    //gasField.placeholder = @"氣源";
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.textAlignment = NSTextAlignmentCenter;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    staPrelabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 428, 200, 21)];
    staPrelabel.backgroundColor = [UIColor clearColor];
    [staPrelabel setText:NSLocalizedString(@"BPres", nil)];
    [scrollView addSubview:staPrelabel];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 425, 97, 30)];
    staPreField.backgroundColor = [UIColor clearColor];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = @"200 bar";
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    _endPreLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 494, 200, 21)];
    _endPreLabel.backgroundColor = [UIColor clearColor];
    [_endPreLabel setText:NSLocalizedString(@"EPres", nil)];
    [scrollView addSubview:_endPreLabel];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 491, 97, 30)];
    _endPreField.backgroundColor = [UIColor clearColor];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = @"60 bar";
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    mixtureLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 560, 100, 21)];
    mixtureLabel.backgroundColor = [UIColor clearColor];
    [mixtureLabel setText:NSLocalizedString(@"Mix", nil)];
    [scrollView addSubview:mixtureLabel];
    
    mixtureField = [[UITextField alloc] initWithFrame:CGRectMake(130, 557, 97, 30)];
    mixtureField.backgroundColor = [UIColor clearColor];
    [mixtureField setTag:112];
    mixtureField.delegate = self;
    mixtureField.borderStyle = UITextBorderStyleRoundedRect;
    mixtureField.adjustsFontSizeToFitWidth = YES;
    mixtureField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:mixtureField];
    
    oxygenLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 626, 100, 21)];
    oxygenLabel.backgroundColor = [UIColor clearColor];
    [oxygenLabel setText:NSLocalizedString(@"Oxy", nil)];
    [scrollView addSubview:oxygenLabel];
    
    oxygenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 623, 97, 30)];
    oxygenField.backgroundColor = [UIColor clearColor];
    [oxygenField setTag:113];
    oxygenField.delegate = self;
    oxygenField.placeholder = @"in minutes";
    oxygenField.borderStyle = UITextBorderStyleRoundedRect;
    oxygenField.adjustsFontSizeToFitWidth = YES;
    oxygenField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:oxygenField];
    
    nitrogenLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 692, 100, 21)];
    nitrogenLabel.backgroundColor = [UIColor clearColor];
    [nitrogenLabel setText:NSLocalizedString(@"Nitrox", nil)];
    [scrollView addSubview:nitrogenLabel];
    
    nitrogenField = [[UITextField alloc] initWithFrame:CGRectMake(130, 689, 97, 30)];
    nitrogenField.backgroundColor = [UIColor clearColor];
    [nitrogenField setTag:114];
    nitrogenField.delegate = self;
    nitrogenField.placeholder = @"%";
    nitrogenField.borderStyle = UITextBorderStyleRoundedRect;
    nitrogenField.textAlignment = NSTextAlignmentCenter;
    nitrogenField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:nitrogenField];
    
    heliumLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 758, 100, 21)];
    heliumLabel.backgroundColor = [UIColor clearColor];
    [heliumLabel setText:NSLocalizedString(@"Helium", nil)];
    [scrollView addSubview:heliumLabel];
    
    heliumField = [[UITextField alloc] initWithFrame:CGRectMake(130, 755, 97, 30)];
    heliumField.backgroundColor = [UIColor clearColor];
    [heliumField setTag:115];
    heliumField.delegate = self;
    heliumField.borderStyle = UITextBorderStyleRoundedRect;
    heliumField.adjustsFontSizeToFitWidth = YES;
    heliumField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:heliumField];
    
    
    lowppo2Label = [[UILabel alloc] initWithFrame:CGRectMake(30, 824, 100, 21)];
    lowppo2Label.backgroundColor = [UIColor clearColor];
    [lowppo2Label setText:NSLocalizedString(@"LowP", nil)];
    [scrollView addSubview:lowppo2Label];
    
    lowppo2Field = [[UITextField alloc] initWithFrame:CGRectMake(130, 821, 97, 30)];
    lowppo2Field.backgroundColor = [UIColor clearColor];
    [lowppo2Field setTag:116];
    lowppo2Field.delegate = self;
    lowppo2Field.borderStyle = UITextBorderStyleRoundedRect;
    lowppo2Field.adjustsFontSizeToFitWidth = YES;
    lowppo2Field.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:lowppo2Field];
    
    highppo2Label = [[UILabel alloc] initWithFrame:CGRectMake(30, 890, 100, 21)];
    highppo2Label.backgroundColor = [UIColor clearColor];
    [highppo2Label setText:NSLocalizedString(@"HighP", nil)];
    [scrollView addSubview:highppo2Label];
    
    highppo2Field = [[UITextField alloc] initWithFrame:CGRectMake(130, 887, 97, 30)];
    highppo2Field.backgroundColor = [UIColor clearColor];
    [highppo2Field setTag:117];
    highppo2Field.delegate = self;
    highppo2Field.placeholder = @"";
    highppo2Field.borderStyle = UITextBorderStyleRoundedRect;
    highppo2Field.textAlignment = NSTextAlignmentCenter;
    highppo2Field.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:highppo2Field];
    
    maxDepLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 956, 100, 21)];
    maxDepLabel.backgroundColor = [UIColor clearColor];
    [maxDepLabel setText:NSLocalizedString(@"Max", nil)];
    [scrollView addSubview:maxDepLabel];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 953, 97, 30)];
    maxDepField.backgroundColor = [UIColor clearColor];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = @"40 M";
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    divetimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 1022, 100, 21)];
    divetimeLabel.backgroundColor = [UIColor clearColor];
    [divetimeLabel setText:NSLocalizedString(@"DTime", nil)];
    [scrollView addSubview:divetimeLabel];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1019, 97, 30)];
    divetimeField.backgroundColor = [UIColor clearColor];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = @"in minutes";
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
    
    temperLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 1088, 100, 21)];
    temperLabel.backgroundColor = [UIColor clearColor];
    [temperLabel setText:NSLocalizedString(@"Temp", nil)];
    [scrollView addSubview:temperLabel];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1085, 97, 30)];
    temperField.backgroundColor = [UIColor clearColor];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = @"";
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.textAlignment = NSTextAlignmentCenter;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    visiLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 1154, 100, 21)];
    visiLabel.backgroundColor = [UIColor clearColor];
    [visiLabel setText:NSLocalizedString(@"Visi", nil)];
    [scrollView addSubview:visiLabel];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 1151, 97, 30)];
    visiField.backgroundColor = [UIColor clearColor];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = @"15M";
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.textAlignment = NSTextAlignmentCenter;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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

@end
