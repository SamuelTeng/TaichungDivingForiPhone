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

@interface PhotoViewController (){
    
    AppDelegate *delegate;
    LogViewController *logView;

}

@end

@implementation PhotoViewController

@synthesize assets,collectionView;

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
    
    [self.collectionView setBackgroundColor:[UIColor brownColor]];
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
    [self.view addSubview:self.collectionView];
    
    [self fetchCameraRoll];

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
    return UIEdgeInsetsMake(10, 10, 10, 10);
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
