//
//  SessionListCell.h
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionListModel.h"
@interface SessionListCell : UITableViewCell

@property(nonatomic,retain)NSTimer *timer;

@property(nonatomic,retain)SessionListModel *model;
@property(nonatomic,copy)NSNumber *id;
@property(nonatomic,copy)NSString *typeString;
@property(nonatomic,retain)NSMutableArray *typeStringArray;

@end
