//
//  FBFunction.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/12/1.
//  Copyright © 2015年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <FBSDKLoginKit/FBSDKLoginManager.h>
#import <FBSDKLoginKit/FBSDKLoginManagerLoginResult.h>

@protocol FBFunctionDelegate;

@interface FBFunction : NSObject<FBSDKSharingDelegate>

@property (nonatomic,weak) UIViewController <FBFunctionDelegate> *delegate;

- (instancetype)initWithTitle:(NSString *)title contents:(NSString *)description
                            photo:(UIImage *)photo;


-(void)FBLoging;
-(void)FBSharing:(NSString *)description;
-(void)useFacebookApp:(NSString *)description;
-(void)useFacebookSDK:(NSString *)description;
- (FBSDKShareOpenGraphContent *)contentForSharing;
- (void)start;

@end

@protocol FBFunctionDelegate

- (void)shareUtility:(FBFunction *)shareUtility didFailWithError:(NSError *)error;
- (void)shareUtilityWillShare:(FBFunction *)shareUtility;
- (void)shareUtilityDidCompleteShare:(FBFunction *)shareUtility;
- (void)shareUtilityUserShouldLogin:(FBFunction *)shareUtility;
@end
