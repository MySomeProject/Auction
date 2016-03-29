//
//  CashDrawCell.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashDetailModel.h"

@interface CashDrawCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel1;  //提交保证金

@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;   //提交时间

@property (weak, nonatomic) IBOutlet UILabel *cardLabel;    //退款卡号

@property (weak, nonatomic) IBOutlet UILabel *numberLabel1;   //订单号

@property(nonatomic ,strong)CashDetailModel *model1;



@end
