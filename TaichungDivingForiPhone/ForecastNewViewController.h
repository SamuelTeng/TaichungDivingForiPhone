//
//  ForecastNewViewController.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/8/25.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface ForecastNewViewController : GAITrackedViewController<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

-(UIBarButtonItem*)refreshBarButton;
-(UIBarButtonItem *)stopBarButton;


@end
