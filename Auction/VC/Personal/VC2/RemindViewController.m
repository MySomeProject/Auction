//
//  RemindViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/27.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "RemindViewController.h"
#import "RemindTableViewCell.h"
#import "RemindSpecialTableViewCell.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "RemindModel.h"
#import "AFNetworking.h"

@interface RemindViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *reTableview;
    UIImageView *selectImage;
    int sign2;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    NSMutableArray *_dataArray3;
}

@end

@implementation RemindViewController

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
    
    self.title = [NSString stringWithFormat:@"%@",_titleStr];
    self.view.backgroundColor = [UIColor whiteColor];
    sign2 = 1;
    
    
    reTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight - 64)style:UITableViewStylePlain];
    reTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    reTableview.dataSource = self;
    reTableview.delegate = self;
    
    reTableview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:reTableview];
    [self createRemindData];
    [self createSegmentcontrol];
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
    
    self.tabBarController.tabBar.hidden = NO;

}
#pragma mark --- 加载数据
-(void)createRemindData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"client_id":[user objectForKey:@"client_id"]};
    
    if ([self.title isEqualToString:@"拍品提醒"]) {
        
        if (sign2 == 1) {
            
            NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=startReminderAuction";
            [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *auctionArr = (NSDictionary *)responseObject[@"data"];
                _dataArray = [[NSMutableArray alloc]initWithCapacity:10];
                
                for (NSDictionary *auctDic in auctionArr) {
                    
                    RemindModel *model = [[RemindModel alloc]init];
                    model.img = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"img"]];
                    model.start_time = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"start_time"]];
                    model.name = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"name"]];
                    model.price = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"price"]];
                    model.visit = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"visit"]];
                    
                    [_dataArray addObject:model];
                }
                NSLog(@"拍卖中%@",auctionArr);
                [reTableview reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",operation.error);
            }];
            
        }else
        {
            _dataArray1 = [[NSMutableArray alloc]initWithCapacity:10];
            
            NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=endReminderAuction";
            [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dataDict1 =(NSDictionary *)responseObject[@"data"];
                for (NSDictionary *auctDic1 in dataDict1) {
                    
                    RemindModel *model1 = [[RemindModel alloc]init];
                    model1.img = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"img"]];
                    model1.end_time = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"end_time"]];
                    model1.name = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"name"]];
                    model1.times = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"times"]];
                    model1.price = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"price"]];
                    
                    [_dataArray1 addObject:model1];
                }
                NSLog(@"拍卖中%@",dataDict1);
                
                [reTableview reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",operation.error);
            }];
            
            
        }
        
    }else
    {
        if (sign2 == 1) {
            
            NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=startReminderSpecial";
            [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *auctionArr = (NSDictionary *)responseObject[@"data"];
                _dataArray2 = [[NSMutableArray alloc]initWithCapacity:10];
                
                for (NSDictionary *auctDic in auctionArr) {
                    
                    RemindModel *model2 = [[RemindModel alloc]init];
                    model2.img = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"img"]];
                    model2.start_time = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"start_time"]];
                    model2.name = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"name"]];
                    model2.deposit = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"deposit"]];
                    model2.auct_count = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"auct_count"]];
                     model2.visit = [NSString stringWithFormat:@"%@",[auctDic objectForKey:@"visit"]];
                    
                    [_dataArray2 addObject:model2];
                }
                NSLog(@"拍卖中%@",auctionArr);
                [reTableview reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",operation.error);
            }];
            
        }else
        {
            _dataArray3 = [[NSMutableArray alloc]initWithCapacity:10];
            
            NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=endReminderSpecial";
            [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dataDict1 =(NSDictionary *)responseObject[@"data"];
                for (NSDictionary *auctDic1 in dataDict1) {
                    
                    RemindModel *model3 = [[RemindModel alloc]init];
                    model3.img = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"img"]];
                    model3.end_time = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"end_time"]];
                    model3.name = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"name"]];
                    model3.auct_count = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"auct_count"]];
                    model3.inst_name = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"inst_name"]];
                    model3.auct_number = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"auct_number"]];
                     model3.auct_peoples = [NSString stringWithFormat:@"%@",[auctDic1 objectForKey:@"auct_peoples"]];
                
                    [_dataArray3 addObject:model3];
                }
                NSLog(@"拍卖中%@",dataDict1);
                
                [reTableview reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",operation.error);
            }];
            
            
        }
    }

}

