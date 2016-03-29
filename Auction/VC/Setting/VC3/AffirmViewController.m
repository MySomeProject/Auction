//
//  AffirmViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/13.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "AffirmViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "SettingViewController.h"
#import "AFNetworking.h"
#import "AffirmModel.h"
#import "DrawCashViewController.h"

@interface AffirmViewController ()
{
    UIView *bgView;
    UIButton *alterBtn;
    NSMutableArray *_dataArray;
}

@end

@implementation AffirmViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray =[[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"确认退款账户";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTabItemLeftButton];
    
    [self createViewAffirm];
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

-(void)createViewAffirm
{
    NSArray *titleArr = @[@"开户人姓名",@"银  行 卡 号",@"开    户   行",@"开户所在地"];
    for (int i = 0; i < titleArr.count; i ++)
    {
    
    UITextField  *text = [[UITextField alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH,64 + 30 * RATIOTYPE_HEIGHT + 20 * i + 30 *RATIOTYPE_HEIGHT * i, 80, 20)];
    text.text = titleArr[i];
    text.textAlignment = NSTextAlignmentJustified;
    text.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    text.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:text];
    }
    
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH + 80 + 20, 64 + 30 * RATIOTYPE_HEIGHT,kScreenWidth - 30 * RATIOTYPE_WIDTH * 2 - 80 - 20 , 20)];
        _nameLab.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        _nameLab.textAlignment = NSTextAlignmentRight;
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.text = _nameString;
        [self.view addSubview:_nameLab];
        
        _cardNum = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH + 80 + 20, _nameLab.frame.origin.y + _nameLab.frame.size.height + 30 * RATIOTYPE_HEIGHT,kScreenWidth - 30 * RATIOTYPE_WIDTH * 2 - 80 - 20 , 20)];
        _cardNum.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        _cardNum.textAlignment = NSTextAlignmentRight;
        _cardNum.font = [UIFont systemFontOfSize:14];
        _cardNum.text = _cardNumString;
        [self.view addSubview:_cardNum];
        
        _openingBankLab = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH + 80 + 20, _cardNum.frame.origin.y + _cardNum.frame.size.height + 30 * RATIOTYPE_HEIGHT,kScreenWidth - 30 * RATIOTYPE_WIDTH * 2 - 80 - 20 , 20)];
        _openingBankLab.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        _openingBankLab.textAlignment = NSTextAlignmentRight;
        _openingBankLab.font = [UIFont systemFontOfSize:14];
        _openingBankLab.text =_openingBankString;
        [self.view addSubview:_openingBankLab];
    
    //kScreenWidth - 30 * RATIOTYPE_WIDTH * 2 - 80 - 20
        _locationLab = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH + 80 + 20, _openingBankLab.frame.origin.y + _openingBankLab.frame.size.height + 30 * RATIOTYPE_HEIGHT, 200*RATIOTYPE_WIDTH, 20)];
//        _locationLab.backgroundColor = [UIColor redColor];
        _locationLab.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        _locationLab.textAlignment = NSTextAlignmentRight;
        _locationLab.font = [UIFont systemFontOfSize:14];
        _locationLab.text = _locationString;
        [self.view addSubview:_locationLab];
    
    _stateLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_locationLab.frame), _openingBankLab.frame.origin.y + _openingBankLab.frame.size.height + 30 * RATIOTYPE_HEIGHT, 290*RATIOTYPE_WIDTH, 20)];
//    _stateLab.backgroundColor = [UIColor blueColor];
    _stateLab.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _stateLab.textAlignment = NSTextAlignmentRight;
    _stateLab.font = [UIFont systemFontOfSize:14];
    _stateLab.text = _stateString;
    [self.view addSubview:_stateLab];

    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(30 * RATIOTYPE_WIDTH, _locationLab.frame.origin.y + _locationLab.frame.size.height + 100 * RATIOTYPE_HEIGHT, kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 100 *RATIOTYPE_HEIGHT);
    nextButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [nextButton setTitle:_btnTitle forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextButton addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, nextButton.frame.size.height + nextButton.frame.origin.y , kScreenWidth - 2 * 30 * RATIOTYPE_WIDTH, 40)];
    label.text = @"请确认退款账户，如有问题可咨询客服电话：10098982398";
    label.textColor = [AOColorFormat colorWithHexString: @"#808080"];
    label.font = [UIFont systemFontOfSize:13];

    //自动换行
//    label.lineBreakMode =UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    
    [self.view addSubview:label];
 
}

-(void)drawAction:(UIButton *)button
{
    if ([_btnTitle isEqualToString:@"下一步"]) {
        
        DrawCashViewController *drawVC = [[DrawCashViewController alloc]init];
        drawVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:drawVC animated:YES];
        
    }else
    {
    [self createAffirmViewData];
    }
}

-(void)createAffirmViewData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=addAccount";
    NSDictionary *parameters = @{@"holder":_nameLab.text,@"cardnumber":_cardNum.text,@"cardname":_openingBankLab.text,@"provinces":_locationLab.text,@"city":_stateLab.text,@"client_id":[user objectForKey:@"client_id"]};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.5;
        [self.view addSubview:bgView];
        
        alterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        alterBtn.frame = CGRectMake((kScreenWidth - 500 *RATIOTYPE_WIDTH)/2,(kScreenHeight - 64)/2, 500 * RATIOTYPE_WIDTH, 200 * RATIOTYPE_HEIGHT) ;
        alterBtn.backgroundColor = [UIColor whiteColor];
        alterBtn.alpha = 1;
        [alterBtn addTarget:self action:@selector(alterAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:alterBtn];
        
        UILabel *alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, (200 * RATIOTYPE_HEIGHT - 20)/2, 500 * RATIOTYPE_WIDTH-30 - 20, 20)];
        alterLabel.text = @"您的退款账户设置完成！";
        alterLabel.textAlignment = NSTextAlignmentCenter;
        alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        alterLabel.font = [UIFont systemFontOfSize:14];
        [alterBtn addSubview:alterLabel];
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


-(void)alterAction:(UIButton *)button
{

    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
