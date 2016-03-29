//
//  CashSubmitCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "CashSubmitCell.h"

@implementation CashSubmitCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(CashDetailModel *)model
{
    _model = model;
    self.moneyLabel.text = _model.recharge_price;
    self.timeLabel.text = _model.add_time;
    self.payState.text = _model.name;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
