//
//  UIImage+Scale.h
//  GetUp
//
//  Created by 木木木 on 14/12/10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

+ (UIImage *)compressImage:(UIImage *)image;
+ (UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size;

@end
