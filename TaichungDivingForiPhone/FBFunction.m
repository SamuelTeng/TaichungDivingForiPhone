//
//  FBFunction.m
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/12/1.
//  Copyright © 2015年 Samuel Teng. All rights reserved.
//

#import "FBFunction.h"

@implementation FBFunction{
    
    NSString *_title;
    NSString *_description;
    UIImage *_photo;
    FBSDKShareAPI *_shareAPI;
    FBSDKShareDialog *_shareDialog;
}

#pragma FBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    UIAlertView *published = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Successed", nil) message:NSLocalizedString(@"Posted", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [published show];
    
    [_delegate shareUtilityDidCompleteShare:self];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    UIAlertView *published = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [published show];
    
    [_delegate shareUtility:self didFailWithError:error];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    UIAlertView *published = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) message:NSLocalizedString(@"Canceled", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [published show];
    
    [_delegate shareUtility:self didFailWithError:nil];
}

#pragma Facebook Function
- (instancetype)initWithTitle:(NSString *)title contents:(NSString *)description
                            photo:(UIImage *)photo;
{
    if ((self = [super init])) {
        
        _title = [title copy];
        _description = [description copy];
        _photo = [self _normalizeImage:photo];
        
        FBSDKShareOpenGraphContent *shareContent = [self contentForSharing];
        
        _shareAPI = [[FBSDKShareAPI alloc] init];
        _shareAPI.delegate = self;
        _shareAPI.shareContent = shareContent;
        
        _shareDialog = [[FBSDKShareDialog alloc] init];
        _shareDialog.delegate = self;
        _shareDialog.shouldFailOnDataError = YES;
        _shareDialog.shareContent = shareContent;
        
        
    }
    
    return self;
    
}

- (void)start
{
    [self _postOpenGraphAction];
}

-(void)FBLoging
{
    if (![FBSDKAccessToken currentAccessToken]) {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithPublishPermissions:@[@"publish_actions"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                // Handle cancellations
                NSLog(@"Handle cancellations: %@, %@, %@", result, result.grantedPermissions, [FBSDKAccessToken currentAccessToken]);
            } else {
                if ([result.grantedPermissions containsObject:@"publish_actions"]) {
                    NSLog(@"with publish_actions");
                } else {
                    NSLog(@"without publish_actions");
                }
            }
        }];
        return;
    } else if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        NSLog(@"use publish_actions");
    }
    
    NSLog(@"token: %@", [FBSDKAccessToken currentAccessToken]);
    
}

-(void)FBSharing:(NSString *)description
{
    if (![FBSDKAccessToken currentAccessToken]) {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithPublishPermissions:@[@"publish_actions"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)  {
            if (error) {
                // Process error
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                // Handle cancellations
            } else {
                if ([result.grantedPermissions containsObject:@"publish_actions"]) {
                    [self useFacebookSDK:description];
                } else {
                    [self useFacebookApp:description];
                }
            }
        }];
        return;
    } else if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        [self useFacebookSDK:description];
    } else {
        [self useFacebookApp:description];
    }
    return;
}

-(void)useFacebookApp:(NSString *)description
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://www.td-club.com.tw/index.asp"];
    content.contentTitle = @"非潛不可";
    content.contentDescription = description;
    content.imageURL = [NSURL URLWithString:@"http://www.td-club.com.tw/images/Banner/TDTC.png"];
    [FBSDKShareDialog showFromViewController:nil
                                 withContent:content
                                    delegate:nil];
}

-(void)useFacebookSDK:(NSString *)description
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://www.td-club.com.tw/index.asp"];
    content.contentTitle = @"非潛不可";
    content.contentDescription = description;
    content.imageURL = [NSURL URLWithString:@"http://www.td-club.com.tw/images/Banner/TDTC.png"];
    [FBSDKShareAPI shareWithContent:content delegate:self];
}

- (FBSDKShareOpenGraphContent *)contentForSharing
{
    
    
    NSDictionary *objectProperties = @{@"og:type" : @"mustdiveapp:fadiving",
                                       @"og:title": _title,
                                       @"og:description" :_description};
    FBSDKShareOpenGraphObject *object = [FBSDKShareOpenGraphObject objectWithProperties:objectProperties];
    
    FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
    action.actionType = @"mustdiveapp:divinglog";
    [action setObject:object forKey:@"mustdiveapp:fadiving"];
    [action setArray:@[[FBSDKSharePhoto photoWithImage:_photo userGenerated:YES]] forKey:@"og:image"];
    
    FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
    content.action = action;
    content.previewPropertyName = @"mustdiveapp:fadiving";
    
    return content;
    
}

- (void)_postOpenGraphAction
{
    NSString *const publish_actions = @"publish_actions";
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:publish_actions]) {
        [self.delegate shareUtilityWillShare:self];
        [_shareAPI share];
    } else {
        [[[FBSDKLoginManager alloc] init]
         logInWithPublishPermissions:@[publish_actions]
         fromViewController:nil
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if ([result.grantedPermissions containsObject:publish_actions]) {
                 [self.delegate shareUtilityWillShare:self];
                 [_shareAPI share];
             } else {
                 // This would be a nice place to tell the user why publishing
                 // is valuable.
                 [_delegate shareUtility:self didFailWithError:nil];
             }
         }];
    }
}

- (UIImage *)_normalizeImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGSize imageSize = bounds.size;
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    
    switch (orient) {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        default:
            // image is not auto-rotated by the photo picker, so whatever the user
            // sees is what they expect to get. No modification necessary
            transform = CGAffineTransformIdentity;
            break;
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ((image.imageOrientation == UIImageOrientationDown) ||
        (image.imageOrientation == UIImageOrientationRight) ||
        (image.imageOrientation == UIImageOrientationUp)) {
        // flip the coordinate space upside down
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

@end
