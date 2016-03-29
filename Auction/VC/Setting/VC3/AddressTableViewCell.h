//
//  AddressTableViewCell.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/7.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressTableViewCell : UITableViewCell

@property(nonatomic ,copy)UILabel *nameLabel;
@property(nonatomic ,copy)UILabel *numberLabel;
@property(nonatomic ,copy)UILabel *addressLabel;

@property(nonatomic ,copy)NSString *locationStr;
@property(nonatomic ,copy)NSString *addressStr;

@property(nonatomic ,copy)UIButton *selectButton;
@property(nonatomic ,copy)UIButton *addButton;
@property(nonatomic ,copy)UIButton *deleteButton;

-(void)setnameLabelText:(NSString *)text1 numberLabelText:(NSString *)text2 addressLabel:(NSString *)text3;

//model
@property(nonatomic ,strong)AddressModel *modelAdd;

@end
