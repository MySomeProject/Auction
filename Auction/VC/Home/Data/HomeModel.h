//
//  HomeModel.h
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject


@property(nonatomic,copy)NSString *spec_name;
@property(nonatomic,copy)NSNumber *id;
@property(nonatomic,copy)NSString *spec_image;
@property(nonatomic,copy)NSString *start_time;//专场开始时间
@property(nonatomic,copy)NSString *end_time;//专场结束时间
@property(nonatomic,copy)NSString *visit;
@property(nonatomic,copy)NSString *auct_count;
@property(nonatomic,copy)NSString *inst_name;
@property(nonatomic,retain)NSNumber *now_time;//服务器时间
@property(nonatomic,copy)NSString *auction_peoples;
@property(nonatomic,copy)NSString *auction_number;
@property(nonatomic,copy)NSString *deposit;
@property(nonatomic,copy)NSString *showTime;
//添加图片数组属性
@property(nonatomic,retain)NSMutableArray *photoArray;


//@property(nonatomic,copy)NSString *bigLableString;
//@property(nonatomic,copy)NSString *midLableString;
//@property(nonatomic,copy)NSString *downLeftLableString;
//@property(nonatomic,copy)NSString *downRightLableString;
//@property(nonatomic,copy)NSString *rightLableString;
//@property(nonatomic,copy)NSString *rightDownLableString;
//@property(nonatomic,copy)NSString *hourLableString;
//@property(nonatomic,copy)NSString *minuteLableString;
//@property(nonatomic,copy)NSString *secondLableString;

@end
