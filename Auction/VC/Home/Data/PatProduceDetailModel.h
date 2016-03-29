//
//  PatProduceDetailModel.h
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/21.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatProduceDetailModel : NSObject

@property(nonatomic,copy)NSString *start_time;
@property(nonatomic,copy)NSString *end_time;
@property(nonatomic,copy)NSString *auct_time;//系统时间
@property(nonatomic,copy)NSString *showTime;
@property(nonatomic,copy)NSString *good_deposit;
@property(nonatomic,copy)NSString *good_name;
@property(nonatomic,copy)NSString *good_price;
@property(nonatomic,copy)NSString *good_rangeprice;

@end
