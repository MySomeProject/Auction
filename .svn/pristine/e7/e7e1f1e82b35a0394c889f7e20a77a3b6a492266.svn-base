//
//  AuctionRuleViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "AuctionRuleViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
@interface AuctionRuleViewController ()<UIScrollViewDelegate>

@end

@implementation AuctionRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"竞拍规则";
    [self createTabItemLeftButton];
    [self createTextField];
}

-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15,24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

 
-(void)createTextField
{
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    textview.text = @" 1、所有注册用户均可参与竞拍。\n 2、保证金说明：参拍保证金是为保证竞拍活动的公平、有序的进行，竞买人在参拍前交纳的一笔保证款项；拍下商品后需在72小时内支付货款，支付完成后保证金将自动解冻退回到您的保证金账户里，如果72小时内没有支付货款，系统则会关闭交易，保证金将自动扣除；如果你参与竞拍但未竞拍成功，保证金将在竞拍结束后返还到您的账户。\n 3、出价规则：竞拍人每次加价不得低于该商品的加价幅度。\n 4、延时周期：该商品在拍卖结束前3分钟有竞拍人加价，则该商品按照延时周期顺延竞拍时间。拍卖为多人竞拍，不支持无理由退换，请考虑后再出价。\n 6、拍得商品：①竞拍结束后，无底价商品由出价最高者拍得；②竞拍结束后，对于有底价商品，若最高价达到底价，则出价最高者拍得该商品；若最高价未达底价，则此次商品流拍；\n 7、支付成功后，请确认收货地址，拍大牌将尽快为你发货。\n 8、查看订单：您可登陆拍大牌，在“我的拍卖”-“已拍下”中查看竞拍成功商品的状态。\n 9、对于恶意竞拍的用户，拍大牌有权终止其账户的拍卖资格。";
    textview.textColor = [UIColor blueColor];
    textview.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textview];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
