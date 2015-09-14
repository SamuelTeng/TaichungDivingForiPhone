//
//  PhotoCell.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/9/13.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoCell : UICollectionViewCell

@property (nonatomic,strong) ALAsset *asset;

@property (nonatomic,strong) UIImageView *photoImage;

@end
