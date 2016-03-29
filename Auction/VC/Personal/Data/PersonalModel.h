//
//  PersonalModel.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/25.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "BaseModel.h"

@interface PersonalModel : BaseModel

/**
 *   "code": 200,
 "message": "我的拍卖头部信息",
 "data": {
 "username": "test",
 "auctioning": "1",
 "boughtaction": "2"
 }
 */

@property(nonatomic , copy)NSString *username;
@property(nonatomic , copy)NSString *auctioning;
@property(nonatomic , copy)NSString *boughtaction;

@end
