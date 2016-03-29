//
//  CashDetailViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "CashDetailViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "CashSubmitCell.h"
#import "CashDrawCell.h"
#import "CashUseCell.h"
#import "CashDeductCell.h"
#import "AFNetworking.h"
#import "CashDetailModel.h"

@interface CashDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *cashTableView;
    
    UIView *scrollView;
    UIButton *submitButton;
    UIButton *drawButton;
    UIButton *useButton;
    UIButton *deductButton;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    NSMutableArray *_dataArray3;
    
    int sign1;
}

@end

@implementation CashDetailViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
        _dataArray1 = [[NSMutableArray alloc]init];
        _dataArray2 = [[NSMutableArray alloc]init];
        _dataArray3 = [[NSMutableArray alloc]init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保证金明细";
    self.view.backgroundColor = [UIColor whiteColor];
    sign1 = 1;
    
    
    cashTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100 * RATIOTYPE_HEIGHT, kScreenWidth, kScreenHeight - 64)style:UITableViewStylePlain];
    cashTableView.backgroundColor = [UIColor clearColor];
    cashTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cashTableView.scrollEnabled = YES;
    
    cashTableView.dataSource = self;
    cashTableView.delegate = self;
    
    [self.view addSubview:cashTableView];
    
    [self createCashDetailData];

    [self createTabItemLeftButton];
    [self createSegmentView];
    
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

-(void)createSegmentView
{
    scrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    NSArray *nameArr = @[@"提交明细",@"提取明细",@"使用明细",@"扣除明细"];
    
    for (int i = 0; i < nameArr.count; i ++) {
        
        submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.tag = i + 240;
        submitButton.frame = CGRectMake((kScreenWidth - 120 * RATIOTYPE_WIDTH * 4)/4/2 + i * (120 * RATIOTYPE_WIDTH + (kScreenWidth - 120 * RATIOTYPE_WIDTH * 4)/4), 0, 120 * RATIOTYPE_WIDTH, 44);
        [submitButton setTitle:nameArr[i] forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor colorWithWhite:0.326 alpha:1.000] forState:UIControlStateNormal];
        submitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [submitButton.titleLabel setAdjustsFontSizeToFitWidth:YES];

        [submitButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:submitButton];
    }
        
    _selectImg = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 120 * RATIOTYPE_WIDTH * 4)/4/2 , 42 , 120 * RATIOTYPE_WIDTH , 2)];
    _selectImg.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    
    [scrollView addSubview:_selectImg];

}

-(void)selectAction:(UIButton *)button
{
    
    if (button)
    {
        sign1 =(int) button.tag - 239;
    }
    
    //点击按钮后要重新请求数据
    _selectImg.tag = sign1;
    [self createCashDetailData];
    [cashTableView reloadData];
    
    int i = (int)button.tag - 240;
    
    //移动的动画
    [UIView animateWithDuration:.35 animations:^{
        
        [_selectImg setFrame:CGRectMake(i *(120 *RATIOTYPE_WIDTH + (kScreenWidth - 120 * RATIOTYPE_WIDTH * 4)/4) + (kScreenWidth - 120 * RATIOTYPE_WIDTH * 4)/4/2, 42, 120 * RATIOTYPE_WIDTH, 2)];
    }];
}

