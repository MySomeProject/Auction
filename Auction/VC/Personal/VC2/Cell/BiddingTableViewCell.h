//
//  BiddingTableViewCell.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionModel.h"

@interface BiddingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *themeImageB;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel1;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel1;

@property (weak, nonatomic) IBOutlet UILabel *bidLabel1;


@property(nonatomic , strong)AuctionModel *data1;


@end
