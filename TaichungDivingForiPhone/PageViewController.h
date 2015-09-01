//
//  PageViewController.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController<UIPageViewControllerDelegate>

@property (nonatomic) NSInteger startPage;
@property (nonatomic) NSInteger _section;


@end
