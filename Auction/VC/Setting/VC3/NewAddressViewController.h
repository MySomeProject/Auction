//
//  NewAddressViewController.h
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/9.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZAreaPickerView.h"


@protocol ChangeDelegate;  //通知编译器有此代理


@interface NewAddressViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic , copy)UITextField *textMassage;  //姓名文本输入框
@property(nonatomic , copy)UITextField *textMassage1;  //电话文本输入框
@property(nonatomic , copy)UITextField *textMassage2;  //省份文本输入框
@property(nonatomic , copy)UITextField *textMassage3;  //城市文本输入框



@property(nonatomic , copy)NSString *titleStr;       //标题栏标题
@property(nonatomic , copy)NSString *btnTitle;       //点击button的标题

@property(nonatomic , assign)int inde;  //纪录跳转过来的cell的下标

@property(nonatomic , strong)NSMutableDictionary *neDic;   //存放cell的相关数据

//城市选择器
@property(nonatomic , strong)HZAreaPickerView *cityPicker;
@property(nonatomic , strong)NSString *cityValue;    //所在城市

//编辑状态下选择器的初始值
@property(nonatomic , copy)NSString *str1;
@property(nonatomic , copy)NSString *str2;
@property(nonatomic , copy)NSString *str3;

-(void)cancelLocatePicker;


@end
