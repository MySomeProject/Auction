//
//  SuccessViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/30.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "SuccessViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "PayViewController.h"
#import "AddressViewController.h"

@interface SuccessViewController ()<UINavigationBarDelegate>
{
    UIButton *backButton1;
}

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单支付";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTabItemLeftButton];
    [self createView];
}

-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(0, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)createView
{
    UILabel *succeedLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, (300 * RATIOTYPE_HEIGHT - 30)/2 + 64, 100, 30)];
    succeedLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    succeedLabel.textAlignment = NSTextAlignmentCenter;
    succeedLabel.text = @"支付成功";
    succeedLabel.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:succeedLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 300 *RATIOTYPE_HEIGHT + 30, kScreenWidth - 30, 20)];
    label.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请继续确认收货地址";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    backButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton1.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , label.frame.origin.y + 20 + 100 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    backButton1.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [backButton1 setTitle:@"确认收货地址" forState:UIControlStateNormal];
    [backButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    backButton1.tag = 500;
    [backButton1 addTarget:self action:@selector(drawAction2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton1];
    
}

-(void)drawAction2:(UIButton *)button
{
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    
    if (backButton1.tag == button.tag) {
        
        addressVC.titleLabel = @"确认收货地址";
        addressVC.addBtnTitle = @"确认";
        

    }
    [self.navigationController pushViewController:addressVC animated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
}


@end
