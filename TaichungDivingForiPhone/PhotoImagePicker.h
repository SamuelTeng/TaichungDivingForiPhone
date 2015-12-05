//
//  PhotoImagePicker.h
//  TaichungDivingForiPhone
//
//  Created by Samuel Teng on 2015/12/5.
//  Copyright © 2015年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PhotoImagePickerDelegate;

@interface PhotoImagePicker : NSObject

@property (nonatomic, weak) id<PhotoImagePickerDelegate> delegate;

- (void)presentFromRect:(CGRect)rect inView:(UIView *)view;
- (void)presentWithViewController:(UIViewController *)viewController;

@end

@protocol PhotoImagePickerDelegate

- (void)imagePicker:(PhotoImagePicker *)imagePicker didSelectImage:(UIImage *)image;
- (void)imagePickerDidCancel:(PhotoImagePicker *)imagePicker;

@end
