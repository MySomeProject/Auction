//
//  Single.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/8/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "Single.h"

@implementation Single

+(Single *)shareSingle
{
    static Single *single = nil;
    if (single == nil) {
        single = [[Single alloc]init];
    }
    return single;
}

@end
