//
//  AddressModel.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/31.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

/**
 "code": 600,
 "message": "获取地址列表成功",
 "data": {
 "address": [
 {
 "id": "23",
 "user_id": "1000",
 "accept_name": "wqewqeqwe",
 "mobile": "13434343434",
 "phone": null,
 "province": "150000",
 "city": "150300",
 "county": "150302",
 "zip": null,
 "addr": null,
 "is_default": "1",
 "add_time": "2015-07-31 18:11:59"
 }
 
 
 "code": 200,
 "message": "默认设置提醒方式",
 "data": {
 "remindway": 2
 }
 
 
 */

@property(nonatomic,copy)NSString *user_id;    //用户的ID
@property(nonatomic,copy)NSString *set_id;    //地址的ID
@property(nonatomic,copy)NSString *accept_name;   //收货人姓名
@property(nonatomic,copy)NSString *mobile;       //联系电话
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *province;     //省份
@property(nonatomic,copy)NSString *city;         //城市
@property(nonatomic,copy)NSString *county;        //详细地址
@property(nonatomic,copy)NSString *zip;
@property(nonatomic,copy)NSString *addr;
@property(nonatomic,copy)NSString *is_default;
@property(nonatomic,copy)NSString *add_time;       //添加时间
@property(nonatomic,copy)NSString *remindway;

@end
