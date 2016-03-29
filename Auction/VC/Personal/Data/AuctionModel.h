//
//  AuctionModel.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/30.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "BaseModel.h"

@interface AuctionModel : BaseModel

//* aid:拍品id
//* img：拍品图片
//* name：拍品名称
//* deposit：拍品保证金
//* end_time:竞拍结束时间
//* bid_price：当前竞拍价格
//* bid_times:当前竞拍次数


@property(nonatomic , copy)NSString *aid;
@property(nonatomic , copy)NSString *img;
@property(nonatomic , copy)NSString *name;
@property(nonatomic , copy)NSString *deposit;
@property(nonatomic , copy)NSString *end_time;
@property(nonatomic , copy)NSString *bid_price;
@property(nonatomic , copy)NSString *bid_times;


/**
 * aid:拍品id
 * img：拍品图片
 * name：拍品名称
 * pay_price：拍下价格
 * generation_time:拍下时间
 * order_status：订单状态
 * pay_method：支付方式（只有已支付的才有）
 * 返回参数增加一个判断字段order_num（1：订单已完成；2：未付款；3：未确认收货地址；4：未发货；5：已发货；）
 */

@property(nonatomic , copy)NSString *generation_time;
@property(nonatomic , copy)NSString *pay_price;
@property(nonatomic , copy)NSString *order_status;
@property(nonatomic , copy)NSString *pay_method;
@property(nonatomic , copy)NSString *order_num;



/**
 * aid:拍品id
 * img：拍品图片
 * name：拍品名称
 * bid_price：当前竞拍价格
 * auction_status:拍品状态
 */

@property(nonatomic , copy)NSString *auction_status;
@property(nonatomic , copy)NSString *orderid;

/**
 "code": 200,
 "message": "查看订单详情",
 "data": {
 "order_sn": "4564564554654",
 "pay_price": "782.00",
 "aid": "10",
 "deliver_status": "0",
 "confirm_status": "1",
 "pay_name": "fhfhfgh",
 "generation_time": "1437363003",
 "img": "data\/uploads\/2014\/05\/04\/451b95af03616fd150e78fdc84a22378.jpg",
 "name": "复古风唐装男士长袖衬衫 韩版修身灯芯绒盘扣莲花秀男式休闲衬衣",
 "accept_name": "晓飞 宁",
 "mobile": "13589100333",
 "addr": "山东省ddddddd",
 "order_status": "未发货"
 }
 */

/**
 * order_sn:订单号
 * pay_price:成交价
 * pay_name:支付方式
 * generation_time:成交时间
 * img：拍品图片
 * name：拍品名字
 * accept_name:收货人姓名
 * mobile：收货人电话
 * addr：收货人地址
 * order_status:订单状态
 * deliver_status:支付状态
 * confirm_status:确认状态
 */


@property(nonatomic , copy)NSString *order_sn;
@property(nonatomic , copy)NSString *deliver_status;
@property(nonatomic , copy)NSString *confirm_status;
@property(nonatomic , copy)NSString *pay_name;
@property(nonatomic , copy)NSString *accept_name;
@property(nonatomic , copy)NSString *mobile;
@property(nonatomic , copy)NSString *addr;
@property(nonatomic , copy)NSString *waybill_number;  //货运单号;

//新增参数：waybill_number：货运单号

@end
