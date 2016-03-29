//
//  DetailViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "DetailViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AFNetworking.h"
#import "AuctionModel.h"
#import "PayViewController.h"
#import "AddressViewController.h"

@interface DetailViewController ()
{
    NSMutableArray *_dataArray;
    
    UIScrollView *scrollView;
    
    UILabel *alter;
    UILabel *alter1;
   
}
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DetailViewController
@synthesize detailSign;

-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
        _detailDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
    self.view .backgroundColor = [UIColor whiteColor];
    detailSign = [_detailDic objectForKey:@"order_status"];
    _detailID = [_detailDic objectForKey:@"aid"];
    
    NSLog(@"%@",detailSign);
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.contentSize = CGSizeMake(0, 667);
    [self.view addSubview:scrollView];
    
    
    [self.stateButton addTarget:self action:@selector(ChangeACT:) forControlEvents:UIControlEventTouchUpInside];
    
    [self createDetailViewData];
    [self createView];
    [self sign];
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
#pragma mark --- 创建视图
-(void)createView
{
    _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 20)];
    _timeLab.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    _timeLab.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_timeLab];
    
    _themeImageDv = [[UIImageView alloc]initWithFrame:CGRectMake(15, _timeLab.frame.origin.y + _timeLab.frame.size.height + 30 * RATIOTYPE_HEIGHT, 100, 100)];
    [scrollView addSubview:_themeImageDv];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_themeImageDv.frame.size.width + _themeImageDv.frame.origin.x + 30 *RATIOTYPE_WIDTH, _themeImageDv.frame.origin.y, kScreenWidth - _themeImageDv.frame.size.width - 30 * RATIOTYPE_WIDTH - 30, 75)];
    _titleLab.adjustsFontSizeToFitWidth = YES;
    _titleLab.numberOfLines = 0;
    [scrollView addSubview:_titleLab];
    
    _finishMoney = [[UILabel alloc]initWithFrame:CGRectMake(_titleLab.frame.origin.x, _themeImageDv.frame.origin.y + _themeImageDv.frame.size.height - 25, _titleLab.frame.size.width, 30)];
    _finishMoney.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _finishMoney.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_finishMoney];
    
    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _themeImageDv.frame.size.height + _themeImageDv.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    _stateLabel.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    _stateLabel.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_stateLabel];
    
    _payLab = [[UILabel alloc]initWithFrame:CGRectMake(15, _stateLabel.frame.size.height + _stateLabel.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    _payLab.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    _payLab.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_payLab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, _payLab.frame.size.height + _payLab.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 1)];
    line1.backgroundColor = [AOColorFormat colorWithHexString:@"#808080"];
    [scrollView addSubview:line1];
    
    _orderNum = [[UILabel alloc]initWithFrame:CGRectMake(15, line1.frame.origin.y + 1 + 30 * RATIOTYPE_HEIGHT, kScreenWidth -30, 20)];
    _orderNum.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _orderNum.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_orderNum];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15, _orderNum.frame.size.height + _orderNum.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 1)];
    line2.backgroundColor = [AOColorFormat colorWithHexString:@"#808080"];
    [scrollView addSubview:line2];
    
    UILabel *addr = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.frame.size.height + line2.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    addr.text = @"收货地址";
    addr.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    addr.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:addr];
    
    _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(15, addr.frame.size.height + addr.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 40)];
    _addressLab.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    _addressLab.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_addressLab];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, _addressLab.frame.size.height + _addressLab.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    _nameLab.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    _nameLab.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_nameLab];
    
    _tellLab = [[UILabel alloc]initWithFrame:CGRectMake(15, _nameLab.frame.size.height + _nameLab.frame.origin.y + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30, 20)];
    _tellLab.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    _tellLab.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:_tellLab];
    
    _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _stateButton.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2, _tellLab.frame.size.height + _tellLab.frame.origin.y + 100 *RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    _stateButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [_stateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _stateButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_stateButton addTarget:self action:@selector(ChangeACT:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_stateButton];
    
}

