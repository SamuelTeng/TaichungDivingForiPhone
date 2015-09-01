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
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
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
    return [[resultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[resultController sections] objectAtIndex:section]numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basic cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basic cell"];
    }
    
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexPath];
    
    NSString *timeStr = [managedObject valueForKey:@"date"];
    
    
    cell.textLabel.text = timeStr;
    
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
