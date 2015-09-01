//
//  TourDetailViewController.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourDetailViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSDictionary *pageData;

@end
