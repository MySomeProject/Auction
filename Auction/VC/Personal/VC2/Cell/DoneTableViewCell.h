//
//  DoneTableViewCell.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionModel.h"

@interface DoneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *themeImageD;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel2;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel2;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;

//@property (weak, nonatomic) IBOutlet UILabel *payState2;
//@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@property(nonatomic ,copy)NSString *sig;

//拍品ID
@property(nonatomic , copy)NSString *auctionID;

@property(nonatomic , strong) AuctionModel *data2;

@end
