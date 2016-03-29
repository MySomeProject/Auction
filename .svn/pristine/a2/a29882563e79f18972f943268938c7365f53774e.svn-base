//
//  FreezeSecurityDepositViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/9.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "FreezeSecurityDepositViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "RTLabel.h"
@interface FreezeSecurityDepositViewController ()<RTLabelDelegate>

@end

@implementation FreezeSecurityDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交保证金";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTabItemLeftButton];
    [self createTitleLabel];
    [self createPriceLabel];
    [self createButton];
    [self createLabelAndButton];
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

-(void)createTitleLabel
{
    UILabel *titleLabel = [ZYControl createLabelWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, 30*RATIOTYPE_HEIGHT+64, 220*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:14 Text:@"冻结保证金 ："];
    titleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:titleLabel];
}
-(void)createPriceLabel
{
    UILabel *symbolLabel = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth/2-100*RATIOTYPE_WIDTH, 155*RATIOTYPE_HEIGHT+64, 80*RATIOTYPE_WIDTH, 60*RATIOTYPE_HEIGHT) Font:18 Text:@"¥"];
    symbolLabel.textColor = [AOColorFormat colorWithHexString:@"c70065"];
    [self.view addSubview:symbolLabel];
    
    UILabel *priceLabel = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(symbolLabel.frame)-40*RATIOTYPE_WIDTH, 150*RATIOTYPE_HEIGHT+64, 200*RATIOTYPE_WIDTH, 65*RATIOTYPE_HEIGHT) Font:30 Text:@"90.00"];
    priceLabel.textColor = [AOColorFormat colorWithHexString:@"c70065"];
    [self.view addSubview:priceLabel];

}

//同意并参与竞拍
-(void)createButton
{

    UIButton *agreeButton = [ZYControl createButtonWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, 360*RATIOTYPE_HEIGHT+64, kScreenWidth-60*RATIOTYPE_WIDTH, 80*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:@selector(agreeButtonClick:) Title:@"同意并参与竞拍"];
    [agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    agreeButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    [self.view addSubview:agreeButton];


}

-(void)agreeButtonClick:(UIButton *)agreeButton
{




}

-(void)createLabelAndButton
{
    UILabel *protocolLabel = [ZYControl createLabelWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, 460*RATIOTYPE_HEIGHT+64, 220*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:12 Text:@"竞拍需同意用户协议"];
    protocolLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [self.view addSubview:protocolLabel];
    //查看用户协议
    RTLabel *rlabel = [[RTLabel alloc]init];
    rlabel.delegate = self;
    NSString *str = @"<a href='http://..'><font color='#0000ff' size=16 >查看用户协议</font></a>";
    [rlabel setText:str];
    rlabel.frame = CGRectMake(CGRectGetMaxX(protocolLabel.frame)+20*RATIOTYPE_WIDTH, 460*RATIOTYPE_HEIGHT+64, 200*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT);
    [self.view addSubview:rlabel];

}

#pragma mark - RLabelDelegate
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"hhhhhh");
    
}

-(void)protocolButtonClick:(UIButton *)protocolButton
{


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
