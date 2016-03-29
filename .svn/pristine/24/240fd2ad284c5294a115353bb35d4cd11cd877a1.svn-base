//
//  SettingViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/25.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "SettingViewController.h"
#import "AOColorFormat.h"
#import "AddressViewController.h"
#import "InformationViewController.h"
#import "ChangePasswordViewController.h"
#import "RefundViewController.h"
#import "AboutViewController.h"
#import "ZYControl.h"
#import "HomeViewController.h"
#import "AFNetworking.h"
#import "AffirmViewController.h"
#import "UserProtolViewController.h"
#import "EditViewController.h"
#import "AffirmModel.h"
#import "LogInViewController2.h"
#import "RTLabel.h"
#import "FindPassWordViewController.h"
#import "RegisterViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,RTLabelDelegate>
{
    NSArray *files;
    NSString *cachPath;
    float fileSize;
    NSNumber *flag;
    NSMutableArray *_dataArray;
    
    
    //我的拍卖界面
    UIView * bottomView;
    //登录界面
    UIView * loginView;
    
    UIImageView *LeftButtonImage;
    UIImageView *RightButtonImage;
    UITextField *userNameTextField;
    UITextField *passWordTextField;
    UIButton *logInButton;
    UIView *viewBoundray1;
    
    UILabel * titleLable;
    UIButton * registerBtn;
    
}

@end

@implementation SettingViewController

-(id)init
{
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc]init];
        self.tabBarItem.title = @"个人中心";
        self.tabBarItem.image = [UIImage imageNamed:@"个人设置.png"];
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.tag = 999;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [bottomView removeFromSuperview];
    [loginView removeFromSuperview];
    [self judgeState];
}
-(void)judgeState{
    
    
    [bottomView removeFromSuperview];
    [loginView removeFromSuperview];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"client_id"] == nil) {
        //创建登录界面
        [self createLoginView];
        [self createTitleView];
        
    }else{
        
        //创建个人设置界面
        [self createUserCenter];
        [self createNav];
        
        
    }
}

-(void)createTitleView{
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.text = @"登录";
    self.navigationItem.titleView = titleLable;
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(0, 0, 50, 30);
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem * rightBar1 = [[UIBarButtonItem alloc] initWithCustomView:registerBtn];
    self.navigationItem.rightBarButtonItem = rightBar1;
}


//重写父类方法——导航栏
-(void)createNav{
    
    UILabel * titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    titleLable1.textColor = [UIColor blackColor];
    titleLable1.font = [UIFont boldSystemFontOfSize:20];
    titleLable1.text = @"个人中心";
    self.navigationItem.titleView = titleLable1;
}

-(void)registerBtnClick
{
    
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}


//个人设置
-(void)createUserCenter
{
    bottomView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:bottomView];
    
    self.title = @"个人中心";
    
    setTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, 100 * RATIOTYPE_HEIGHT * 6)];
    
    setTableView.delegate = self;
    setTableView.dataSource = self;
    
    [bottomView addSubview:setTableView];
    
    UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    quitButton.frame = CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2 ,64 + setTableView.frame.size.height + 100 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 100 * RATIOTYPE_HEIGHT);
    quitButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [quitButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(quitAct:) forControlEvents:UIControlEventTouchUpInside];
    quitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [bottomView addSubview:quitButton];
    
}



-(void)quitAct:(UIButton *)button
{
 
    NSUserDefaults * userDefaults =  [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"client_id"];
    [userDefaults synchronize];
    
    [bottomView removeFromSuperview];
    [self createLoginView];
}

