//
//  AuctionPatViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/3.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "AuctionPatViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
@interface AuctionPatViewController ()

@end

@implementation AuctionPatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"竞拍";
    [self createTabItemLeftButton];
    [self createTitleLabel];
    [self createQuickButton];
    [self createPaymentLabel];
    [self createSayPamentButton];
    [self createNotification];
}
-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)createTitleLabel
{
    UILabel *titleLabel = [ZYControl createLabelWithFrame:CGRectMake(80/375.0*kScreenWidth, 45/667.0*kScreenHeight+44, 200/375.0*kScreenWidth, 20/667.0*kScreenHeight) Font:14 Text:@"快速竞价将按照加价幅度竞拍"];
    titleLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [self.view addSubview:titleLabel];
}
-(void)createQuickButton
{
    UIButton *quickButton = [ZYControl createButtonWithFrame:CGRectMake(30/375.0*kScreenWidth, 130/667.0*kScreenHeight+44, kScreenWidth-60, 40/667.0*kScreenHeight) ImageName:nil Target:self Action:@selector(quickButtonClick:) Title:@"快速竞价"];
    quickButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    [self.view addSubview:quickButton];

}
-(void)quickButtonClick:(UIButton *)quickButton
{
  

}
//创建报价竞拍label
-(void)createPaymentLabel
{
    UILabel *paymentLabel = [ZYControl createLabelWithFrame:CGRectMake(30/375.0*kScreenWidth, 130/667.0*kScreenHeight+44+100/667.0*kScreenHeight, 100/375.0*kScreenWidth, 20/667.0*kScreenHeight) Font:14 Text:@"报价竞拍"];
    paymentLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [self.view addSubview:paymentLabel];
    UIView *boundaryView = [[UIView alloc]initWithFrame:CGRectMake(109/375.0*kScreenWidth, 130/667.0*kScreenHeight+44+120/667.0*kScreenHeight,235/375.0*kScreenWidth, 0.5/375.0*kScreenHeight)];
    boundaryView.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    [self.view addSubview:boundaryView];
    UITextField *playTextField = [ZYControl createTextFieldWithFrame:CGRectMake(110/375.0*kScreenWidth, 130/667.0*kScreenHeight+44+100/667.0*kScreenHeight,235/375.0*kScreenWidth, 20/667.0*kScreenHeight) placeholder:@"请输入报价" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    playTextField.textColor= [AOColorFormat colorWithHexString:@"d9d9d9"];
    [self.view addSubview:playTextField];

}
//报价竞拍button
-(void)createSayPamentButton
{
    UIButton *sayPamentButton = [ZYControl createButtonWithFrame:CGRectMake(30/375.0*kScreenWidth, 130/667.0*kScreenHeight+44+170/667.0*kScreenHeight, kScreenWidth-60, 40/667.0*kScreenHeight) ImageName:nil Target:self Action:@selector(sayPamentButtonClick:) Title:@"报价竞拍"];
    sayPamentButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    [self.view addSubview:sayPamentButton];


}
-(void)sayPamentButtonClick:(UIButton *)sayPamentButton
{


}
-(void)createNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyboardShow:(NSNotification*)notification{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=CGRectMake(0, -60, kScreenWidth, kScreenHeight);
    }];
    
}
-(void)keyboardHide:(NSNotification*)notification{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
