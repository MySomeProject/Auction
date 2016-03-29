//
//  BankViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/8/7.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "BankViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AddressViewController.h"

@interface BankViewController ()

@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"银行转账／汇款";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    [self createTabItemLeftButton];
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 64 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    label.text = @"注意事项：汇款时需要注意以下信息，请牢记！";
    label.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, label.frame.origin.y + 20 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    label1.text = @"1.汇款账户";
    label1.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label1.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, label1.frame.origin.y + 20 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    label2.text = @"户  名：成都奢集科技有限公司";
    label2.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label2.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, label2.frame.origin.y + 20 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    label3.text = @"账  户：5100 1416 1850 5250 8586";
    label3.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label3.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, label3.frame.origin.y + 20 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    label4.text = @"开户行：建行成都益州支行";
    label4.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label4.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(15, label4.frame.origin.y + 20 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    label5.text = @"2.汇款识别码请填写您的订单号";
    label5.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label5.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label5];
    
    _orderNum = [[UILabel alloc]initWithFrame:CGRectMake(15, label5.frame.origin.y + 20 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    _orderNum.text = @"订单号：9756091270";
    _orderNum.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _orderNum.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_orderNum];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(15, _orderNum.frame.origin.y + 20 + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    label6.text = @"3.可到“已拍下”页面中查询订单详情";
    label6.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label6.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(15, label6.frame.origin.y + 20 + 2 * 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 50)];
    label7.text = @"请在竞拍结束后的72小时内付款，否则系统将扣除您的竞拍保证金。";
    label7.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label7.font = [UIFont systemFontOfSize:15];
    label7.numberOfLines = 0;
    [self.view addSubview:label7];
    
    
    UIButton *writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    writeBtn.frame = CGRectMake(15, kScreenHeight - 15 - 100 *RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    writeBtn.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [writeBtn setTitle:@"填写收货地址" forState:UIControlStateNormal];
    [writeBtn setTitleColor:[AOColorFormat colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    writeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [writeBtn addTarget:self action:@selector(writeAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:writeBtn];
}

-(void)writeAct:(UIButton *)sender
{
    AddressViewController *address = [[AddressViewController alloc]init];
    address.hidesBottomBarWhenPushed = YES;
    address.titleLabel = @"选择收货地址";
    address.addBtnTitle = @"确认";
    [self.navigationController pushViewController:address animated:YES];
}



@end
