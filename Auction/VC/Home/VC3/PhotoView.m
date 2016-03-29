//
//  PhotoView.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/25.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

{
    //设置全局属性，注意位置，这个是私有属性
    UIImageView *imageView;
}


//重写initWithFrame方法
-(instancetype)initWithFrame:(CGRect)frame
{
    //调用父类的initWithFrame：方法进行初始化
    self = [super initWithFrame:frame];
    if(self)
    {
        //为PhotoView添加新的属性
        //设置imageView的大小和PhotoView的大小一致
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        [self addSubview:imageView];
        
        //隐藏滑动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        //设置分页
        self.pagingEnabled = YES;
        
        //设置代理
        self.delegate = self;
    }
    
    //返回当前的对象，self指的是PhotoView这个类的一个对象
    return self;
}


//在layoutSubviews方法中设置imageView的图片属性
- (void)layoutSubviews
{
    imageView.image = self.image;
}

#pragma mark - UIscrollViewDelegate

@end