//退款账号数据
-(void)createReFundData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=Api&act=personalDefault";
    NSDictionary *parameters = @{@"client_id":[user objectForKey:@"client_id"],@"setid":@"2"};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        flag =responseObject[@"data"];
        NSLog(@"%@",responseObject[@"data"]);
        
        if (flag == 0) {
            
            RefundViewController *refundVC = [[RefundViewController alloc]init];
            
            [self.navigationController pushViewController:refundVC animated:YES];
            
            self.tabBarController.tabBar.hidden = YES;
            
            
        }else{
            
            EditViewController *evc = [[EditViewController alloc]init];
            
            [self.navigationController pushViewController:evc animated:YES];
            
            self.tabBarController.tabBar.hidden = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//直接跳转确认界面数据
-(void)createAffirmData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=accountlist";
    NSDictionary *parameters = @{@"client_id":@"1001"};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictData = responseObject[@"data"];
        NSArray *dictArray = [dictData objectForKey:@"brank"];
        for (NSDictionary *Dict in dictArray) {
            AffirmModel *model = [[AffirmModel alloc] init];
            model.brand_holder = [Dict objectForKey:@"brand_holder"];
            model.brand_cardnumber = [Dict objectForKey:@"brand_cardnumber"];
            model.brand_cardname = [Dict objectForKey:@"brand_cardname"];
            model.address = [Dict objectForKey:@"address"];
            model.add_time = [Dict objectForKey:@"add_time"];
            
            [_dataArray addObject:model];
            AffirmViewController *affVC = [[AffirmViewController alloc]init];
            for (AffirmModel *Afirmodel in _dataArray) {
                affVC.nameString = Afirmodel.brand_holder;
                NSLog(@"%@",affVC.nameString);
                affVC.cardNumString = Afirmodel.brand_cardnumber;
                affVC.openingBankString = Afirmodel.brand_cardname;
                affVC.locationString = Afirmodel.brand_provinces;
                
            }
            [self.navigationController pushViewController:affVC animated:YES];
            
            self.tabBarController.tabBar.hidden = YES;
            
        }
        NSLog(@"%@",_dataArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark - 缓存清理
-(void)clearCach
{
    fileSize = 0.00;
    cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    files = [[NSFileManager defaultManager]subpathsAtPath:cachPath];//获取cach文件夹中所有文件的文件名
    
    for (NSString *str in files) {
        NSString *newPath = [cachPath stringByAppendingPathComponent:str];
        NSDictionary *dic = [[NSFileManager defaultManager]attributesOfItemAtPath:newPath error:nil];
        long long size = [dic [NSFileSize] longLongValue];
        
        fileSize += size;
    }
    
    fileSize = fileSize / 1024.00 /1024.00;
    
}

#pragma mark ---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100 * RATIOTYPE_HEIGHT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *setCellstr = @"settingCell";
    UITableViewCell *setCell = [tableView dequeueReusableCellWithIdentifier:setCellstr];
    
    if (!setCell) {
        setCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:setCellstr];
        
    }
    
    [self clearCach];
    
    NSArray *cellName = @[@"选择收获地址",@"设置退款账户",@"消息提醒设置",@"清空缓存",@"用户协议",@"关于奢拍"];
    setCell.textLabel.text = cellName[indexPath.row];
    setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    setCell.textLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    setCell.textLabel.font = [UIFont systemFontOfSize:16];
    
    [setTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 15)];
    
    
    if (indexPath.row == 3) {
        setCell.accessoryType = UITableViewCellAccessoryNone;
        setCell.detailTextLabel.text = [NSString stringWithFormat:@"(%ld个文件 共%.2fM)",(unsigned long)files.count,fileSize];
        setCell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        setCell.detailTextLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        setCell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return setCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消TableCell的选中状态，记住
    
    switch (indexPath.row) {
        case 0:
        {
            AddressViewController *addressVC = [[AddressViewController alloc]init];
            addressVC.titleLabel = @"选择收货地址";
            addressVC.addBtnTitle = @"添加收货地址";
            
            [self.navigationController pushViewController:addressVC animated:YES];
            self.tabBarController.tabBar.hidden = YES;
            
        }
            
            break;
            
        case 1:
        {
            [self createReFundData];
            
        }
            break;
            
        case 2:
        {
            InformationViewController *informationVC = [[InformationViewController alloc]init];
            [self.navigationController pushViewController:informationVC animated:YES];
            self.tabBarController.tabBar.hidden = YES;
            
        }
            
            break;
            //
            //        case 3:
            //        {
            //            ChangePasswordViewController *changeVC = [[ChangePasswordViewController alloc]init];
            //            [self.navigationController pushViewController:changeVC animated:YES];
            //            self.tabBarController.tabBar.hidden = YES;
            //        }
            
            break;
            
        case 3:
        {
            
            
            if (files.count != 0) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                    for (NSString *p in files) {
                        NSError *error ;
                        NSString *path = [cachPath stringByAppendingPathComponent:p];
                        if ([[NSFileManager defaultManager]fileExistsAtPath:path])
                        {
                            [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                        }
                    }
                    [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
                });
            }else
            {
                UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"\n没有缓存文件，无需清理" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alter show];
            }
            
            
        }
            
            break;
            
        case 4:
        {
            UserProtolViewController *upvc =[[UserProtolViewController alloc]init];
            [self.navigationController pushViewController:upvc animated:YES];
            self.tabBarController.tabBar.hidden = YES;
        }
            break;
            
        default:
        {
            AboutViewController *aboutVC = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:aboutVC animated:YES];
            self.tabBarController.tabBar.hidden = YES;
            
        }
            
            break;
    }
    
    
}

