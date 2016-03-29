//
//  OfferPriceRecordViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/1.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "OfferPriceRecordViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AFNetworking.h"
#import "OfferPriceRecordModel.h"
#import "OfferRecordCell.h"

@interface OfferPriceRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_newTableView;
    NSMutableArray *_dataArray;
    
    UILabel *leaderLabel;
    UILabel *weedOutLabel;
    
}
@end

@implementation OfferPriceRecordViewController
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
    self.title = @"出价记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTabItemLeftButton];
    [self createLabel];
    [self createTableView];
    [self createOfferPriceData];
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
-(void)createLabel
{
    NSArray*titleArray = @[@"状态",@"竞拍人",@"价格",@"竞拍时间"];
    for (int i = 0; i <4; i++) {
        UILabel *titleLabel = [ZYControl createLabelWithFrame:CGRectMake((40/375.0)*kScreenWidth+(50+20)*i,20*RATIOTYPE_HEIGHT+64, 80*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:14 Text:titleArray[i]];
        titleLabel.textColor = [AOColorFormat colorWithHexString:@"666666"];
        [self.view addSubview:titleLabel];
        
    }
    //创建分界线
    UIView *boundaryView = [[UIView alloc]initWithFrame:CGRectMake((20/375.0)*kScreenWidth,70*RATIOTYPE_HEIGHT+64, kScreenWidth-(20/375.0)*kScreenWidth*2, 2*RATIOTYPE_HEIGHT)];
    boundaryView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:boundaryView];
}
-(void)createTableView
{
    _newTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,72*RATIOTYPE_HEIGHT+64,kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _newTableView.delegate = self;
    _newTableView.dataSource = self;
    [self.view addSubview:_newTableView];
}

-(void)createOfferPriceData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=bidRecord";
    NSDictionary *parameters = @{@"auctionid":@"10"};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *offArray = responseObject[@"data"];
        for (NSDictionary *dict in offArray) {
          
            OfferPriceRecordModel *model = [[OfferPriceRecordModel alloc]init];
            model.username = [NSString stringWithFormat:@"%@",[dict objectForKey:@"username"]];
            model.put_price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"put_price"]];
            model.add_time = [NSString stringWithFormat:@"%@",[dict objectForKey:@"add_time"]];
            [_dataArray addObject:model];
        }
        
        [_newTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


}

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *cellName1 = @"cellID1";
        OfferRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName1];
        
        if (!cell) {
            cell = [[OfferRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName1];
            
        }
        leaderLabel = [[UILabel alloc]initWithFrame:CGRectMake((20/375.0)*kScreenWidth,(10/667.0)*kScreenHeight+(40+(10/667.0)*kScreenHeight+(10/667.0)*kScreenHeight)*0, 40, 40)];
        leaderLabel.text = @"领先";
        leaderLabel.font = [UIFont systemFontOfSize:12];
        leaderLabel.textColor = [AOColorFormat colorWithHexString:@"c70065"];
        leaderLabel.textAlignment = NSTextAlignmentCenter;
        leaderLabel.layer.borderColor = [AOColorFormat colorWithHexString:@"c70065"].CGColor;
        leaderLabel.layer.borderWidth = 1;
        [cell.contentView addSubview:leaderLabel];
        
        OfferPriceRecordModel *model = _dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }else{
    
        static NSString *cellName = @"cellID";
        OfferRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        
        
        if (cell == nil) {
            cell = [[OfferRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            
            NSLog(@"%ld",_dataArray.count);
        }

        weedOutLabel = [[UILabel alloc]initWithFrame:CGRectMake((20/375.0)*kScreenWidth, (10/667.0)*kScreenHeight+(40+(10/667.0)*kScreenHeight+(10/667.0)*kScreenHeight)*0, 40, 40)];
        weedOutLabel.text = @"淘汰";
        weedOutLabel.font = [UIFont systemFontOfSize:12];
        weedOutLabel.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
        weedOutLabel.textAlignment = NSTextAlignmentCenter;
        weedOutLabel.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
        weedOutLabel.layer.borderWidth = 1;
        [cell.contentView addSubview:weedOutLabel];
        OfferPriceRecordModel *model = _dataArray[indexPath.row];
        cell.model = model;
    
       return cell;
    
    }
    
    
//    static NSString *cellName = @"cellID";
//    OfferRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    
//    
//    if (cell == nil) {
//        cell = [[OfferRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        
//        NSLog(@"%ld",_dataArray.count);
//    }
////    }else{
////        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
////        for (UIView *subview in subviews) {
////            [subview removeFromSuperview];
////        [[cell.subviews objectAtIndex:1]removeFromSuperview];
////        for (UIView *subView in cell.contentView.subviews) {
////            [subView removeFromSuperview];
////        }
////        }
//    if (indexPath.row == 0) {
//        
//        leaderLabel = [[UILabel alloc]initWithFrame:CGRectMake((20/375.0)*kScreenWidth,(10/667.0)*kScreenHeight+(40+(10/667.0)*kScreenHeight+(10/667.0)*kScreenHeight)*0, 40, 40)];
//        leaderLabel.text = @"领先";
//        leaderLabel.font = [UIFont systemFontOfSize:12];
//        leaderLabel.textColor = [AOColorFormat colorWithHexString:@"c70065"];
//        leaderLabel.textAlignment = NSTextAlignmentCenter;
//        leaderLabel.layer.borderColor = [AOColorFormat colorWithHexString:@"c70065"].CGColor;
//        leaderLabel.layer.borderWidth = 1;
//        [cell.contentView addSubview:leaderLabel];
//    }else{
////        if ([leaderLabel isKindOfClass:]) {
////            [leaderLabel removeFromSuperview];
////
////        }
//        weedOutLabel = [[UILabel alloc]initWithFrame:CGRectMake((20/375.0)*kScreenWidth, (10/667.0)*kScreenHeight+(40+(10/667.0)*kScreenHeight+(10/667.0)*kScreenHeight)*0, 40, 40)];
//        weedOutLabel.text = @"淘汰";
//        weedOutLabel.font = [UIFont systemFontOfSize:12];
//        weedOutLabel.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
//        weedOutLabel.textAlignment = NSTextAlignmentCenter;
//        weedOutLabel.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
//        weedOutLabel.layer.borderWidth = 1;
//        [cell.contentView addSubview:weedOutLabel];
//    }
//
//
////    }
//    
////    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
////    for (UIView *subview in subviews) {
////        [subview removeFromSuperview];
////    }
//    
  

    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
