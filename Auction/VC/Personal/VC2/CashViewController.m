//
//  CashViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "CashViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "CashDetailViewController.h"
#import "AFNetworking.h"
#import "EditViewController.h"
#import "DrawCashViewController.h"


@interface CashViewController ()
{
    NSMutableArray *_dataArr;
    NSString *state;
    
}

@end

@implementation CashViewController
@synthesize money;
@synthesize money1;
@synthesize money2;
@synthesize label5;

-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"保证金";
    self.view.tag = 10000;
    self.view.backgroundColor = [UIColor whiteColor];

    [self createCashData];
    [self createCashView];

    [self createTabItemLeftButton];
    [self createTabItemRightButton];

}

-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(0, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.tabBar.hidden = NO;

}
-(void)createTabItemRightButton
{
    UIButton *rightButton = [ZYControl createButtonWithFrame:CGRectMake(0, 24,20,20) ImageName:@"保证金明细" Target:self Action:@selector(rightButtonClick:) Title:nil];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
}

-(void)rightButtonClick:(UIButton *)rightButton
{
    CashDetailViewController *cashDetailVC = [[CashDetailViewController alloc]init];
    
    [self.navigationController pushViewController:cashDetailVC animated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark --- 加载数据

-(void)createCashData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"client_id":[user objectForKey:@"client_id"]};
    
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getDepositShow";
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *cashDic = (NSDictionary *)responseObject[@"data"];
        _dataArr = [[NSMutableArray alloc]initWithCapacity:10];
        
        CashDetailModel *model1 = [[CashDetailModel alloc]init];
        
        model1.deposit_account  = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"deposit_account"]];
        model1.deposit_frozen = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"deposit_frozen"]];
        model1.deposit_thaw = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"deposit_thaw"]];
        model1.account_state = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"account_state"]];
        
        
        self.money.text = model1.deposit_account;
        self.money1.text = model1.deposit_frozen;
        self.money2.text = model1.deposit_thaw;
        state = model1.account_state;
        
        [_dataArr addObject:model1];
        
        NSLog(@"数据－－－－－%@",_dataArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",operation.error);
    }];
    
}

#pragma mark - 保证金界面的实现
-(void)createCashView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 572 * RATIOTYPE_HEIGHT)];
    view.backgroundColor = [AOColorFormat colorWithHexString:@"#f9f9f9"];
    [self.view addSubview:view];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 30 * RATIOTYPE_HEIGHT, 200, 20)];
    label1.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"您账户中的保证金总额为";
    label1.font = [UIFont systemFontOfSize:14];
    [view addSubview:label1];
    
    money = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, label1.frame.origin.y + 20 + 90*RATIOTYPE_HEIGHT, 200, 50)];
    money.textColor = [AOColorFormat colorWithHexString:@"#ff0000"];
    money.textAlignment = NSTextAlignmentCenter;
    money.text = @"￥100.00";
    money.font = [UIFont systemFontOfSize:33];
    [view addSubview:money];
    
    //    label5 = [[UILabel alloc]initWithFrame:CGRectMake(15, money.frame.origin.y + 50 + 110 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    //    label5.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    //    label5.textAlignment = NSTextAlignmentLeft;
    //    label5.text = @"提交时间：2015_6_12 10:00:00";
    //    label5.font = [UIFont systemFontOfSize:14];
    //    [view addSubview:label5];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, money.frame.origin.y + 50 + 110 *RATIOTYPE_HEIGHT, 113, 20)];
    label3.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.text = @"已冻结的保证金：";
    label3.font = [UIFont systemFontOfSize:14];
    [view addSubview:label3];
    
    money1 = [[UILabel alloc]initWithFrame:CGRectMake(124, money.frame.origin.y + 50 + 110 *RATIOTYPE_HEIGHT, 80, 20)];
    money1.textColor = [AOColorFormat colorWithHexString:@"#1a1a1a"];
    money1.textAlignment = NSTextAlignmentLeft;
    money1.text = @"￥10.00";
    money1.font = [UIFont systemFontOfSize:20];
    [view addSubview:money1];
    
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, label3.frame.origin.y + 20 + 50 *RATIOTYPE_HEIGHT, 113, 20)];
    label4.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.text = @"可支配的保证金：";
    label4.font = [UIFont systemFontOfSize:14];
    [view addSubview:label4];
    
    money2 = [[UILabel alloc]initWithFrame:CGRectMake(124, label3.frame.origin.y + 20 + 50 *RATIOTYPE_HEIGHT, 80, 20)];
    money2.textColor = [AOColorFormat colorWithHexString:@"#1a1a1a"];
    money2.textAlignment = NSTextAlignmentLeft;
    money2.text = @"￥90.00";
    money2.font = [UIFont systemFontOfSize:20];
    [view addSubview:money2];
    
    UIButton *drawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    drawButton.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , view.frame.origin.y  + 672 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    drawButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [drawButton setTitle:@"提取保证金" forState:UIControlStateNormal];
    [drawButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    drawButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [drawButton addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:drawButton];
    
    //    UIButton *drawButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    drawButton1.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , drawButton.frame.origin.y +  + 130 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    //    drawButton1.backgroundColor = [AOColorFormat colorWithHexString:@"#ff9046"];
    //    [drawButton1 setTitle:@"充值" forState:UIControlStateNormal];
    //    [drawButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    drawButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    //    [drawButton1 addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
    //    
    //    [self.view addSubview:drawButton1];
}

-(void)drawAction:(UIButton *)button
{
    if ([state isEqualToString:@"1"]) {
        
        DrawCashViewController *drawVC = [[DrawCashViewController alloc]init];
        drawVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:drawVC animated:YES];
        
    }else
    {
        EditViewController *editVC = [[EditViewController alloc]init];
        
        editVC.sign = self.view.tag;
        
        self.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:editVC animated:YES];
    }

}


@end