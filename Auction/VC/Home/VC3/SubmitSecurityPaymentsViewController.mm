//
//  SubmitSecurityPaymentsViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/2.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "SubmitSecurityPaymentsViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "RTLabel.h"
#import "UserProtolViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AFNetworking.h"
#import "Single.h"
#import "AppDelegate.h"
#import "UPPayPlugin.h"

@interface SubmitSecurityPaymentsViewController ()<UIScrollViewDelegate,RTLabelDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_dataArray;
    
    int typeZF; // 0:微信支付 1:支付宝支付 2:银联支付
    UIAlertView *_alertView;
    
}
@end

@implementation SubmitSecurityPaymentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    typeZF = 0;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"提交保证金";
    [self createTabItemLeftButton];
    [self createScrollView];
    [self createHeaderView];
    
    
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
-(void)createScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    //    _scrollView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(0, kScreenHeight*1);
    
}
-(void)createHeaderView
{
    
    UILabel *titleLabel = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth/2-150*RATIOTYPE_WIDTH,80*RATIOTYPE_HEIGHT,300*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT) Font:18 Text:@"您将提交保证金"];
    titleLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [_scrollView addSubview:titleLabel];
    
    UILabel *priceLabel = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth/2-100*RATIOTYPE_WIDTH,CGRectGetMaxY(titleLabel.frame),200*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT) Font:25 Text:[NSString stringWithFormat:@"¥%@",_despositStr]];
    priceLabel.textColor = [AOColorFormat colorWithHexString:@"ff0000"];
    [_scrollView addSubview:priceLabel];
    UILabel *modelofpaymentLabel = [ZYControl createLabelWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,240*RATIOTYPE_HEIGHT,400*RATIOTYPE_WIDTH, 60*RATIOTYPE_HEIGHT) Font:18 Text:@"选择支付方式去支付:"];
    modelofpaymentLabel.textColor = [AOColorFormat colorWithHexString:@"666666"];
    [_scrollView addSubview:modelofpaymentLabel];
    
    
    //微信支付
    UIImageView *weiImageView = [ZYControl createImageViewWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, CGRectGetMaxY(modelofpaymentLabel.frame)+40*RATIOTYPE_HEIGHT, 58*RATIOTYPE_WIDTH, 58*RATIOTYPE_HEIGHT) ImageName:@"微信@2x"];
    [_scrollView addSubview:weiImageView];
    UILabel *microLetterPaymentLabel = [ZYControl createLabelWithFrame:CGRectMake(80*RATIOTYPE_WIDTH,CGRectGetMaxY(modelofpaymentLabel.frame)+50*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:18 Text:@"微信支付"];
    microLetterPaymentLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [_scrollView addSubview:microLetterPaymentLabel];
    
    //设置button
    
    UIButton *selectButton =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-87*RATIOTYPE_WIDTH, CGRectGetMaxY(modelofpaymentLabel.frame)+50*RATIOTYPE_HEIGHT,37*RATIOTYPE_WIDTH,37*RATIOTYPE_HEIGHT)];
    selectButton.tag = 120;
    [selectButton setBackgroundImage:[UIImage imageNamed:@"未选中状态@2x.png"]forState:UIControlStateNormal];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"选择状态按钮@2x.png"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:selectButton];
    
    UIButton *selectButton1 =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-87*RATIOTYPE_WIDTH, CGRectGetMaxY(modelofpaymentLabel.frame)+50*RATIOTYPE_HEIGHT,37*RATIOTYPE_WIDTH,37*RATIOTYPE_HEIGHT)];
    selectButton1.tag = 100;
    [selectButton1 setBackgroundImage:[UIImage imageNamed:@"未选中状态@2x.png"]forState:UIControlStateNormal];
    [selectButton1 setBackgroundImage:[UIImage imageNamed:@"选择状态按钮@2x.png"] forState:UIControlStateSelected];
    [selectButton1 addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:selectButton1];
    
    
    UIView *boundaryView = [[UIView alloc]initWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,CGRectGetMaxY(microLetterPaymentLabel.frame)+30*RATIOTYPE_HEIGHT, kScreenWidth-20*RATIOTYPE_WIDTH, 1*RATIOTYPE_HEIGHT)];
    boundaryView.backgroundColor = [UIColor grayColor];
    boundaryView.alpha = 0.3;
    [_scrollView addSubview:boundaryView];
    
    //银联支付
    UIImageView *yinImageView = [ZYControl createImageViewWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, CGRectGetMaxY(boundaryView.frame)+20*RATIOTYPE_HEIGHT, 58*RATIOTYPE_WIDTH, 58*RATIOTYPE_HEIGHT) ImageName:@"银联@2x"];
    [_scrollView addSubview:yinImageView];
    UILabel *unionPaymentLabel = [ZYControl createLabelWithFrame:CGRectMake(80*RATIOTYPE_WIDTH,CGRectGetMaxY(boundaryView.frame)+30*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:18 Text:@"银联支付"];
    unionPaymentLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [_scrollView addSubview:unionPaymentLabel];
    
    UIView *boundaryView1 = [[UIView alloc]initWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,CGRectGetMaxY(unionPaymentLabel.frame)+30*RATIOTYPE_HEIGHT, kScreenWidth-20*RATIOTYPE_WIDTH, 1*RATIOTYPE_HEIGHT)];
    boundaryView1.backgroundColor = [UIColor grayColor];
    boundaryView1.alpha = 0.3;
    [_scrollView addSubview:boundaryView1];
    
    UIButton *selectButton2 =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-87*RATIOTYPE_WIDTH,CGRectGetMaxY(boundaryView.frame)+30*RATIOTYPE_HEIGHT, 37*RATIOTYPE_WIDTH, 37*RATIOTYPE_HEIGHT)];
    selectButton2.tag = 200;
    [selectButton2 setBackgroundImage:[UIImage imageNamed:@"未选中状态@2x.png"]forState:UIControlStateNormal];
    [selectButton2 setBackgroundImage:[UIImage imageNamed:@"选择状态按钮@2x.png"] forState:UIControlStateSelected];
    [selectButton2 addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:selectButton2];
    
    //支付宝
    UIImageView *alipayImageView = [ZYControl createImageViewWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, CGRectGetMaxY(boundaryView1.frame)+20*RATIOTYPE_HEIGHT, 58*RATIOTYPE_WIDTH, 58*RATIOTYPE_HEIGHT) ImageName:@"支付宝@2x"];
    [_scrollView addSubview:alipayImageView];
    
    UILabel *alipayLabel = [ZYControl createLabelWithFrame:CGRectMake(80*RATIOTYPE_WIDTH, CGRectGetMaxY(boundaryView1.frame)+30*RATIOTYPE_HEIGHT, 200*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:18 Text:@"支付宝"];
    alipayLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [_scrollView addSubview:alipayLabel];
    
    UIView *boundaryView2 = [[UIView alloc]initWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,CGRectGetMaxY(alipayLabel.frame)+30*RATIOTYPE_HEIGHT, kScreenWidth-20*RATIOTYPE_WIDTH, 1*RATIOTYPE_HEIGHT)];
    boundaryView2.backgroundColor = [UIColor grayColor];
    boundaryView2.alpha = 0.3;
    [_scrollView addSubview:boundaryView2];
    
    //设置支付宝button
    UIButton *selectButton3 =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-87*RATIOTYPE_WIDTH, CGRectGetMaxY(boundaryView1.frame)+30*RATIOTYPE_HEIGHT,37*RATIOTYPE_WIDTH, 37*RATIOTYPE_HEIGHT)];
    selectButton3.tag = 300;
    [selectButton3 setBackgroundImage:[UIImage imageNamed:@"未选中状态@2x.png"]forState:UIControlStateNormal];
    [selectButton3 setBackgroundImage:[UIImage imageNamed:@"选择状态按钮@2x.png"] forState:UIControlStateSelected];
    [selectButton3 addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:selectButton3];
    
    //创建竞拍需同意协议
    UILabel *protocolLabel = [ZYControl createLabelWithFrame:CGRectMake(140*RATIOTYPE_WIDTH,CGRectGetMaxY(boundaryView2.frame)+85*RATIOTYPE_HEIGHT,300*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT) Font:16 Text:@"竞拍需同意用户协议"];
    protocolLabel.textColor = [AOColorFormat colorWithHexString:@"666666"];
    [_scrollView  addSubview:protocolLabel];
    
    //查看用户协议
    RTLabel *rlabel = [[RTLabel alloc]init];
    rlabel.delegate = self;
    NSString *str = @"<a href='http://..'><font color='#0000ff' size=16 >查看用户协议</font></a>";
    [rlabel setText:str];
    rlabel.frame = CGRectMake(CGRectGetMaxX(protocolLabel.frame)+20*RATIOTYPE_WIDTH, CGRectGetMaxY(boundaryView2.frame)+100*RATIOTYPE_HEIGHT, 240*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT);
    [_scrollView addSubview:rlabel];
    
    
    //创建同意支付按钮
    UIButton *agreePaymentButton = [ZYControl createButtonWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,CGRectGetMaxY(boundaryView2.frame)+230*RATIOTYPE_HEIGHT, kScreenWidth-20*RATIOTYPE_WIDTH,100*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:nil Title:@"同意并去支付"];
    [agreePaymentButton addTarget:self action:@selector(agreePaymentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    agreePaymentButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    [_scrollView addSubview:agreePaymentButton];
    
}
-(void)selectButtonClick:(UIButton *)selectButton
{
    
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:200];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:300];
    
    if (selectButton.tag == btn1.tag) {
         typeZF = 1;
        if (btn1.selected == YES) {
            btn1.selected = NO;
            
            if (btn2.selected == YES) {
                btn2.selected = NO;
                
            }
            if (btn3.selected == YES) {
                btn3.selected = NO;
            }
        }
        else if (btn1.selected == NO){
            btn1.selected = YES;
            
            if (btn2.selected == YES) {
                btn2.selected = NO;
                
            }
            if (btn3.selected == YES) {
                btn3.selected = NO;
            }
        }
    }
    else if (selectButton.tag == btn2.tag){
        typeZF = 2;
        if (btn2.selected == YES) {
            btn2.selected = NO;
            
            if (btn1.selected == YES) {
                btn1.selected = NO;
                
            }
            if (btn3.selected == YES) {
                btn3.selected = NO;
            }
        }
        else if (btn2.selected == NO){
            btn2.selected = YES;
            
            if (btn1.selected == YES) {
                btn1.selected = NO;
                
            }
            if (btn3.selected == YES) {
                btn3.selected = NO;
            }
        }
    }else if (selectButton.tag == btn3.tag){
        typeZF = 3;
        if (btn3.selected == YES) {
            btn3.selected = NO;
            if (btn1.selected == YES) {
                btn1.selected = NO;
            }
            if (btn2.selected == YES) {
                btn2.selected = NO;
            }
        }else if (btn3.selected == NO){
            btn3.selected = YES;
            if (btn1.selected == YES) {
                btn1.selected = NO;
            }
            if (btn2.selected == YES) {
                btn2.selected = NO;
            }
            
        }
        
    }
    
}

