//
//  BiddingTableViewCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

/**
 * aid:拍品id
 * img：拍品图片
 * name：拍品名称
 * deposit：拍品保证金
 * end_time:竞拍结束时间
 * bid_price：当前竞拍价格
 * bid_times:当前竞拍次数
 */

#import "BiddingTableViewCell.h"


@implementation BiddingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setData1:(AuctionModel *)data1
{
    _data1 = data1;
    
    [self.themeImageB sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.212.63/shepai/%@" ,_data1.img]]];
    self.timeLabel1.text =_data1.end_time;
    [self.titleLabel1 setText:_data1.name];
    [self.endTimeLabel1 setText:[NSString stringWithFormat:@"%@  结束",_data1.end_time]];
    [self.moneyLabel1 setText:_data1.deposit];
    [self.bidLabel1 setText:[NSString stringWithFormat:@"%@次竞价",_data1.bid_times]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
