//
//  CashDeductCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "CashDeductCell.h"

@implementation CashDeductCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel3:(CashDetailModel *)model3
{
    _model3 = model3;
    
    self.deductLabel.text = _model3.deposit;
    self.timeLabel3.text = _model3.deduction_time;
    self.titleLabel2.text = _model3.name;
    [self.themeImageD sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.212.63/shepai/%@" ,_model3.img]]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