-(void)ChangeACT:(UIButton *)btn
{
    btn = self.stateButton;
    
    if ([detailSign isEqualToString:@"未付款"]) {
        
        PayViewController *payVC = [[PayViewController alloc]init];
        
        [self.navigationController pushViewController:payVC animated:YES];
        
        payVC.hidesBottomBarWhenPushed = YES;
        
 
        
    }
//        else if ([detailSign isEqualToString:@"未确认收货地址"])
//    {
//        AddressViewController *addressVC = [[AddressViewController alloc]init];
//        
//        addressVC.titleLabel = @"确认收货地址";
//        
//        addressVC.addBtnTitle = @"确认";
//        
//        [self.navigationController pushViewController:addressVC animated:YES];
//        
//        self.tabBarController.tabBar.hidden = YES;
//    }
        else if ([detailSign isEqualToString:@"已发货"])
    {
        [self createAddressData];
        
        alter = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 500, 100, 40)];
        alter.backgroundColor = [UIColor blackColor];
        alter.alpha = 0.6;
        alter.text = @"确认收货成功";
        alter.font = [UIFont systemFontOfSize:16];
        alter.textColor = [UIColor whiteColor];
        [alter performSelector:@selector(time1) withObject:self afterDelay:3];
        [self.view addSubview:alter];
        
        [self.navigationController popViewControllerAnimated:YES];
    
    }else
    {
        btn.selected = NO;
    }

}

-(void)time1
{
    if ([detailSign isEqualToString:@"未确认收货地址"]) {

    [alter1 removeFromSuperview];
    }else
    {
    [alter removeFromSuperview];
    }
}


//button状态的改变
-(void)sign
{
    if ([detailSign isEqualToString:@"未付款"]) {
        [self.stateButton setTitle:@"去支付" forState:UIControlStateNormal];
        [self.stateButton setTitleColor:[AOColorFormat colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        self.stateButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
        
        
    }else if ([detailSign isEqualToString:@"未确认收货地址"])
    {
        [self.stateButton setTitle:@"确认收货地址" forState:UIControlStateNormal];
        [self.stateButton setTitleColor:[AOColorFormat colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        self.stateButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
        
    }else
    {
        self.stateButton.hidden = YES;
        
    }
    
}



#pragma mark --- 加载数据

-(void)createDetailViewData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"client_id":[user objectForKey:@"client_id"],@"auctionid":_detailID};
    
    
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getOrderInfo";
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *cashDic = (NSDictionary *)responseObject[@"data"];
        _dataArray = [[NSMutableArray alloc]initWithCapacity:10];
        
        AuctionModel *model1 = [[AuctionModel alloc]init];
        
        //加载model
        model1.generation_time  = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"generation_time"]];
        model1.img = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"img"]];
        model1.name = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"name"]];
        model1.pay_price  = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"pay_price"]];
        model1.order_status = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"order_status"]];
        model1.pay_name = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"pay_name"]];
        model1.order_sn  = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"order_sn"]];
        model1.addr = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"addr"]];
        model1.accept_name = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"accept_name"]];      model1.generation_time  = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"generation_time"]];
        model1.mobile = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"mobile"]];
        model1.waybill_number = [NSString stringWithFormat:@"%@",[cashDic objectForKey:@"waybill_number"]];

        //页面加载数据
        self.orderNum.text = [NSString stringWithFormat:@"快递单号：%@", model1.waybill_number];
        self.addressLab.text = [NSString stringWithFormat:@"地       址：%@", model1.addr];
        self.nameLab.text = [NSString stringWithFormat:@"收  货  人：%@", model1.accept_name];
        self.tellLab.text = [NSString stringWithFormat:@"联系电话 ：%@", model1.mobile];
        self.timeLab.text = [NSString stringWithFormat:@"拍下时间：%@",model1.generation_time] ;
        self.titleLab.text = [NSString stringWithFormat:@"%@",model1.name];
        self.finishMoney.text = [NSString stringWithFormat:@"成交金额：%@", model1.pay_price];
        self.stateLabel.text = [NSString stringWithFormat:@"订单状态：%@", model1.order_status];
        self.payLab.text = [NSString stringWithFormat:@"支付方式：%@", model1.pay_name];
        [self.themeImageDv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.212.63/shepai/%@" ,model1.img]]];
        
        [_dataArray addObject:model1];
        
        NSLog(@"数据加载成功－－－－－－%@",_dataArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据加载失败－－－－－－%@",operation.error);
    }];
    
}

#pragma mark --- 确认收货地址
-(void)createAddressData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AuctionModel *model2 = [_dataArray objectAtIndex:_index];
    
    NSString *orderID = model2.order_sn;
    
    NSDictionary *parameter = @{@"client_id":[user objectForKey:@"client_id"],@"orderid":orderID};
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=orderConfirmation";
    
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"数据返回成功＊＊＊%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据返回失败＊＊＊%@",operation.error);
    }];
}





@end
