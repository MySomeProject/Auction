//
//  ChangePasswordViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/7.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ZYControl.h"
#import "SettingViewController.h"
#import "AOColorFormat.h"
#import "PasswordViewController.h"

@interface ChangePasswordViewController ()
{
    UITextField *noteText;
}


@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"更改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createTabItemLeftButton];
    [self createView];
    
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
    noteText = [[UITextField alloc]initWithFrame:CGRectMake(15, 114 * RATIOTYPE_HEIGHT + 64, kScreenWidth - 30, 25)];
    noteText.textColor = [AOColorFormat colorWithHexString:@"#000000"];
    noteText.textAlignment = NSTextAlignmentLeft;
    noteText.font = [UIFont systemFontOfSize:16];
    noteText.placeholder = @"请输入短信验证码";
    noteText.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:noteText];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, noteText.frame.origin.y + 25 + 20 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 1)];
    line.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    [self.view addSubview:line];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, line.frame.origin.y + 1 +56 * RATIOTYPE_HEIGHT, kScreenWidth - 30 - 256 * RATIOTYPE_WIDTH, 80 * RATIOTYPE_HEIGHT)];
    label.text = @"点击右侧按钮获取短信验证码";
    label.textColor = [AOColorFormat colorWithHexString:@"#666666"];
    label.font = [UIFont systemFontOfSize:14];
    
    //自动换行
    label.lineBreakMode =UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    
    //高度自适应
    CGRect textFrame = label.frame;
    textFrame.size.height = [label.text boundingRectWithSize:CGSizeMake(textFrame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height;
    
    label.frame = CGRectMake(line.frame.origin.x, line.frame.origin.y + 1 +56 * RATIOTYPE_HEIGHT, kScreenWidth - 256 * RATIOTYPE_WIDTH, 80 * RATIOTYPE_HEIGHT);

    
    [self.view addSubview: label];
    
    UIButton *noteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    noteButton.frame = CGRectMake(kScreenWidth - 15 - 256 * RATIOTYPE_WIDTH + 6, line.frame.origin.y + 1 +56 * RATIOTYPE_HEIGHT, 250 * RATIOTYPE_WIDTH, 80 * RATIOTYPE_HEIGHT);
    noteButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [noteButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [noteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    noteButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    noteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noteButton];
    
    
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , noteButton.frame.origin.y + (80 + 100) * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    nextButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextButton addTarget:self action:@selector(drawAction5:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
    
}

-(void)drawAction5:(UIButton *)button
{
    if (noteText.text.length == 0 || [noteText.text isEqualToString:@"请输入短信验证码"])
    {
        
    }else
    {
        PasswordViewController *passVC = [[PasswordViewController alloc]init];

        [self.navigationController pushViewController:passVC animated:YES];
        
        self.hidesBottomBarWhenPushed = YES;
    }
}

@end
