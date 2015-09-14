//
//  LogBookTableViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "LogBookTableViewController.h"
#import "LogBookTableViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "DiveLog.h"
#import "LogViewController.h"
#import "PageViewController.h"
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

@interface LogBookTableViewController (){
    
    AppDelegate *delegate_logbook;
    MainViewController *mainView;
    DiveLog *diveLog;
    LogCategoryViewController *logCategory;
    LogViewController *logViewController;
    PageViewController *pageViewController;
}


@end

@implementation LogBookTableViewController

@synthesize resultController;

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"DiveLog" inManagedObjectContext:delegate_logbook.managedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    //NSSortDescriptor *gasSort = [[NSSortDescriptor alloc] initWithKey:@"gas_type" ascending:YES];
   NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
   // NSArray *descriptors = [[NSArray alloc] initWithObjects:gasSort,sortDescriptor, nil];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate_logbook.managedObjectContext sectionNameKeyPath:@"date" cacheName:nil];
    
    resultController.delegate = self;
    
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [delegate_logbook.navi pushViewController:mainView animated:NO];
            break;
            
        case 1:
            [delegate_logbook.navi pushViewController:logCategory animated:NO];
            break;
            
        default:
            break;
    }
}

-(void)detectingDevice
{
    
    if(IS_IPHONE)
    {
        //NSLog(@"IS_IPHONE");
    }
    if(IS_RETINA)
    {
        //NSLog(@"IS_RETINA");
    }
    if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"IS_IPHONE_4_OR_LESS");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i4"]];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        
        [backgroundImg setFrame:self.tableView.frame];
        
        [self.tableView setBackgroundView:backgroundImg];
      
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        
        [backgroundImg setFrame:self.tableView.frame];
        
        [self.tableView setBackgroundView:backgroundImg];
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
        
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        
        [backgroundImg setFrame:self.tableView.frame];
        
        [self.tableView setBackgroundView:backgroundImg];
        
      
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");
        UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        
        [backgroundImg setFrame:self.tableView.frame];
        
        [self.tableView setBackgroundView:backgroundImg];
    }
}


-(void)loadView
{
    [super loadView];
    delegate_logbook = [[UIApplication sharedApplication] delegate];
    mainView = [[MainViewController alloc] init];
    logCategory = [[LogCategoryViewController alloc] init];
    logViewController = [[LogViewController alloc] init];
    pageViewController = [[PageViewController alloc] init];
    
    
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"ic_edit_black_24dp.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toLogView:)];
    self.navigationItem.rightBarButtonItem = add;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"ic_home_black_24dp.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backToHome:)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];
    
    if (! resultController.fetchedObjects.count) {
        UIAlertView *noLog = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"AlertM", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Add", nil), nil];
        [noLog show];
    }
    
    
    
    UIBarButtonItem *backToHome = [[UIBarButtonItem alloc] init];
    backToHome.title = NSLocalizedString(@"LogPage", nil);
    self.navigationItem.backBarButtonItem = backToHome;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUInteger count = resultController.fetchedObjects.count;
    NSString *countOfLogs = [NSString stringWithFormat:NSLocalizedString(@"Count", nil),(unsigned long)count];
    self.navigationItem.title = countOfLogs;
    [self detectingDevice];
}

-(void)toLogView:(id)sender
{
    [delegate_logbook.navi pushViewController:logCategory animated:YES];
}

-(void)backToHome:(id)sender
{
    
    mainView = [[MainViewController alloc] init];
    [delegate_logbook.navi pushViewController:mainView animated:NO];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    /*
    if ([[resultController sections] count] > 0 ) {
        
        return [[resultController sections] count];
        
    }else{
        
        return 0;
    }
     */
    return [[resultController sections] count];
   
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[resultController sections] count] > 0 ) {
        id<NSFetchedResultsSectionInfo> sectionInfo = [[resultController sections] objectAtIndex:section];
        return [sectionInfo name];
    }else{
        
        return nil;
    }
    
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[resultController sections] objectAtIndex:section]numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basic cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"basic cell"];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexPath];
    
    NSString *timeStr = [managedObject valueForKey:@"date"];
    NSString *siteStr = [managedObject valueForKey:@"site"];
    NSString *gasStr = [managedObject valueForKey:@"gas_type"];
    NSString *detailStr = [NSString stringWithFormat:@"%@ %@",siteStr,gasStr];
    NSData *imgData = [managedObject valueForKey:@"photos"];
    
    if (imgData == NULL) {
        cell.textLabel.text = timeStr;
        cell.detailTextLabel.text = detailStr;
    } else {
        cell.imageView.image = [UIImage imageWithData:imgData];
        cell.textLabel.text = timeStr;
        cell.detailTextLabel.text = detailStr;
    }
    
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSError *error = nil;
        [delegate_logbook.managedObjectContext deleteObject:[resultController objectAtIndexPath:indexPath]];
        if (![delegate_logbook.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", [error localizedFailureReason]);
        }
        
        //[_logDatabase fetchData];
        
        [self fetchData];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    pageViewController.startPage = indexPath.row;//*((int *)indexPath.row);
    pageViewController._section = indexPath.section;//*((int *)indexPath.section);
    [delegate_logbook.navi pushViewController:pageViewController animated:YES];
    
    
    NSLog(@"Table:%li Row & %li Section", (long)indexPath.row,(long)indexPath.section);
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
