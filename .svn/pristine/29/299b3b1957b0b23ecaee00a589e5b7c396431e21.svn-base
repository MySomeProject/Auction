//
//  CashDetailModel.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "BaseModel.h"

@interface CashDetailModel : BaseModel

/**
 "code": 200,
 "message": "保证金",
 "data": {
 "deposit_account": -900,
 "deposit_frozen": 200,
 "deposit_thaw": -1100,
 "account_state": 1
 }
 */

@property(nonatomic , copy)NSString *deposit_account;
@property(nonatomic , copy)NSString *deposit_frozen;
@property(nonatomic , copy)NSString *deposit_thaw;
@property(nonatomic , copy)NSString *account_state;
//@property(nonatomic , copy)NSString *img;


/**
 "code": 200,
 "message": "提交保证金明细",
 "data": [
 {
 "recharge_price": "200",
 "name": "建行",
 "add_time": "2015-07-15 15:01:10"
 },
 
 */

//提交保证金明细
@property(nonatomic , copy)NSString *recharge_price;
@property(nonatomic , copy)NSString *name;
@property(nonatomic , copy)NSString *add_time;


/**
 "code": 200,
 "message": "提取保证金明细",
 "data": [
 {
 "extra_price": "100.00",
 "brand_cardnumber": "423453453645",
 "add_time": "2015-07-24 13:25:23"
 },
 
 
 */


//提取保证金明细
@property(nonatomic , copy)NSString *extra_price;
@property(nonatomic , copy)NSString *brand_cardnumber;


/**
 "code": 200,
 "message": "保证金使用明细",
 "data":  [
 {
 "start_time": "1438065255",
 "end_time": "1438151659",
 "img": "data\/uploads\/2014\/05\/04\/b1dcd910f2d270c11d91668ecfbf7302.jpg",
 "name": "职业女装纯棉内搭白色寸衫水钻领子带钻翻领衬衫搭配小西装打底衫",
 "deposit": "0.00",
 "aid": "13",
 "add_time": "1437706258",
 "deposit_status": "冻结中",
 "frozen_start": "1437706258",
 "frozen_end": 0
 }
 * img:拍品图片
 * name：拍品名称
 * deposit：保证金额
 * deposit_status：保证金状态
 * frozen_start：保证金冻结开始时间
 * frozen_end：保证金冻结结束时间
 
 */

@property(nonatomic , strong)NSString *start_time;
@property(nonatomic , copy)NSString *end_time;
@property(nonatomic , strong)NSString *img;
@property(nonatomic , copy)NSString *deposit;
@property(nonatomic , copy)NSString *deposit_status;
@property(nonatomic , copy)NSString *frozen_start;
@property(nonatomic , copy)NSString *frozen_end;


/**
 "code": 200,
 "message": "扣除保证金详情",
 "data": {
 "4": {
 "aid": "11",
 "img": "data\/uploads\/2014\/05\/04\/16615175a6eff3846c20d4e68100ed70.jpg",
 "name": "2014春装新款长袖衬衫男 韩版修身灯芯绒波点衬衫男士衬衫上衣潮",
 "deposit": "200.00",
 "deposit_status": "已扣除",
 "deduction_time": "1436438533"
 }
 */

@property(nonatomic , copy)NSString *deduction_time;

@end
