//
//  FinishTableViewCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/25.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "FinishTableViewCell.h"

@implementation FinishTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setData3:(AuctionModel *)data3
{
    _data3 = data3;
    [self.themeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.212.63/shepai/%@" ,_data3.img]]];
    self.titleLabel.text = _data3.name;
    self.stateLabel.text = _data3.auction_status;
    self.moneyLabel.text = [NSString stringWithFormat:@"成交金额：%@",_data3.bid_price] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
