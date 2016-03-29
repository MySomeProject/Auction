//
//  DrawMassageViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/9.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "DrawMassageViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "DrawPayViewController.h"
#import "AFNetworking.h"

@interface DrawMassageViewController ()<UITextFieldDelegate>
{
    UITextField *massage;
    UIButton *noteButton;
    UILabel *label;
}

@end

@implementation DrawMassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提取保证金";
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
    
    self.tabBarController.tabBar.hidden = YES;

}
#pragma mark --- 加载数据
-(void)createData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *paramater = @{@"mobile":@"18810054179"};
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=messageSend";
    [manager POST:url parameters:paramater success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        __block int timeout=30; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){
                //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置界面的按钮显示 根据自己需求设置
                    [noteButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    noteButton.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSString *str = @"秒后重新发送";
                    [noteButton setTitle:[NSString stringWithFormat:@"%@%@",strTime,str] forState:UIControlStateNormal];
                    noteButton.titleLabel.font =[UIFont systemFontOfSize:14];
                    noteButton.userInteractionEnabled = NO;
                    
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);

        
        label.text = @"验证码已通过短信发送到您的手机";

        
        NSLog(@"验证码发送成功***%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        label.text = @"发送失败，请重试！";
        
        NSLog(@"验证码发送失败***%@",operation.error);
    }];
    
}

#pragma mark --- 确认提取保证金接口
-(void)createDrawCashData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameter = @{@"holder_name":_massArr[0],@"brank_num":_massArr[2],@"brank_name":_massArr[1],@"extra_price":_massArr[3],@"client_id":[user objectForKey:@"client_id"],@"id":@"1"};
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getDepositSuccess";
    
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"提取保证金成功***%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"提取保证金失败***%@",operation.error);
    }];
}


#pragma mark - 创建页面
-(void)createView
{
    massage = [[UITextField alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, 114 * RATIOTYPE_HEIGHT + 64,kScreenWidth - 30 * RATIOTYPE_WIDTH * 2 - 256 * RATIOTYPE_WIDTH, 80 * RATIOTYPE_HEIGHT)];
    massage.placeholder = @"请输入验证码";
    massage.font = [UIFont systemFontOfSize:17];
    massage.keyboardType = UIKeyboardTypeDecimalPad;
    massage.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:massage];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(massage.frame.origin.x, massage.frame.origin .y + massage.frame.size.height, massage.frame.size.width - 5, 1)];
    line.backgroundColor = [AOColorFormat colorWithHexString:@"#d9d9d9"];
    [self.view addSubview:line];
    
    noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noteButton.frame = CGRectMake(massage.frame.origin.x + massage.frame.size.width, massage.frame.origin.y, 256 * RATIOTYPE_WIDTH, 80 * RATIOTYPE_HEIGHT);
    noteButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [noteButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [noteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    noteButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    noteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [noteButton addTarget:self action:@selector(drawMass:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noteButton];

    label = [[UILabel alloc]initWithFrame:CGRectMake(line.frame.origin.x, line.frame.origin.y + 30 *RATIOTYPE_HEIGHT, kScreenWidth - 30 * RATIOTYPE_WIDTH, 20)];
    label.textColor = [AOColorFormat colorWithHexString:@"#808080"];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 , label.frame.origin.y + 20 + 176 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    nextButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextButton addTarget:self action:@selector(drawAction5:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
    
    
}

-(void)drawAction5:(UIButton *)button
{
    if (massage.text.length == 0 || [massage.text isEqualToString:@"请输入验证码"])
    {
        
        
    }else
    {
    [self createDrawCashData];
    
    DrawPayViewController *payVC = [[DrawPayViewController alloc]init];
    [self.navigationController pushViewController:payVC animated:YES];
        
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)drawMass:(UIButton *)button
{
    [self createData];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    massage.placeholder = @"";
    return YES;
    
}
@end
