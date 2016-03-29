//
//  IdeaViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "IdeaViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "PersonalViewController.h"

@interface IdeaViewController ()

@end

@implementation IdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
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

-(void)createView
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 80)/2, 300 * RATIOTYPE_HEIGHT - 100 * RATIOTYPE_HEIGHT, 80, 45 *RATIOTYPE_HEIGHT )];
    label1.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"提交成功!";
    label1.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 240)/2, label1.frame.origin.y + 55 *RATIOTYPE_HEIGHT, 240, 45 *RATIOTYPE_HEIGHT )];
    label2.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"感谢您提出的宝贵意见！";
    label2.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:label2];
    
    UIButton *backButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton1.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , label2.frame.origin.y + 45 * RATIOTYPE_HEIGHT + 100 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    backButton1.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [backButton1 setTitle:@"确定" forState:UIControlStateNormal];
    [backButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backButton1 addTarget:self action:@selector(drawAction3:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton1];
    
}

-(void)drawAction3:(UIButton *)button
{

    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
