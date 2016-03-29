//
//  CashUseCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "CashUseCell.h"

@implementation CashUseCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel2:(CashDetailModel *)model2
{
    _model2 = model2;
    if ([_model2.frozen_end isEqualToString:@"<null>"] || [_model2.frozen_end isEqualToString:@"0"])
    {
        self.timeLabel2.text = _model2.frozen_start;
    }else
    {
    self.timeLabel2.text = [NSString stringWithFormat:@"%@至%@",_model2.frozen_start,_model2.frozen_end];
    }
    [self.themeImageU sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.212.63/shepai/%@" ,_model2.img]]];
    self.titleLabel.text = _model2.name;
    self.iceMoneyLabel.text = [NSString stringWithFormat:@"冻结保证金：%@",_model2.deposit];
    self.stateLab.text = _model2.deposit_status;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
