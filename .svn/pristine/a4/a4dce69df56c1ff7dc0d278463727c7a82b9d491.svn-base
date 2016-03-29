//
//  LogInViewController2.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/8/3.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "LogInViewController2.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "RegisterViewController.h"
#import "FindPassWordViewController.h"
#import "AFNetworking.h"
#import "SettingViewController.h"
#import "RTLabel.h"
#import "AppDelegate.h"
#import "Single.h"
@interface LogInViewController2 ()<RTLabelDelegate>
{
    UIImageView *LeftButtonImage;
    UIImageView *RightButtonImage;
    UITextField *userNameTextField;
    UITextField *passWordTextField;
    UIButton *logInButton;
    UIView *viewBoundray1;
    
}
@end

@implementation LogInViewController2
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *loginString = [defaults objectForKey:@"login"];
        NSString *passwordString = [defaults objectForKey:@"password"];
        
        if (loginString.length==0||passwordString.length==0) {
            self.tabBarItem.title = @"个人中心";
            self.tabBarItem.image = [UIImage imageNamed:@"个人设置.png"];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    [self.view endEditing:YES];
    //创建导航左侧按钮
    [self createLeftorRightButton];
    [self createTextField];
    [self createLogInButton];
    [self createBackPasswordUnderLine];
    //    [self createPost];


}
-(void)createLeftorRightButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UIButton *rightButton = [ZYControl createButtonWithFrame:CGRectMake(280, 0, 32, 320) ImageName:nil Target:self Action:@selector(rightButtonClick:) Title:@"注册"];
    [rightButton setTitleColor:[AOColorFormat colorWithHexString:@"666666"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
-(void)rightButtonClick:(UIButton *)rightButton
{
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:NO];
    
}
-(void)createTextField
{
    
    
    userNameTextField = [ZYControl createTextFieldWithFrame:CGRectMake(15,114*RATIOTYPE_HEIGHT+64,kScreenWidth-30,60*RATIOTYPE_HEIGHT) placeholder:@"请输入手机号" passWord:NO leftImageView:nil rightImageView:nil Font:17];
    userNameTextField.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9d"].CGColor;
    [self.view addSubview:userNameTextField];
    
    
    UIView *viewBoundray =[[UIView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(userNameTextField.frame)+20*RATIOTYPE_HEIGHT,kScreenWidth-30,1*RATIOTYPE_HEIGHT)];
    viewBoundray.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    viewBoundray.alpha = 0.5;
    [self.view addSubview:viewBoundray];
    
    
    //输入密码
    passWordTextField = [ZYControl createTextFieldWithFrame:CGRectMake(15,CGRectGetMaxY(viewBoundray.frame)+30*RATIOTYPE_HEIGHT, kScreenWidth-30,60*RATIOTYPE_HEIGHT) placeholder:@"请输入密码" passWord:NO leftImageView:nil rightImageView:nil Font:17];
    passWordTextField.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
    [self.view addSubview:passWordTextField];
    
    
    viewBoundray1 =[[UIView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(viewBoundray.frame)+104*RATIOTYPE_HEIGHT, kScreenWidth-30, 1*RATIOTYPE_HEIGHT)];
    viewBoundray1.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    viewBoundray1.alpha = 0.5;
    [self.view addSubview:viewBoundray1];
    
}
//创建登录按钮
-(void)createLogInButton
{
    logInButton = [ZYControl createButtonWithFrame:CGRectMake(15,CGRectGetMaxY(viewBoundray1.frame)+100*RATIOTYPE_HEIGHT,kScreenWidth-30,100*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:@selector(logInButtonClick:) Title:@"登录"];
    logInButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    logInButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:logInButton];
    
}
-(void)logInButtonClick:(UIButton *)logInButton
{
    if (userNameTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入账号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if (passWordTextField.text.length == 0){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        if (userNameTextField.text.length < 11) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"手机号的位数只能是11位" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            
            /**
             * 移动号段正则表达式
             */
            NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
            /**
             * 联通号段正则表达式
             */
            NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
            /**
             * 电信号段正则表达式
             */
            NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            BOOL isMatch1 = [pred1 evaluateWithObject:userNameTextField.text];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:userNameTextField.text];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            BOOL isMatch3 = [pred3 evaluateWithObject:userNameTextField.text];
            
            if (isMatch1 || isMatch2 || isMatch3) {
                [self createLoginData];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入正确的手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }
    }
    
}
//登录数据请求
-(void)createLoginData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=userLogin";
    NSDictionary *parameters =@{@"mobile":userNameTextField.text,@"password":passWordTextField.text};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        _loginString =[NSString stringWithFormat:@"%@",[dict objectForKey:@"client_id"]];
        Single *sin = [Single shareSingle];
        sin.string = _loginString;

        
        NSNumber *codeNum = responseObject[@"code"];
        if ([codeNum integerValue] == 100) {
            AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
            [appdelegate setTabAsRootController];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        NSLog(@"%@",responseObject);
        
        NSString *string = responseObject[@"message"];
        NSLog(@"%@",string);
        
        NSString * username = userNameTextField.text;
        NSString * password = passWordTextField.text;
        NSUserDefaults * userDefaults =  [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:username forKey:@"username"];
        [userDefaults setObject:password forKey:@"password"];
        [userDefaults synchronize];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
//创建找回密码下划线
-(void)createBackPasswordUnderLine
{
    
    //查看用户协议
    RTLabel *rlabel = [[RTLabel alloc]init];
    rlabel.delegate = self;
    NSString *str = @"<a href='http://..'><font color='#666666' size=16 >重置密码</font></a>";
    [rlabel setText:str];
    rlabel.frame = CGRectMake(kScreenWidth-150*RATIOTYPE_WIDTH, CGRectGetMaxY(logInButton.frame)+10*RATIOTYPE_HEIGHT,300*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT);
    [self.view addSubview:rlabel];
    
}

#pragma mark - RLabelDelegate
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url{
    FindPassWordViewController *fvc = [[FindPassWordViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
    
}

-(void)backPassWordButtonClick:(UIButton *)backPassWordButton
{
    //进入找回密码界面
    FindPassWordViewController *fpw = [[FindPassWordViewController alloc]init];
    [self.navigationController pushViewController:fpw animated:NO];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