#pragma mark --- 请求数据
-(void)createCashDetailData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"client_id":[user objectForKey:@"client_id"]};
    
    if (sign1 == 1) {
        
        NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=rechargeDeposit";
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *auctionArr = (NSDictionary *)responseObject[@"data"];
            
            _dataArray = [[NSMutableArray alloc]initWithCapacity:10];
            
            for (NSDictionary *auctDic in auctionArr) {
                
                CashDetailModel *model = [[CashDetailModel alloc]init];
                model.recharge_price = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"recharge_price"]];
                model.add_time = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"add_time"]];
                model.name = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"name"]];
            
                [_dataArray addObject:model];
            }
            NSLog(@"提交保证金明细%@",auctionArr);
            [cashTableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",operation.error);
        }];
        
    }else if (sign1 == 2)
    {
        _dataArray1 = [[NSMutableArray alloc]initWithCapacity:10];
        
        NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=extractionDeposit";
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dataDict1 =(NSDictionary *)responseObject[@"data"];
            for (NSDictionary *auctDic1 in dataDict1) {
                
                CashDetailModel *model1 = [[CashDetailModel alloc]init];
                model1.extra_price = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"extra_price"]];
                model1.add_time = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"add_time"]];
                model1.brand_cardnumber = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"brand_cardnumber"]];
                
                [_dataArray1 addObject:model1];
            }
            NSLog(@"提取保证金明细%@",dataDict1);
            
            [cashTableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",operation.error);
        }];
        
        
    }else if(sign1 == 3)
    {
        _dataArray2 = [[NSMutableArray alloc]initWithCapacity:10];
        
        NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=useDeposit";
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dataDict2 =(NSDictionary *)responseObject[@"data"];
            for (NSDictionary *dic2 in dataDict2) {
                
                CashDetailModel *model2 = [[CashDetailModel alloc]init];
                
                model2.img = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"img"]];
                model2.name = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"name"]];
                model2.deposit = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"deposit"]];
                model2.frozen_start = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"frozen_start"]];
                model2.frozen_end = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"frozen_end"]];
                model2.deposit_status = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"deposit_status"]];
                
                [_dataArray2 addObject:model2];
                NSLog(@"使用保证金明细%@",dic2);
                [cashTableView reloadData];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",operation.error);
        }];
        
    }else
    {
        _dataArray3 = [[NSMutableArray alloc]initWithCapacity:10];
        
        NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=deductionDeposit";
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dataDict2 =(NSDictionary *)responseObject[@"data"];
            for (NSDictionary *dic2 in dataDict2) {
                
                CashDetailModel *model2 = [[CashDetailModel alloc]init];
                
                model2.img = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"img"]];
                model2.name = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"name"]];
                model2.deposit = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"deposit"]];
                model2.deduction_time = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"deduction_time"]];
                
                [_dataArray3 addObject:model2];
                NSLog(@"扣除保证金明细%@",dic2);
                [cashTableView reloadData];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",operation.error);
        }];
    }

    
}

#pragma mark --- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (sign1 == 3) {
        return 150;
    }else if (sign1 == 4)
    {
        return 295;
    }else
    {
        return 140;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (sign1 == 1) {
        return _dataArray.count;
    }else if (sign1 == 2)
    {
        return _dataArray1.count;
    }else if(sign1 == 3)
    {
        return _dataArray2.count;
    }else
    {
        return _dataArray3.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (sign1 == 1) {
        
        static NSString *cashCell = @"CashSubmitCell";
        CashSubmitCell *submitCell = [tableView dequeueReusableCellWithIdentifier:cashCell];
        if (!submitCell) {
            submitCell = [[[NSBundle mainBundle]loadNibNamed:@"CashSubmitCell" owner:nil options:nil]firstObject];
        }
        
        CashDetailModel *model = [_dataArray objectAtIndex:indexPath.row];
        submitCell.model = model;
        
        return submitCell;
        
    }else if (sign1 == 2)
    {
        static NSString *cashCell = @"CashDrawCell";
        CashDrawCell *drawCell = [tableView dequeueReusableCellWithIdentifier:cashCell];
        if (!drawCell) {
            drawCell = [[[NSBundle mainBundle]loadNibNamed:@"CashDrawCell" owner:nil options:nil]firstObject];
        }
        
        CashDetailModel *model1 = [_dataArray1 objectAtIndex:indexPath.row];
        drawCell.model1 = model1;
        
        return drawCell;
        
    }else if (sign1 == 3)
    {
        static NSString *cashCell = @"CashUseCell";
        CashUseCell *useCell = [tableView dequeueReusableCellWithIdentifier:cashCell];
        if (!useCell) {
            useCell = [[[NSBundle mainBundle]loadNibNamed:@"CashUseCell" owner:nil options:nil]firstObject];
        }
        
        CashDetailModel *model2 = [_dataArray2 objectAtIndex:indexPath.row];
        useCell.model2 = model2;
        
        return useCell;
        
    }else
    {
        static NSString *cashCell = @"CashDeductCell";
        CashDeductCell *deductCell = [tableView dequeueReusableCellWithIdentifier:cashCell];
        if (!deductCell) {
            deductCell = [[[NSBundle mainBundle]loadNibNamed:@"CashDeductCell" owner:nil options:nil]firstObject];
        }
        
        CashDetailModel *model3 = [_dataArray3 objectAtIndex:indexPath.row];
        deductCell.model3 = model3;
        
        return deductCell;
        
    }
}

@end
