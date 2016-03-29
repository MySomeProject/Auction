//
//  InformationViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "InformationViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AFNetworking.h"
#import "AddressModel.h"


@interface InformationViewController ()
{

    UIView *bgView1;
    UIButton *alterbtn1;
    
    UIButton *btn;
    UIButton *btn1;
    
    //选中之后返回数据标示
    NSString *sign;
}

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒设置";
    self.view.backgroundColor = [UIColor whiteColor];

    [self createDatastart];
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
#pragma mark --- 加载数据
//加载默认数据
-(void)createDatastart
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameter = @{@"client_id":[user objectForKey:@"client_id"]};
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getRemindersWay";
    
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddressModel *model = [[AddressModel alloc]init];
        NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
        model.remindway = [NSString stringWithFormat:@"%@",[dic objectForKey:@"remindway"]];
        
        NSString *str = model.remindway;
        
        if ([str isEqualToString:@"0"]) {
            btn.selected = YES;
        }else if ([str isEqualToString:@"1"])
        {
            btn1.selected = YES;
        }else
        {
        }
        NSLog(@"%@",str);
        
        NSLog(@"数据成功－－－%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据失败－－－%@",operation.error);
    }];

}
//加载选择数据
-(void)createData
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameter = @{@"client_id":[user objectForKey:@"client_id"],@"type":sign};
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=setRemindersType";
    
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"数据成功－－－%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据失败－－－%@",operation.error);
    }];
}

#pragma mark --- 创建页面
-(void)createView
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, 30 * RATIOTYPE_WIDTH + 64, kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 20)];
    label1.textColor = [AOColorFormat colorWithHexString:@"#666666"];
    label1.text = @"奢拍将在以下时间提醒您";
    label1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label1];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, label1.frame.origin.y + 20 + 50 * RATIOTYPE_HEIGHT, (kScreenWidth - 30 * RATIOTYPE_WIDTH * 2)/2, 25)];
    view1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view1];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 25, 25)];
    img1.image = [UIImage imageNamed:@"结束提醒"];
    [view1 addSubview:img1];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10 + img1.frame.size.width,0, view1.frame.size.width - img1.frame.size.width, 25)];
    lab1.text = @"开场时";
    lab1.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    lab1.font = [UIFont systemFontOfSize:14];
    [view1 addSubview:lab1];
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(view1.frame.size.width + view1.frame.origin.x, label1.frame.origin.y + 20 + 50 * RATIOTYPE_HEIGHT, (kScreenWidth - 30 * RATIOTYPE_WIDTH * 2)/2, 25)];
    view2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view2];
    
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 25, 25)];
    img2.image = [UIImage imageNamed:@"结束提醒"];
    [view2 addSubview:img2];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10 + img2.frame.size.width,0, view2.frame.size.width - img2.frame.size.width, 25)];
    lab2.text = @"结束前30分钟";
    lab2.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    lab2.font = [UIFont systemFontOfSize:14];
    [view2 addSubview:lab2];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, view1.frame.origin.y + view1.frame.size.height + 50 * RATIOTYPE_HEIGHT, kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 1)];
    line.backgroundColor = [AOColorFormat colorWithHexString:@"#d9d9d9"];
    [self.view addSubview:line];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, line.frame.origin.y + 1 +100 * RATIOTYPE_HEIGHT, 100, 20)];
    label2.textColor = [AOColorFormat colorWithHexString:@"#666666"];
    label2.text = @"提醒方式";
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, label2.frame.origin.y + 20, 100, 100 * RATIOTYPE_HEIGHT)];
    label3.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label3.text = @"手机短信";
    label3.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label3];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, label3.frame.origin.y + label3.frame.size.height , kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 1)];
    line1.backgroundColor = [AOColorFormat colorWithHexString:@"#d9d9d9"];
    [self.view addSubview:line1];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, label3.frame.origin.y + label3.frame.size.height, 100, 100 * RATIOTYPE_HEIGHT)];
    label4.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    label4.text = @"客户端通知";
    label4.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label4];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, label4.frame.origin.y + label4.frame.size.height , kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 1)];
    line2.backgroundColor = [AOColorFormat colorWithHexString:@"#d9d9d9"];
    [self.view addSubview:line2];
    
    
    //选择按钮
    
    btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth - 30 * RATIOTYPE_WIDTH - 20, label2.frame.origin.y + 20 + (100 *RATIOTYPE_HEIGHT - 20)/2, 17, 17);
    btn.tag = 3201;
    [btn setImage:[UIImage imageNamed:@"未选中状态"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    btn1 = [UIButton buttonWithType: UIButtonTypeCustom];
    btn1.frame = CGRectMake(kScreenWidth - 30 * RATIOTYPE_WIDTH - 20, label2.frame.origin.y + 20 + (100 *RATIOTYPE_HEIGHT - 20)/2 + 100 * RATIOTYPE_HEIGHT, 17, 17);
    btn1.tag = 3202;
    [btn1 setImage:[UIImage imageNamed:@"未选中状态"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(changeAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)changeAct:(UIButton *)button
{
    if (btn.tag == button.tag) {
        btn.selected = YES;
        btn1.selected = NO;
        [btn setImage:[UIImage imageNamed:@"选择状态按钮"] forState:UIControlStateSelected];
        sign = @"0";

    }else
    {
        btn.selected = NO;
        btn1.selected = YES;
        [btn1 setImage:[UIImage imageNamed:@"选择状态按钮"] forState:UIControlStateSelected];
        sign = @"1";
      
    }
      [self createData];
}


-(void)drawAction:(UIButton *)button
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
    
    UILabel *alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, (120 * RATIOTYPE_HEIGHT)/2, 500 *RATIOTYPE_WIDTH-30 - 20, 20)];
    alterLabel.text = @"添加成功";
    alterLabel.textAlignment = NSTextAlignmentCenter;
    alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    alterLabel.font = [UIFont systemFontOfSize:14];
    [alterbtn1 addSubview:alterLabel];
    
    
}

-(void)alterAction4:(UIButton *)button
{
    [self createData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//#pragma mark -- QRadioButtonDelegate
//- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
//    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
//}



@end
