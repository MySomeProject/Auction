//
//  RefundViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/8.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "RefundViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "EditViewController.h"
#import "AFNetworking.h"
#import "RefoundModel.h"
@interface RefundViewController ()
{
    int flag;
    RefoundModel *model;

}
@end

@implementation RefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置退款账户";
    self.view.tag = 20000;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTabItemLeftButton];
    
    [self createView];
    
    //退款账户数据请求

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


-(void)createView
{    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , 64 + 100 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    addButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [addButton setTitle:@"添加退款账户" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addButton addTarget:self action:@selector(drawAction5:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, addButton.frame.origin.y + addButton.frame.size.height + 5, kScreenWidth - 30 * RATIOTYPE_WIDTH, 20)];
    label.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label.text = @"您提取的保证金将退还到该账户";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, label.frame.origin.y + label.frame.size.height, kScreenWidth - 30 * RATIOTYPE_WIDTH, 20)];
    label2.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label2.text = @"如有问题可咨询客服电话：10098982398";
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
}
-(void)drawAction5:(UIButton *)button
{
    
    EditViewController * editVC = [[EditViewController alloc]init];
    editVC.sign = self.view.tag;
    [self.navigationController pushViewController:editVC animated:YES];
    
//    [self.navigationController presentViewController:editVC animated:YES completion:nil];
    
}

@end
