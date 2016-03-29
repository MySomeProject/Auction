//
//  DoneTableViewCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "DoneTableViewCell.h"
#import "AOColorFormat.h"

@implementation DoneTableViewCell

/**
 * aid:拍品id
 * img：拍品图片
 * name：拍品名称
 * pay_price：拍下价格
 * generation_time:拍下时间
 * order_status：订单状态
 * pay_method：支付方式（只有已支付的才有）
 */

- (void)awakeFromNib {
    // Initialization code
}

-(void)setData2:(AuctionModel *)data2
{
    _data2 = data2;
    [self.themeImageD sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.212.63/shepai/%@" ,_data2.img ]]];
    
    self.titleLabel2.text = _data2.name;
    self.moneyLabel2.text = _data2.pay_price;
    self.stateLabel2.text = [NSString stringWithFormat:@"订单状态：%@", _data2.order_status];
    self.timeLabel2.text = _data2.generation_time;
//    self.payState2.text = [NSString stringWithFormat:@"支付方式：%@", _data2.pay_method];
    self.sig = _data2.order_num;
    self.auctionID = _data2.aid;
    
    NSLog(@"%@",self.stateLabel2.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