- (void)clearCacheSuccess
{
    [setTableView reloadData];
    NSString *st = [NSString stringWithFormat:@"\n操作成功！共清理%.2fM缓存文件", fileSize];
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:st delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];
}


//登陆
-(void)createLoginView{
    
    loginView = [[UIView alloc] initWithFrame:self.view.frame];
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    //    [self createNotification];
    [self createLoginView1];
    
    
}



-(void)createLoginView1
{
    // 创建导航左侧按钮
    [self createLeftorRightButton];
    [self createTextField];
    [self createLogInButton];
    [self createBackPasswordUnderLine];
    
}


-(void)createLeftorRightButton
{
    //    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    //    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UIButton *rightButton = [ZYControl createButtonWithFrame:CGRectMake(280, 0, 32, 320) ImageName:nil Target:self Action:@selector(rightButtonClick:) Title:@"注册"];
    [rightButton setTitleColor:[AOColorFormat colorWithHexString:@"666666"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)rightButtonClick:(UIButton *)rightButton
{
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
    
}
-(void)createTextField
{
    
    
    userNameTextField = [ZYControl createTextFieldWithFrame:CGRectMake(15,114*RATIOTYPE_HEIGHT+64,kScreenWidth-30,60*RATIOTYPE_HEIGHT) placeholder:@"请输入手机号" passWord:NO leftImageView:nil rightImageView:nil Font:17];
    userNameTextField.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9d"].CGColor;
    [loginView addSubview:userNameTextField];
    
    
    UIView *viewBoundray =[[UIView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(userNameTextField.frame)+20*RATIOTYPE_HEIGHT,kScreenWidth-30,1*RATIOTYPE_HEIGHT)];
    viewBoundray.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    viewBoundray.alpha = 0.5;
    [loginView addSubview:viewBoundray];
    
    
    //输入密码
    passWordTextField = [ZYControl createTextFieldWithFrame:CGRectMake(15,CGRectGetMaxY(viewBoundray.frame)+30*RATIOTYPE_HEIGHT, kScreenWidth-30,60*RATIOTYPE_HEIGHT) placeholder:@"请输入密码" passWord:NO leftImageView:nil rightImageView:nil Font:17];
    passWordTextField.secureTextEntry = YES;
    passWordTextField.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
    [loginView addSubview:passWordTextField];
    
    
    viewBoundray1 =[[UIView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(viewBoundray.frame)+104*RATIOTYPE_HEIGHT, kScreenWidth-30, 1*RATIOTYPE_HEIGHT)];
    viewBoundray1.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    viewBoundray1.alpha = 0.5;
    [loginView addSubview:viewBoundray1];
    
}
//创建登录按钮
-(void)createLogInButton
{
    logInButton = [ZYControl createButtonWithFrame:CGRectMake(15,CGRectGetMaxY(viewBoundray1.frame)+100*RATIOTYPE_HEIGHT,kScreenWidth-30,100*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:@selector(logInButtonClick:) Title:@"登录"];
    logInButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    logInButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [loginView addSubview:logInButton];
    
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
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_loginString forKey:@"client_id"];
        [userDefault synchronize];
        //        NSLog(@"%@",sin.string);
        
        NSNumber *codeNum = responseObject[@"code"];
        if ([codeNum integerValue] == 100) {
            //            AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
            //            [appdelegate setTabAsRootController];
            //跳转界面
            [loginView removeFromSuperview];
            titleLable.text = @"个人中心";
            self.navigationItem.rightBarButtonItem = nil;
            [self createUserCenter];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        NSLog(@"%@",responseObject);
        
        NSString *string = responseObject[@"message"];
        NSLog(@"%@",string);
        
        //        NSString * username = userNameTextField.text;
        //        NSString * password = passWordTextField.text;
        //        NSUserDefaults * userDefaults =  [NSUserDefaults standardUserDefaults];
        //        [userDefaults setObject:username forKey:@"username"];
        //        [userDefaults setObject:password forKey:@"password"];
        //        [userDefaults synchronize];
        
        
        
        
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
    [loginView addSubview:rlabel];
    
}

#pragma mark - RLabelDelegate
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url{
    FindPassWordViewController *fvc = [[FindPassWordViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [loginView endEditing:YES];
}




@end
