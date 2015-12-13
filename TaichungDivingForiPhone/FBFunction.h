//
//  FBFunction.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/12/1.
//  Copyright © 2015年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <FBSDKLoginKit/FBSDKLoginManager.h>
#import <FBSDKLoginKit/FBSDKLoginManagerLoginResult.h>

@protocol FBFunctionDelegate;

@interface FBFunction : NSObject<FBSDKGraphRequestConnectionDelegate>//<FBSDKSharingDelegate>

@property (nonatomic,weak) UIViewController <FBFunctionDelegate> *delegate;

- (instancetype)initWithTitle:(NSString *)title contents:(NSString *)description
                            photo:(UIImage *)photo;

/*
-(void)FBLoging;
-(void)FBSharing:(NSString *)description;
-(void)FBSharingPhoto:(NSString *)description sharePhoto:(UIImage *)img;
*/

//- (FBSDKShareOpenGraphContent *)contentForSharing;
- (void)start;

@end

@protocol FBFunctionDelegate

- (void)shareUtility:(FBFunction *)shareUtility didFailWithError:(NSError *)error;
- (void)shareUtilityWillShare:(FBFunction *)shareUtility;
- (void)shareUtilityDidCompleteShare:(FBFunction *)shareUtility;
- (void)shareUtilityUserShouldLogin:(FBFunction *)shareUtility;
@end
