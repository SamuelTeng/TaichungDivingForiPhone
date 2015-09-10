//
//  TourTableViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "TourTableViewController.h"
#import "TourDetailViewController.h"

#define kSection 2
#define kDomestic 0
#define kForeign 1

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

@interface TourTableViewController ()


@end

@implementation TourTableViewController
@synthesize domesticTour,foreignTour;

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


-(id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Tour", nil);
        
        [self detectingDevice];
        
        domesticTour=[[NSMutableArray alloc]init];
        
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"NoEa", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E5_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Liuqiu", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E2_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"GreenI", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E3_3D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"OrchidI", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E4_3D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Penghu", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E6_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Kenting", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E1_2D",@"url", nil]];
        
        foreignTour=[[NSMutableArray alloc]init];
        
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Maldives", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G1_9D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Similan", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G3_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"SuluS", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G4_7D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"GBR", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F05_9D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Mindoro", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F10_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Palau", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F12_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Sipadan", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F16_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"TiomanI", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F18_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Moaboal", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F19_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Anilao", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F01_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Dumaguete", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F03_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Bohol", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F02_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Okinawa", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F11_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Phuket", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F13_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Maratua", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F21_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Tulamben", nil),@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F20_6D",@"url", nil]];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    domesticTour = nil;
    foreignTour = nil;
    
}

-(NSArray *)whichArray:(NSUInteger)integer
{
    NSArray *current;
    switch (integer) {
        case kDomestic:
            current=domesticTour;
            break;
            
        case kForeign:
            current=foreignTour;
            break;
        default:
            break;
    }
    return current;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return kSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    switch (section) {
        case kDomestic:
            return [domesticTour count];
            break;
            
        case kForeign:
            return [foreignTour count];
            break;
            
        default:
            return 0;
            break;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier=@"DivingTour";
    UITableViewCell *cell=[tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    NSArray *current;
    switch (indexPath.section) {
        case kDomestic:
            current=domesticTour;
            break;
            
        case kForeign:
            current=foreignTour;
            break;
        default:
            break;
    }
    NSDictionary *rowData=[current objectAtIndex:indexPath.row];
    cell.textLabel.text=[rowData objectForKey:@"page"];
    cell.detailTextLabel.text=[rowData objectForKey:@"url"];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    return cell;
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case kDomestic:
            return NSLocalizedString(@"Domestic", nil);
            break;
        case kForeign:
            return NSLocalizedString(@"Foreign", nil);
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *current=[self whichArray:indexPath.section];
    NSDictionary *selectedPage=[current objectAtIndex:indexPath.row];
    
    TourDetailViewController *tourDetailView = [[TourDetailViewController alloc] init];
    tourDetailView.pageData=selectedPage;
    [self.navigationController pushViewController:tourDetailView animated:YES];
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
