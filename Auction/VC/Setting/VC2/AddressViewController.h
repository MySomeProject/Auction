//
//  AddressViewController.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressViewController : UIViewController

@property(nonatomic,strong)UITableView *addressTabelView;

@property(nonatomic , copy)NSString *titleLabel;

@property(nonatomic , copy)NSString *addBtnTitle;    //添加收货地址的button标题

@property(nonatomic , strong)AddressModel *addModel;

@property(nonatomic , copy)NSString *orderID;


@end
