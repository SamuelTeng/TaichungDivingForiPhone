//
//  PhotoViewController.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/9/13.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#import "AppDelegate.h"
#import "LogViewController.h"

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

@interface PhotoViewController (){
    
    AppDelegate *delegate;
    LogViewController *logView;

}

@end

@implementation PhotoViewController

@synthesize assets,collectionView;


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
 
     self.collectionView.backgroundView = backgroundImg;

 
 
 
 }
 if(IS_IPHONE_5)
 {
 
     NSLog(@"IS_IPHONE_5");
 
     UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i5"]];
 
     self.collectionView.backgroundView = backgroundImg;

 
 
 
 }
 if(IS_IPHONE_6)
 {
 
     NSLog(@"IS_IPHONE_6");
 
     UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6"]];
 
     //[self.view insertSubview:backgroundImg belowSubview:collectionView];
     
     self.collectionView.backgroundView = backgroundImg;
 }
 if(IS_IPHONE_6P)
 {
 
     NSLog(@"IS_IPHONE_6P");
 
     UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.bundle/Background_i6P"]];
     
     self.collectionView.backgroundView = backgroundImg;

 
 }
}

 

+(ALAssetsLibrary *)defaultAssetLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred , ^{
        library = [[ALAssetsLibrary alloc] init];
        
    });
    return library;
}

-(void)fetchCameraRoll
{
    assets = [@[]mutableCopy];
    NSMutableArray *tmpAssets= [@[] mutableCopy];
    
    ALAssetsLibrary *assetsLibrary = [PhotoViewController defaultAssetLibrary];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                [tmpAssets addObject:result];
                
            }
        }
         ];
        self.assets = tmpAssets;
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = [[UIApplication sharedApplication] delegate];
    logView = [[LogViewController alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
    
    [self.view addSubview:self.collectionView];
    
    
    [self fetchCameraRoll];
    [self detectingDevice];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchCameraRoll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoCell *cell = (PhotoCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset * asset = self.assets[indexPath.row];
    
    UIImageView *cellImage = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[asset thumbnail]]];
    [cell addSubview:cellImage];
    
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 40, 30);//UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize cellSize = CGSizeMake(100, 100);
    cellSize.height += 35; cellSize.width += 35;
    return cellSize;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ALAsset *selectedImageAsset = self.assets[indexPath.row];
    UIImage *beSelectedImage = [UIImage imageWithCGImage:[selectedImageAsset thumbnail]];
    delegate.selectedCellImage = beSelectedImage;
    logView.viewReserved = 1;
    [delegate.navi popViewControllerAnimated:YES];
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
