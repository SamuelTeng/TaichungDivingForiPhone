//
//  PhotoCell.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/9/13.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

@synthesize asset,photoImage;

-(void)setAsset:(ALAsset *)aSset
{
    
    self.photoImage.image = [UIImage imageWithCGImage:[aSset thumbnail]];
    
    
}

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height)];
        
        self.photoImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.photoImage];
        self.photoImage.clipsToBounds = YES;
    }
    
    return self;
}

@end
