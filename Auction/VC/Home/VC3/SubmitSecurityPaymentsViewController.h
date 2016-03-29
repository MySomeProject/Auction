//
//  SubmitSecurityPaymentsViewController.h
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/2.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPPayPluginDelegate.h"

@interface SubmitSecurityPaymentsViewController : UIViewController<UPPayPluginDelegate>


@property(nonatomic,copy)NSString *goods_nameStr;
@property(nonatomic,copy)NSString *goods_priceStr;
@property(nonatomic,copy)NSString *order_snStr;
@property(nonatomic,copy)NSString *user_idStr;
@property(nonatomic,copy)NSNumber *auction_ID;
@property(nonatomic,copy)NSString *despositStr;
@property(nonatomic,copy)NSString *alipayStr;
@property(nonatomic,retain)NSString *tnNum;
@property(nonatomic, copy)NSString *tnMode;

@end