-(void)checkUserProtocolButtonClick:(UIButton *)checkUserProtocolButton
{
    
    
    
}

#pragma mark   ==============产生随机订单号==============
- (NSString *)generateTradeNO
{
    static int kNumber = 17;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

//同意支付
-(void)agreePaymentButtonClick:(UIButton *)agreePaymentButton
{
    
    if (typeZF == 1) {
        
    }else if (typeZF == 2){
        [self UPPayPlugin];
    
    }else if (typeZF == 3){
        [self Alipay];
    
    }
    
    
}

/// 支付宝支付
- (void)Alipay
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=myPay";
    NSDictionary *parameters = @{@"goods_name":_goods_nameStr,@"goods_price":_goods_priceStr,@"order_sn":[self generateTradeNO],@"user_id":[user objectForKey:@"client_id"],@"auction_id":_auction_ID,@"deposit":_despositStr};
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        _alipayStr = [dict objectForKey:@"alipay_url"];
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"alipayDemo";
        [[AlipaySDK defaultService] payOrder:_alipayStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)UPPayPlugin
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=upopPay";
    NSDictionary *parameters = @{@"goods_name":_goods_nameStr,@"goods_price":_goods_priceStr,@"order_sn":[self generateTradeNO]};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dict = responseObject[@"data"];
        _tnNum =(NSString *)[dict objectForKey:@"tn"];
        NSLog(@"%@",_tnNum);
        _tnMode = kMode_Development;
        NSLog(@"%@",_tnMode);
        [UPPayPlugin startPay:_tnNum mode:_tnMode viewController:self delegate:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)showAlertMessage:(NSString*)msg
{
    
    _alertView = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:self cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [_alertView show];
  
}

#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:kResult, result];
    [self showAlertMessage:msg];
}



#pragma mark - RLabelDelegate
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    UserProtolViewController *upvc= [[UserProtolViewController alloc]init];
    [self.navigationController pushViewController:upvc animated:NO];
    NSLog(@"hahaha");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end