//
//  ServeGuaranteeViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/1.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "ServeGuaranteeViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
@interface ServeGuaranteeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_newTableView;
    NSMutableArray *_dataArray;
}
@end

@implementation ServeGuaranteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务保障";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTabItemLeftButton];
//    [self createTableView];
    [self createTextView];
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
-(void)createTextView
{
    UITextView *textview =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    textview.text = @" 1、拍大牌承诺如实描述拍品。\n 2、拍大牌对平台上所有拍卖的包袋、腕表类商品提供终身可追溯的鉴定服务卡一张，确保正品。\n 3、拍大牌对部分商品进行线下预展，竞买人可到现场参观竞拍商品。如竞买人拍到拍品，拍大牌因为任何原因不发货，将赔付竞买人 \n 5倍该商品保证金。拍大牌对所有拍品免收邮费，默认顺丰快递，如顺丰无法送到则选择EMS。";
    textview.textColor = [UIColor blueColor];
    textview.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textview];

}
//-(void)createTableView
//{
//    _newTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth-9, kScreenHeight) style:UITableViewStylePlain];
//    _newTableView.delegate = self;
//    _newTableView.dataSource = self;
//    [self.view addSubview:_newTableView];
//
//}
//#pragma mark -UITableViewDelegate
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 70;
//}
//#pragma mark UITableViewDataSource
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 2;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   static NSString *cellName = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//    }
//    for (int i = 0; i < 1; i++) {
//        UILabel *headerLabel = [ZYControl createLabelWithFrame:CGRectMake((20/375.0)*kScreenWidth,(15/667.0)*kScreenHeight+((40/667.0)*kScreenHeight+(15/667.0)*kScreenHeight+(15/667.0)*kScreenHeight)*i, 40, 40) Font:12 Text:nil];
//        headerLabel.backgroundColor = [UIColor grayColor];
//        [cell addSubview:headerLabel];
//    }
//    if (indexPath.row == 0) {
//        UILabel *upLabel = [ZYControl createLabelWithFrame:CGRectMake((80/375.0)*kScreenWidth, (25/667.0)*kScreenHeight,(300/375.0)*kScreenWidth, 20) Font:12 Text:@"本件商品已开具由＊＊＊＊＊提供的鉴定证书"];
//        upLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
//        [cell addSubview:upLabel];
//    }else if (indexPath.row == 1)
//    {
//        UILabel *downLabel = [ZYControl createLabelWithFrame:CGRectMake((80/375.0)*kScreenWidth, (25/667.0)*kScreenHeight, (300/375.0)*kScreenWidth, 20) Font:12 Text:@"本件商品提供线下预展"];
//        downLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
//        [cell addSubview:downLabel];
//    
//    }
//    return cell;
//    
//}

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