#pragma mark - 自定义segmentControl
-(void)createSegmentcontrol
{
    UIView *segmentView = [[UIView alloc]initWithFrame:CGRectMake(15, 64, kScreenWidth - 30, 44)];
    segmentView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:segmentView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.tag = 220;
    leftButton.frame = CGRectMake(0, 0, (kScreenWidth - 30)/2, 44);
    [leftButton setTitle:@"开拍提醒" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithWhite:0.435 alpha:1.000] forState:UIControlStateNormal];
    leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    leftButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [leftButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [segmentView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.tag = 221;
    rightButton.frame = CGRectMake((kScreenWidth - 30)/2, 0, (kScreenWidth - 30)/2, 44);
    [rightButton setTitle:@"结束提醒" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithWhite:0.435 alpha:1.000] forState:UIControlStateNormal];
    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [rightButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [segmentView addSubview:rightButton];
    
    selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,42 , (kScreenWidth - 30)/2, 2)];
    selectImage.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    
    [segmentView addSubview:selectImage];
    
}

-(void)selectAction:(UIButton *)button
{
    int count = 2;
    
    int i = (int)button.tag - 220;
    
    if (button.tag == 220) {
        sign2 = 1;
    }else
    {
        sign2 = 2;
    }
    NSLog(@"%d",sign2);
    [self createRemindData];
    
    [reTableview reloadData];
    
    //移动的动画
    [UIView animateWithDuration:.35 animations:^{
        
        [selectImage setFrame:CGRectMake(i * ((kScreenWidth - 30) / count), 42, (kScreenWidth - 30) / count, 2)];
    }];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if ([self.title isEqualToString:@"拍品提醒"]) {
        static NSString *reCell = @"RemindTableViewCell";
        RemindTableViewCell *remindCell = [tableView dequeueReusableCellWithIdentifier:reCell];
        if (!remindCell) {
            
            remindCell = [[[NSBundle mainBundle]loadNibNamed:@"RemindTableViewCell" owner:nil options:nil]lastObject];
            if (sign2 == 1) {
                remindCell.statesLabel.text = @"开始";
                RemindModel *model = [_dataArray objectAtIndex:indexPath.row];
                remindCell.model1 = model;

            }else
            {
                remindCell.statesLabel.text = @"结束";
                RemindModel *model2 = [_dataArray1 objectAtIndex:indexPath.row];
                remindCell.model1 = model2;

            }
        }
        
        return remindCell;
        
    }else
    {
        static NSString *reCell = @"RemindSpecialTableViewCell";
        RemindSpecialTableViewCell *specialCell = [tableView dequeueReusableCellWithIdentifier:reCell];

        if (!specialCell) {
            
            specialCell = [[[NSBundle mainBundle]loadNibNamed:@"RemindSpecialTableViewCell" owner:nil options:nil]lastObject];
            
            if (sign2 == 1) {
                specialCell.timeStates.text = @"开始时间";
                RemindModel *model2 = [_dataArray2 objectAtIndex:indexPath.row];
                specialCell.model = model2;
            }else
            {
                specialCell.timeStates.text = @"结束时间";
                RemindModel *model3 = [_dataArray3 objectAtIndex:indexPath.row];
                specialCell.model = model3;
            }
        }

        
        return specialCell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.title isEqualToString:@"拍品提醒"]) {
        return 150;
    }else
    {
        return 215;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.title isEqualToString:@"拍品提醒"]) {
        
        if (sign2 == 1) {
            return _dataArray.count;
        }else
        {
            return _dataArray1.count;
        }

    }else
    {
        if (sign2 == 1) {
        return _dataArray2.count;
   
        }else
        {
        return _dataArray3.count;

        }
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
