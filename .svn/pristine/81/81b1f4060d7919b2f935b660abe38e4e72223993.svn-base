//
//  UIImage+Scale.m
//  GetUp
//
//  Created by 木木木 on 14/12/10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

+ (UIImage *)compressImage:(UIImage *)image {
    
    CGSize size = CGSizeMake(320, 320);
    // 创建context
    UIGraphicsBeginImageContext(size);
    // 改变大小的图片
    [image drawInRect:CGRectMake(0, 0, 320, 320)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return compressedImage;
}

+ (UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size {
    
    // 创建context
    UIGraphicsBeginImageContext(size);
    // 改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
