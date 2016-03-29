//
//  CashDrawCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "CashDrawCell.h"

@implementation CashDrawCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel1:(CashDetailModel *)model1
{
    _model1 = model1;
    self.moneyLabel1.text = _model1.extra_price;
    self.timeLabel1.text = _model1.add_time;
    self.numberLabel1.text = _model1.brand_cardnumber;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
