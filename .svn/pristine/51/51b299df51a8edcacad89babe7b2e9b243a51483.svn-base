//
//  PasswordViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/7.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "PasswordViewController.h"
#import "SettingViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"

@interface PasswordViewController ()
{
    UITextField *password1;
    UITextField *password2;
    UIView *bgView1;
    UIButton *alterbtn1;
}

@end

@implementation PasswordViewController

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
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)createView
{
    password1 = [[UITextField alloc]initWithFrame:CGRectMake(15, 64 + 114 *RATIOTYPE_HEIGHT, kScreenWidth - 30, 25)];
    password1.textAlignment = NSTextAlignmentLeft;
    password1.textColor = [UIColor blackColor];
    password1.secureTextEntry = YES;
    password1.font = [UIFont systemFontOfSize:16];
    password1.placeholder = @"请输入密码";
    password1.clearsOnBeginEditing = YES;
    password1.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:password1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, password1.frame.origin.y + 25, kScreenWidth - 30, 1)];
    line1.backgroundColor = [AOColorFormat colorWithHexString: @"#d9d9d9"];
    [self.view addSubview:line1];
    
    password2 = [[UITextField alloc]initWithFrame:CGRectMake(15, 64 +1+ 114 *RATIOTYPE_HEIGHT + 25 + (105 *RATIOTYPE_HEIGHT - 25), kScreenWidth - 30, 25)];
    password2.textAlignment = NSTextAlignmentLeft;
    password2.textColor = [UIColor blackColor];
    password2.secureTextEntry = YES;
    password2.font = [UIFont systemFontOfSize:16];
    password2.placeholder = @"请确认密码";
    password2.clearsOnBeginEditing = YES;
    password2.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:password2];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15, password2.frame.origin.y + 25, kScreenWidth - 30, 1)];
    line2.backgroundColor = [AOColorFormat colorWithHexString: @"#d9d9d9"];
    [self.view addSubview:line2];
    
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , line2.frame.origin.y + 1 + 100 *RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    enterButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [enterButton setTitle:@"确定" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [enterButton addTarget:self action:@selector(drawAction5:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:enterButton];

}

-(void)drawAction5:(UIButton *)button
{
    if (password1.text != nil || password2.text != nil) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        self.tabBarController.tabBar.hidden = NO;
        
        
        
    }else if((password2 == nil && [password2.text isEqualToString:@"请确认密码"])|| (password1 == nil && [password1.text isEqualToString:@"请输入密码"]))
    {
        bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView1.backgroundColor = [UIColor blackColor];
        bgView1.alpha = 0.5;
        [self.view addSubview:bgView1];
        
        alterbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        alterbtn1.frame = CGRectMake((kScreenWidth - 500 *RATIOTYPE_WIDTH)/2,200 *RATIOTYPE_HEIGHT, 500 * RATIOTYPE_WIDTH, 200 * RATIOTYPE_HEIGHT) ;
        alterbtn1.backgroundColor = [UIColor whiteColor];
        alterbtn1.alpha = 1;
        [alterbtn1 addTarget:self action:@selector(alterAction4:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:alterbtn1];
        
        UILabel *alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, (120 * RATIOTYPE_HEIGHT)/2, 500 * RATIOTYPE_WIDTH-30 - 20, 20)];
        alterLabel.text = @"输入密码不能为空";
        alterLabel.textAlignment = NSTextAlignmentCenter;
        alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        alterLabel.font = [UIFont systemFontOfSize:14];
        [alterbtn1 addSubview:alterLabel];
    }else if([password1.text isEqualToString:password2.text])
    {
        bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView1.backgroundColor = [UIColor blackColor];
        bgView1.alpha = 0.5;
        [self.view addSubview:bgView1];
        
        alterbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        alterbtn1.frame = CGRectMake((kScreenWidth - 500 *RATIOTYPE_WIDTH)/2,200 *RATIOTYPE_HEIGHT, 500 * RATIOTYPE_WIDTH, 200 * RATIOTYPE_HEIGHT) ;
        alterbtn1.backgroundColor = [UIColor whiteColor];
        alterbtn1.alpha = 1;
        [alterbtn1 addTarget:self action:@selector(alterAction4:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:alterbtn1];
        
        UILabel *alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, (120 * RATIOTYPE_HEIGHT)/2, 500 * RATIOTYPE_WIDTH-30 - 20, 20)];
        alterLabel.text = @"新密码不能与就密码一样";
        alterLabel.textAlignment = NSTextAlignmentCenter;
        alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        alterLabel.font = [UIFont systemFontOfSize:14];
        [alterbtn1 addSubview:alterLabel];
        
    }else if (password2.text.length < 6)
    {
        bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView1.backgroundColor = [UIColor blackColor];
        bgView1.alpha = 0.5;
        [self.view addSubview:bgView1];
        
        alterbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        alterbtn1.frame = CGRectMake((kScreenWidth - 500 *RATIOTYPE_WIDTH)/2,200 *RATIOTYPE_HEIGHT, 500 * RATIOTYPE_WIDTH, 200 * RATIOTYPE_HEIGHT) ;
        alterbtn1.backgroundColor = [UIColor whiteColor];
        alterbtn1.alpha = 1;
        [alterbtn1 addTarget:self action:@selector(alterAction4:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:alterbtn1];
        
        UILabel *alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, (120 * RATIOTYPE_HEIGHT)/2, 500 * RATIOTYPE_WIDTH-30 - 20, 20)];
        alterLabel.text = @"输入密码至少为6位";
        
        alterLabel.textAlignment = NSTextAlignmentCenter;
        alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        alterLabel.font = [UIFont systemFontOfSize:14];
        [alterbtn1 addSubview:alterLabel];
    }
    
    
}
-(void)alterAction4:(UIButton *)button
{
    [bgView1 removeFromSuperview];
    [alterbtn1 removeFromSuperview];
}

@end
