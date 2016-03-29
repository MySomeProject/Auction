//
//  RemindSpecialTableViewCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/23.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "RemindSpecialTableViewCell.h"

@implementation RemindSpecialTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(RemindModel *)model
{
    _model = model;
    [self.themeImage sd_setImageWithURL:[NSURL URLWithString:_model.img]];
    self.titleLabel.text = _model.name;
    self.organizationLabel.text =[NSString stringWithFormat:@"%@(%@件送拍产品)",_model.inst_name,_model.auct_count] ;

    if ([_timeStates.text isEqualToString:@"开始时间"]) {
        
        self.startTimeLabel.text = _model.start_time;
        self.biddingLabel.text = _model.visit;
        self.bidMoneyLabel.text = _model.deposit;
        
    }else
    {
        self.startTimeLabel.text = _model.end_time;
        self.biddingLabel.text = _model.auct_peoples;
        self.bidMoneyLabel.text = _model.auct_number;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
