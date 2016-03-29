//
//  RemindTableViewCell.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "RemindTableViewCell.h"

@implementation RemindTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel1:(RemindModel *)model1
{
    _model1 = model1;
    [self.themeImage sd_setImageWithURL:[NSURL URLWithString:_model1.img]];
    self.themeLabel.text = _model1.name;
    if ([self.statesLabel.text isEqualToString:@"开始"]) {
        
        self.startLabel.text = _model1.start_time;
        self.moneyLabel.text = _model1.price;
        self.scanLabel.text = _model1.visit;

    }else
    {
        self.startLabel.text = _model1.end_time;
        self.moneyLabel.text = _model1.price;
        self.scanLabel.text = _model1.times;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
