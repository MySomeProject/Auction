//
//  FindPassWordViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/2.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AFNetworking.h"
@interface FindPassWordViewController ()
{
    UIView *boundaryView;
    UITextField *againPassWordField;
    UITextField *phoneField;
    UITextField *identifyingCodeField;
    UITextField *newPassWordFeild;
}
@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"重置密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    //创建导航左侧按钮
    [self createLeftButton];
    [self createTextFeild];
    //创建提交Button
    [self createSubmitButton];
    
}
-(void)createLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createTextFeild
{
    //创建分界线
    for (int i = 0; i<4; i++) {
        boundaryView = [[UIView alloc]initWithFrame:CGRectMake((10/375.0)*kScreenWidth, (150/667.0)*kScreenHeight+((52/667.0)*kScreenHeight)*i,kScreenWidth-20,1*RATIOTYPE_HEIGHT)];
        if (i == 1) {
            boundaryView = [[UIView alloc]initWithFrame:CGRectMake((10/375.0)*kScreenWidth, (150/667.0)*kScreenHeight+((52/667.0)*kScreenHeight)*1,kScreenWidth-(150/375.0)*kScreenWidth,1*RATIOTYPE_HEIGHT)];
            [self.view addSubview:boundaryView];
        }
        boundaryView.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
        [self.view addSubview:boundaryView];
    }
    
    //创建获取验证码Button
    UIButton *getIdentifyingCodeButton = [ZYControl createButtonWithFrame:CGRectMake((10/375.0)*kScreenWidth+(kScreenWidth-150/375.0*kScreenWidth)+(5/375.0)*kScreenWidth,(150/667.0)*kScreenHeight+(13/667.0)*kScreenHeight,(123/375.0)*kScreenWidth, (40/667.0)*kScreenHeight) ImageName:nil Target:nil Action:nil Title:@"获取验证码"];
    [getIdentifyingCodeButton addTarget:self action:@selector(getIdentifyingCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    getIdentifyingCodeButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    getIdentifyingCodeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:getIdentifyingCodeButton];
    
    //创建UITextFeild
    phoneField = [ZYControl createTextFieldWithFrame:CGRectMake((10/375.0)*kScreenWidth, (120/667.0)*kScreenHeight, (kScreenWidth-(20/375.0)*kScreenWidth)/375.0*kScreenWidth,(20/667.0)*kScreenHeight) placeholder:@"请输入手机号" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    phoneField.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    [self.view addSubview:phoneField];
    
    identifyingCodeField = [ZYControl createTextFieldWithFrame:CGRectMake((10/375.0)*kScreenWidth,(170/667.0)*kScreenHeight, (kScreenWidth-(140/375.0)*kScreenWidth)/375.0*kScreenWidth, (20/667.0)*kScreenHeight) placeholder:@"请输入验证码" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    identifyingCodeField.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    [self.view addSubview:identifyingCodeField];
    
    newPassWordFeild = [ZYControl createTextFieldWithFrame:CGRectMake((10/375.0)*kScreenWidth, (220/667.0)*kScreenHeight,(kScreenWidth-(20/375.0)*kScreenWidth)/375.0*kScreenWidth, (20/667.0)*kScreenHeight) placeholder:@"请输入新密码" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    newPassWordFeild.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    [self.view addSubview:newPassWordFeild];
    
    againPassWordField = [ZYControl createTextFieldWithFrame:CGRectMake((10/375.0)*kScreenWidth, (270/667.0)*kScreenHeight, (kScreenWidth-(20/375.0)*kScreenWidth)/375.0*kScreenWidth, (20/667.0)*kScreenHeight) placeholder:@"请再次输入新密码" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    againPassWordField.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    [self.view addSubview:againPassWordField];
    
}
-(void)createSubmitButton
{
    UIButton *submitButton = [ZYControl createButtonWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,CGRectGetMaxY(againPassWordField.frame)+100*RATIOTYPE_HEIGHT, kScreenWidth-20*RATIOTYPE_WIDTH,100*RATIOTYPE_WIDTH) ImageName:nil Target:self Action:@selector(submitButtonClick:) Title:@"提交"];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    submitButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    [self.view addSubview:submitButton];
    
    UILabel *titleLabel = [ZYControl createLabelWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, CGRectGetMaxY(submitButton.frame)+10*RATIOTYPE_HEIGHT, kScreenWidth, 40*RATIOTYPE_HEIGHT) Font:14 Text:@"短信验证码已发送到您的手机，请注意查收并输入"];
    titleLabel.textColor = [AOColorFormat colorWithHexString:@"666666"];
    [self.view addSubview:titleLabel];
    
    
}
//获取验证码
-(void)getIdentifyingCodeButtonClick:(UIButton *)getIdentifyingCodeButton
{
    if (phoneField.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        
        [self verficationCode];
        
        
        __block int timeout=30; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [getIdentifyingCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    getIdentifyingCodeButton.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [getIdentifyingCodeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                    getIdentifyingCodeButton.titleLabel.font =[UIFont systemFontOfSize:14];
                    getIdentifyingCodeButton.userInteractionEnabled = NO;
                    
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
    }
}
//获取验证码接口
-(void)verficationCode
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=messageSend";
    NSDictionary *parameters = @{@"mobile":phoneField.text,};
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString * string = responseObject[@"message"];
        NSLog(@"%@",string);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
-(void)submitButtonClick:(UIButton *)submitButton
{
    if (phoneField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }else{
        
        if (phoneField.text.length < 11) {
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
            BOOL isMatch1 = [pred1 evaluateWithObject:phoneField.text];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:phoneField.text];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            BOOL isMatch3 = [pred3 evaluateWithObject:phoneField.text];
            
            if (isMatch1 || isMatch2 || isMatch3) {
                
                if (identifyingCodeField.text.length == 0){
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入验证码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                    [alert show];
                    
                }else{
                    
                    if ([newPassWordFeild.text isEqualToString:againPassWordField.text]) {
                        [self againcodeData];
                    }else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"两次输入密码不一致" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                        [alert show];
                        
                    }
                    
                    
                }
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入正确的手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
            
        }
        
    }
    
}
//重置密码数据请求
-(void)againcodeData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=resetPassword";
    NSDictionary *parameters = @{@"mobile":phoneField.text,@"code":identifyingCodeField.text,@"password":newPassWordFeild.text};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",operation.responseString);
    }];
    
    
    
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
