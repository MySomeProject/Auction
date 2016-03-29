//
//  PatProduceModel.h
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/6/30.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatProduceModel : NSObject


@property(nonatomic,copy)NSNumber *uid;
@property(nonatomic,copy)NSString *auct_title;
@property(nonatomic,copy)NSString *auct_price;
@property(nonatomic,copy)NSString *visit;
@property(nonatomic,copy)NSString *start_time;
@property(nonatomic,copy)NSString *end_time;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *auct_number;
@property(nonatomic,copy)NSString *put_price;

//@property(nonatomic,copy)NSString *imageView;
//@property(nonatomic,copy)NSString *rightUpLabelString;
//@property(nonatomic,copy)NSString *rightDownLeftString;
//@property(nonatomic,copy)NSString *rightDownRightString;
@property(nonatomic,copy)NSString *spec_name;
@property(nonatomic,copy)NSString *auct_count;

@end
