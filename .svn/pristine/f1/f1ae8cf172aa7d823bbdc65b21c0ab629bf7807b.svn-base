//
//  EndAucitionViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/28.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "EndAucitionViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AFNetworking.h"
#import "EndAuctionModel.h"
@interface EndAucitionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_newTableView;
    NSMutableArray *_dataArray;
}
@end

@implementation EndAucitionViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title = @"拍品列表";
    [self createTableView];
    [self createHeaderView];
    [self createEndAuctionData];
}

-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(0, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}
-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth,250*RATIOTYPE_HEIGHT)];
    //    headerView.backgroundColor = [UIColor redColor];
    //已结束拍品
    UILabel * titleLable = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth/2-100*RATIOTYPE_WIDTH,34*RATIOTYPE_HEIGHT,250*RATIOTYPE_WIDTH,30*RATIOTYPE_HEIGHT) Font:16 Text:@"已结束拍品"];
    titleLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [headerView addSubview:titleLable];
    
    //创建共20件拍品lable
    UILabel *numberLable =[ZYControl createLabelWithFrame:CGRectMake(30*RATIOTYPE_WIDTH,200*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:14 Text:@"共20件拍品"];
    numberLable.textColor = [AOColorFormat colorWithHexString:@"666666"];
    [headerView addSubview:numberLable];

    //创建分界线
    UIView *boundaryView = [[UIView alloc]initWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, 250*RATIOTYPE_HEIGHT, kScreenWidth-60*RATIOTYPE_WIDTH,2*RATIOTYPE_HEIGHT)];
    boundaryView.backgroundColor = [UIColor blackColor];
    [headerView addSubview:boundaryView];
    _newTableView.tableHeaderView = headerView;
    
}
//请求数据
-(void)createEndAuctionData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getAuction";
    NSDictionary *parameters = @{@"specialid":@"9"};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDict = responseObject[@"data"];
        
        NSArray *auctionArray = [dataDict objectForKey:@"auction"];
        //        NSLog(@"%@",auctionArray);
        for (NSDictionary *auctionDict in auctionArray) {
            EndAuctionModel *model = [[EndAuctionModel alloc]init];
            model.img = [NSString stringWithFormat:@"%@",[auctionDict objectForKey:@"img"]];
            model.auct_title = [NSString stringWithFormat:@"%@",[auctionDict objectForKey:@"auct_title"]];
            model.auct_price = [NSString stringWithFormat:@"%@",[auctionDict objectForKey:@"auct_price"]];
            model.auct_number = [NSString stringWithFormat:@"%@",[auctionDict objectForKey:@"auct_number"]];
            model.start_time = [NSString stringWithFormat:@"%@",[auctionDict objectForKey:@"start_time"]];
            model.end_time = [NSString stringWithFormat:@"%@",[auctionDict objectForKey:@"end_time"]];
    
            [_dataArray addObject:model];
        }
        [_newTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)createTableView
{
    _newTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _newTableView.delegate = self;
    _newTableView.dataSource = self;
    [self.view addSubview:_newTableView];

}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellName =@"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    return cell;
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
