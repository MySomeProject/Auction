//
//  PatProduceDetailViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/6/30.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "PatProduceDetailViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "PatProduceDetailModel.h"
#import "OfferPriceRecordViewController.h"
#import "ServeGuaranteeViewController.h"
#import "GoodsNumberViewController.h"
#import "SubmitSecurityPaymentsViewController.h"
#import "AuctionPatViewController.h"
#import "FreezeSecurityDepositViewController.h"
#import "LogInViewController.h"
/****************更改********************/
#import "LogInViewController.h"
#import "UserProtolViewController.h"
#import "AuctionRuleViewController.h"
#import "LogInViewController.h"
#import "PatProductListViewController.h"
#import "RegisterViewController.h"
#import "RTLabel.h"
#import "FindPassWordViewController.h"
#import "MJRefresh.h"

@interface PatProduceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,RTLabelDelegate>
{
    UITableView *_newTableView;
    NSMutableArray *_dataArray;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSTimer *timer;
    NSDictionary *goodsDict;
    NSArray *good_imageArray;
    BOOL isTapAgain;
    UIView *view;
    //存储保证金
    NSString *depositString;
    NSArray *offerDataArray;
    //竞拍创建透明度
    UIView *bgView;
    NSString * title ;
    UITextField *placeField;
    
    //时间
    UILabel *timeLable;
    UILabel *displayTime;
    //创建时间lable
    UILabel *hourLable;
    UILabel *minuteLable;
    UILabel *secondLable;
    //        NSTimer *timer;
    int countNum;
    int number;
    int minCount;
    int hourCount;
    int min;
    int hour;
    
    UIView *cyanView;          //头部视图
    UIButton *bottomButton;   //提交保证金按钮
    
    
    //拍品详情
    UIView * bottomView;
    
    UILabel * titleLable;
    UIButton * registerBtn;
    UIImageView *LeftButtonImage;
    UIImageView *RightButtonImage;
    UITextField *userNameTextField;
    UITextField *passWordTextField;
    UIButton *logInButton;
    UIView *viewBoundray1;
    
    
    //登录界面
    UIView * loginView;
    //出价记录
    UILabel *recordLabel;
    
    
}
@property(nonatomic,retain)NSTimer *timeTimer;
@end

@implementation PatProduceDetailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
        goodsDict = [[NSDictionary alloc]init];
        good_imageArray = [[NSArray alloc]init];
        offerDataArray = [[NSArray alloc]init];
        
    }
    return self;
}



- (void)viewDidLoad {
    
    [self createNav];
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
        
        //拍品详情
        [self createUserCenter];
        [self createNav];
        
    }
}

-(void)createTitleView{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick1:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
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
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick1:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    UILabel * titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    titleLable1.textColor = [UIColor blackColor];
    titleLable1.font = [UIFont boldSystemFontOfSize:20];
    titleLable1.text = @"我的拍卖";
    self.navigationItem.titleView = titleLable1;
}

-(void)registerBtnClick
{
    
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}

//拍品详情
-(void)createUserCenter
{
    bottomView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:bottomView];
    
    NSLog(@"%@",_strID);
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    [self createTableView];
    [self createPatProduceDetailData];
    
    [self createTabItemLeftButton];
    [self createBottomButton];
    
    [self createHeaderView];
}


-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick1:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    //分享按钮
    UIButton *shareButton = [ZYControl createButtonWithFrame:CGRectMake(300*RATIOTYPE_WIDTH, 24,46*RATIOTYPE_WIDTH,37*RATIOTYPE_HEIGHT) ImageName:@"分享@2x.png" Target:self Action:@selector(shareButtonClick:) Title:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
}
-(void)leftButtonClick1:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
    //    PatProductListViewController *pvcc = [[PatProductListViewController alloc] init];
    //    [self.navigationController popToViewController:pvcc animated:YES];
}
-(void)shareButtonClick:(UIButton *)shareButton
{
    
    
    
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:bgView];
    UIControl *bgControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [bgControl addTarget:self action:@selector(bgControlClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgControl];
    
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenWidth,0,310*RATIOTYPE_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:view];
    [UIView animateWithDuration:0.3 animations:^{
        
        view.frame = CGRectMake(60*RATIOTYPE_WIDTH, (kScreenHeight-310*RATIOTYPE_HEIGHT)/2, kScreenWidth -120*RATIOTYPE_WIDTH, 310*RATIOTYPE_HEIGHT);
        
        
    } completion:^(BOOL finished) {
        
        //朋友圈分享
        UILabel *titleLabel = [ZYControl createLabelWithFrame:CGRectMake(250*RATIOTYPE_WIDTH,30*RATIOTYPE_HEIGHT,100*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT) Font:20 Text:@"分享"];
        titleLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [view addSubview:titleLabel];
        
        UIButton *friendBtn = [ZYControl createButtonWithFrame:CGRectMake(100*RATIOTYPE_WIDTH, 130*RATIOTYPE_HEIGHT,119*RATIOTYPE_WIDTH,117*RATIOTYPE_HEIGHT) ImageName:@"朋友圈@2x.png" Target:self Action:@selector(friendBtnClick:) Title:nil];
        [view addSubview:friendBtn];
        
        UILabel *downLabel = [ZYControl createLabelWithFrame:CGRectMake(110*RATIOTYPE_WIDTH,CGRectGetMaxY(friendBtn.frame),150*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT) Font:17 Text:@"朋友圈"];
        downLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [view addSubview:downLabel];
        //微信分享
        UIButton *weiBtn=  [ZYControl createButtonWithFrame:CGRectMake(580*RATIOTYPE_WIDTH-170*RATIOTYPE_WIDTH, 130*RATIOTYPE_HEIGHT, 119*RATIOTYPE_WIDTH, 117*RATIOTYPE_HEIGHT) ImageName:@"微信1@2x.png" Target:self Action:@selector(weiBtnClick:) Title:nil];
        [view addSubview:weiBtn];
        
        UILabel *weiLabel = [ZYControl createLabelWithFrame:CGRectMake(435*RATIOTYPE_WIDTH,CGRectGetMaxY(weiBtn.frame),150*RATIOTYPE_WIDTH, 60*RATIOTYPE_HEIGHT) Font:17 Text:@"微信"];
        weiLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [view addSubview:weiLabel];
        
    }];
    
    
    
}

-(void)bgControlClick
{
    [bgView removeFromSuperview];
    
}

-(void)friendBtnClick:(UIButton *)friendBtn
{
    NSString * strurl = [NSString stringWithFormat:@"http://share.luxji.com/index.php?con=share&act=detail&auctionid=%@",_strID];
    for (PatProduceDetailModel *model in _dataArray) {
        title = model.good_name;
    }
    NSLog(@"%@",title);
    NSString * image = [NSString stringWithFormat:@"2.png"];
    NSString * description = [NSString stringWithFormat:@"拍品详情"];
    
    
    NSDictionary * dic = @{@"title":title,
                           @"webUrl":strurl,
                           @"description":description,
                           @"image":image};
    
    [YYHongShare YYHongWeiXinShare:dic type:1];
    
}

-(void)weiBtnClick:(UIButton *)weiBtn
{
    
    NSString * strurl = [NSString stringWithFormat:@"http://share.luxji.com/index.php?con=share&act=detail&auctionid=%@",_strID];
    for (PatProduceDetailModel *model in _dataArray) {
        title = model.good_name;
    }
    NSLog(@"%@",title);
    NSString * image = [NSString stringWithFormat:@"2.png"];
    NSString * description = [NSString stringWithFormat:@"拍品详情"];
    
    
    NSDictionary * dic = @{@"title":title,
                           @"webUrl":strurl,
                           @"description":description,
                           @"image":image};
    
    [YYHongShare YYHongWeiXinShare:dic type:0];
    
}

-(void)createBottomButton
{
    if ([self.typeString isEqualToString:@"2"]) {
        bottomButton = [ZYControl createButtonWithFrame:CGRectMake(0, kScreenHeight-130*RATIOTYPE_HEIGHT, kScreenWidth,130*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:@selector(bottomButtonClick) Title:@"提交保证金参与竞拍"];
        bottomButton.titleLabel.font = [UIFont systemFontOfSize:17];
        bottomButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
        [bottomView addSubview:bottomButton];
    }
    
}
-(void)bottomButtonClick
{
    
    if (bottomButton.selected == NO) {
        
        for (PatProduceDetailModel *model in _dataArray) {
            
            
            UIAlertView *alview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"提交保证金%@",model.good_deposit] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alview show];
            
            bottomButton.selected = YES;
        }
    }else{
        bottomButton.selected = NO;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        //        if ([user objectForKey:@"client_id"] == nil) {
        //            LogInViewController *lvc = [[LogInViewController alloc]init];
        //            [self.navigationController pushViewController:lvc animated:YES];
        //        }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=setDeposit";
        NSDictionary *parameters = @{@"client_id":[user objectForKey:@"client_id"]};
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            depositString = responseObject[@"data"];
            NSLog(@"%@",depositString);
            
            /////////////////////////////////////////////////////////////////////////////////
            
            UILabel *ensureLabel = (UILabel *)[view viewWithTag:300];
            if ([depositString integerValue] > [ensureLabel.text integerValue]) {
                
                SubmitSecurityPaymentsViewController *sspvc = [[SubmitSecurityPaymentsViewController alloc]init];
                for (PatProduceDetailModel *model in _dataArray) {
                    sspvc.goods_nameStr = model.good_name;
                    sspvc.goods_priceStr = model.good_price;
                    sspvc.despositStr = model.good_deposit;
                }
                [self.navigationController pushViewController:sspvc animated:YES];
                
            }else{
                SubmitSecurityPaymentsViewController *sspvc = [[SubmitSecurityPaymentsViewController alloc]init];
                
                for (PatProduceDetailModel *model in _dataArray) {
                    sspvc.goods_nameStr = model.good_name;
                    sspvc.goods_priceStr = model.good_price;
                    sspvc.despositStr = model.good_deposit;
                    sspvc.auction_ID = _strID;
                }
                
                [self.navigationController pushViewController:sspvc animated:YES];
                //            FreezeSecurityDepositViewController *fvc = [[FreezeSecurityDepositViewController alloc]init];
                //            [self.navigationController pushViewController:fvc animated:NO];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    //    }
}


#pragma mark --UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        PatProduceDetailModel *model = [_dataArray objectAtIndex:0];
        
        if ([model.end_time doubleValue] > [model.auct_time doubleValue]){
            //结束提醒按钮
            UIButton *endRemindButton = [ZYControl createButtonWithFrame:CGRectMake(kScreenWidth/2+140/375.0*kScreenWidth,245/667.0*kScreenHeight, 25/375.0*kScreenWidth, 25/667.0*kScreenHeight) ImageName:@"结束提醒灰@2x.png" Target:self  Action:@selector(endRemindButtonClick:) Title:nil];
            [cyanView addSubview:endRemindButton];
            
            UILabel *endRemindLable = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth/2+120/375.0*kScreenWidth, 270/667.0*kScreenHeight, 80/375.0*kScreenWidth, 20/667.0*kScreenHeight) Font:13 Text:@"结束提醒"];
            endRemindLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
            [cyanView addSubview:endRemindLable];
            //竞拍按钮
            UIButton *patButton = [ZYControl createButtonWithFrame:CGRectMake(kScreenWidth/2+100/375.0*kScreenWidth, 290/667.0*kScreenHeight, 80/375.0*kScreenWidth,30/667.0*kScreenHeight) ImageName:nil Target:self Action:@selector(patButtonClick:) Title:@"竞拍"];
            patButton.tag = 600;
            [patButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            patButton.titleLabel.font = [UIFont systemFontOfSize:14];
            patButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
            [cyanView addSubview:patButton];
        }else if ([model.start_time doubleValue] > [model.auct_time doubleValue]){
            if ([model.start_time doubleValue] - [model.auct_time doubleValue] == 0) {
                //结束提醒按钮
                UIButton *endRemindButton = [ZYControl createButtonWithFrame:CGRectMake(kScreenWidth/2+140/375.0*kScreenWidth,245/667.0*kScreenHeight, 25/375.0*kScreenWidth, 25/667.0*kScreenHeight) ImageName:@"结束提醒灰@2x.png" Target:self  Action:@selector(endRemindButtonClick:) Title:nil];
                [cyanView addSubview:endRemindButton];
                
                UILabel *endRemindLable = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth/2+120/375.0*kScreenWidth, 270/667.0*kScreenHeight, 80/375.0*kScreenWidth, 20/667.0*kScreenHeight) Font:13 Text:@"结束提醒"];
                endRemindLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
                [cyanView addSubview:endRemindLable];
                //竞拍按钮
                UIButton *patButton = [ZYControl createButtonWithFrame:CGRectMake(kScreenWidth/2+100/375.0*kScreenWidth, 290/667.0*kScreenHeight, 80/375.0*kScreenWidth,30/667.0*kScreenHeight) ImageName:nil Target:self Action:@selector(patButtonClick:) Title:@"竞拍"];
                patButton.tag = 600;
                [patButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
                patButton.titleLabel.font = [UIFont systemFontOfSize:14];
                patButton.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
                [cyanView addSubview:patButton];
                
            }
        }
        
        
    }
}


-(void)createTableView
{
    
    _newTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _newTableView.delegate =self;
    _newTableView.dataSource = self;
    [self ZYrefresh];
    [bottomView addSubview:_newTableView];
    
}
//创建头部视图
-(void)createHeaderView
{
    cyanView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth,900*RATIOTYPE_HEIGHT)];
    //        cyanView.backgroundColor = [UIColor cyanColor];
    
    //创建滚动视图
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,400*RATIOTYPE_HEIGHT)];
    //    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    //设置翻页滚动
    scrollView.pagingEnabled = YES;
    //消除弹性，禁止边界回弹效果
    scrollView.bounces = NO;
    [cyanView addSubview:scrollView];
    /**************创建头部数组*************/
    for (int index = 0; index < good_imageArray.count; index++) {
        //        NSLog(@"%@",good_imageArray);
        UIImageView *headerImageView = [[UIImageView alloc] init];
        headerImageView.frame = CGRectMake(kScreenWidth*(index), 0,kScreenWidth,220/667.0*kScreenHeight);
        
        if (good_imageArray.count == 0) {
            headerImageView.image = [UIImage imageNamed:@"750*690-01(商品详情页banner图).png"];
        }else{
            
            [headerImageView sd_setImageWithURL:[NSURL URLWithString:good_imageArray[index]]];
            
        }
        
        [scrollView addSubview:headerImageView];
        
    }
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth/2-30*RATIOTYPE_WIDTH,350*RATIOTYPE_HEIGHT,60*RATIOTYPE_WIDTH,20*RATIOTYPE_HEIGHT)];
    //一共有多少个小白点
    pageControl.numberOfPages = 2;
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [cyanView addSubview:pageControl];
    
    timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _newTableView.tableHeaderView = cyanView;
    
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 40/667.0*kScreenHeight, 130/375.0*kScreenWidth,80/667.0*kScreenHeight)];
    [cyanView addSubview:redView];
    
    
    if ([self.typeString isEqualToString:@"2"]) {
        timeLable = [ZYControl createLabelWithFrame:CGRectMake(10/375.0*kScreenWidth,5/667.0*kScreenHeight, 112/375.0*kScreenWidth, 20/667.0*kScreenHeight) Font:10 Text:nil];
        timeLable.textColor = [UIColor blackColor];
        timeLable.font = [UIFont systemFontOfSize:16];
        [redView addSubview:timeLable];
        
        
        ////        for (PatProduceDetailModel *model in _dataArray) {
        ////            NSLog(@"%@",_dataArray);
        //            displayTime = [ZYControl createLabelWithFrame:CGRectMake(10/375.0*kScreenWidth, 16/667.0*kScreenHeight, 112/375.0*kScreenWidth, 25/667.0*kScreenHeight) Font:14 Text:nil];
        ////            NSLog(@"%@",model.showTime);
        //            displayTime.textColor =[UIColor blackColor];
        //            [redView addSubview:displayTime];
        ////        }
        //
        UIImageView *rightDownImageView = [ZYControl createImageViewWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT,232*RATIOTYPE_WIDTH, 55*RATIOTYPE_HEIGHT) ImageName:@"倒计时@3x.png"];
        [redView addSubview:rightDownImageView];
        
        hourLable = [ZYControl createLabelWithFrame:CGRectMake(5*RATIOTYPE_WIDTH,1*RATIOTYPE_HEIGHT, 70*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        hourLable.textAlignment =NSTextAlignmentCenter;
        [rightDownImageView addSubview:hourLable];
        
        minuteLable = [ZYControl createLabelWithFrame:CGRectMake(85*RATIOTYPE_WIDTH,1*RATIOTYPE_HEIGHT, 70*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        minuteLable.textAlignment = NSTextAlignmentCenter;
        [rightDownImageView addSubview:minuteLable];
        secondLable = [ZYControl createLabelWithFrame:CGRectMake(165*RATIOTYPE_WIDTH, 1*RATIOTYPE_HEIGHT, 70*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        secondLable.textAlignment = NSTextAlignmentCenter;
        [rightDownImageView addSubview:secondLable];
        
        
        
    }
    
    //创建分界线
    UIView *boundaryView = [[UIView alloc]initWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,400*RATIOTYPE_HEIGHT, kScreenWidth-20*RATIOTYPE_WIDTH,1*RATIOTYPE_HEIGHT)];
    boundaryView.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
    [cyanView addSubview:boundaryView];
    
    
    UILabel *upLable = [ZYControl createLabelWithFrame:CGRectMake(15*RATIOTYPE_WIDTH,430*RATIOTYPE_HEIGHT,500*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT) Font:14 Text:[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"good_name"]]];
    //    upLable.lineBreakMode = UILineBreakModeWordWrap;
    upLable.numberOfLines = 2;
    upLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    upLable.numberOfLines = 2;
    [cyanView addSubview:upLable];
    
    //当前价lable
    UILabel *currentPriceLabel = [ZYControl createLabelWithFrame:CGRectMake(15*RATIOTYPE_WIDTH,540*RATIOTYPE_HEIGHT,150*RATIOTYPE_WIDTH,30*RATIOTYPE_HEIGHT) Font:14 Text:@"当前价："];
    currentPriceLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:currentPriceLabel];
    UILabel *priceLabel = [ZYControl createLabelWithFrame:CGRectMake(120*RATIOTYPE_WIDTH,530*RATIOTYPE_HEIGHT,120*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:14 Text:[NSString stringWithFormat:@"¥ %@",[goodsDict objectForKey:@"good_price"]]];
    priceLabel.tag = 101;
    priceLabel.textColor = [AOColorFormat colorWithHexString:@"ff0000"];
    [cyanView addSubview:priceLabel];
    //送拍机构名称
    UILabel *nameLabel = [ZYControl createLabelWithFrame:CGRectMake(15*RATIOTYPE_WIDTH,570*RATIOTYPE_HEIGHT,120*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:@"送拍机构名称"];
    nameLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:nameLabel];
    //8人竞拍 10次竞拍
    UILabel *eightLable =[ZYControl createLabelWithFrame:CGRectMake(15*RATIOTYPE_WIDTH,CGRectGetMaxY(nameLabel.frame),100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:[NSString stringWithFormat:@"%@人竞拍",[goodsDict objectForKey:@"good_auctionpepoles"]]];
    eightLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:eightLable];
    UILabel *tenLabel = [ZYControl createLabelWithFrame:CGRectMake(100*RATIOTYPE_WIDTH,CGRectGetMaxY(nameLabel.frame),100*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:12 Text:[NSString stringWithFormat:@"%@次竞拍",[goodsDict objectForKey:@"good_auctiontimes"]]];
    tenLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:tenLabel];
    //保证金
    UILabel *ensureLabel = [ZYControl createLabelWithFrame:CGRectMake(15*RATIOTYPE_WIDTH,CGRectGetMaxY(tenLabel.frame)+50*RATIOTYPE_HEIGHT,100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:@"保证金 "];
    ensureLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:ensureLabel];
    //保证金价格
    UILabel *ensurePriceLabel = [ZYControl createLabelWithFrame:CGRectMake(100*RATIOTYPE_WIDTH,CGRectGetMaxY(tenLabel.frame)+50*RATIOTYPE_HEIGHT,100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:[NSString stringWithFormat:@"¥ %@",[goodsDict objectForKey:@"good_deposit"]]];
    ensurePriceLabel.tag = 300;
    ensurePriceLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [cyanView addSubview:ensurePriceLabel];
    //起拍价
    UILabel *beginPatPriceLabel = [ZYControl createLabelWithFrame:CGRectMake(15*RATIOTYPE_WIDTH,CGRectGetMaxY(ensurePriceLabel.frame),100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:@"起拍价"];
    beginPatPriceLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView  addSubview:beginPatPriceLabel];
    UILabel *beginPrice = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(beginPatPriceLabel.frame),CGRectGetMaxY(ensurePriceLabel.frame),100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:[NSString stringWithFormat:@"¥ %@",[goodsDict objectForKey:@"good_price"]]];
    beginPrice.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [cyanView addSubview:beginPrice];
    //加价幅度
    UILabel *rangeLabel = [ZYControl createLabelWithFrame:CGRectMake(300*RATIOTYPE_WIDTH, CGRectGetMaxY(tenLabel.frame)+50*RATIOTYPE_HEIGHT,100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:@"加价幅度"];
    rangeLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:rangeLabel];
    UILabel *rangePriceLabel = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(rangeLabel.frame), CGRectGetMaxY(tenLabel.frame)+50*RATIOTYPE_HEIGHT,100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:[NSString stringWithFormat:@"¥ %@",[goodsDict objectForKey:@"good_rangeprice"]]];
    rangePriceLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [cyanView addSubview:rangePriceLabel];
    //延时周期
    UILabel *timedelayLabel = [ZYControl createLabelWithFrame:CGRectMake(300*RATIOTYPE_WIDTH, CGRectGetMaxY(ensurePriceLabel.frame),100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:@"延时周期"];
    timedelayLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:timedelayLabel];
    UILabel *timedelayPriceLabel =[ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(timedelayLabel.frame)+5*RATIOTYPE_WIDTH, CGRectGetMaxY(ensurePriceLabel.frame), 120*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:[NSString stringWithFormat:@"%@分钟／次",[goodsDict objectForKey:@"good_timedelay"]]];
    timedelayPriceLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [cyanView addSubview:timedelayPriceLabel];
    //保留价
    UILabel *reservePriceLabel = [ZYControl createLabelWithFrame:CGRectMake(15*RATIOTYPE_WIDTH,CGRectGetMaxY(beginPatPriceLabel.frame),100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:@"保留价"];
    reservePriceLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
    [cyanView addSubview:reservePriceLabel];
    UILabel *reserveLabel = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(reservePriceLabel.frame)+5*RATIOTYPE_WIDTH,CGRectGetMaxY(beginPatPriceLabel.frame),100*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:12 Text:[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"good_reserveprice"]]];
    reserveLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
    [cyanView addSubview:reserveLabel];
    
}

-(void)nextImage
{
    // 1.下一页
    if (pageControl.currentPage == 1) {
        pageControl.currentPage = 0;
    } else {
        pageControl.currentPage++;
    }
    
    // 2.设置滚动
    CGPoint offset = CGPointMake(scrollView.frame.size.width * pageControl.currentPage, 0);
    
    [scrollView setContentOffset:offset animated:YES];
}

//竞拍
-(void)patButtonClick:(UIButton *)patButton
{
    //    AuctionPatViewController *avc = [[AuctionPatViewController alloc]init];
    //    [self.navigationController pushViewController:avc animated:NO];
    //    NSLog(@"***********************");
    //创建透明度
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight,kScreenWidth,390*RATIOTYPE_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:view];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        view.frame = CGRectMake(0,kScreenHeight-390*RATIOTYPE_HEIGHT,kScreenWidth,390*RATIOTYPE_HEIGHT);
        
        
    } completion:^(BOOL finished) {
        UILabel *titleLabel = [ZYControl createLabelWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT, 200*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:16 Text:@"请输入报价 ："];
        titleLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [view addSubview:titleLabel];
        
        
        
        UILabel *backLabel = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth-60*RATIOTYPE_WIDTH-340*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT, 340*RATIOTYPE_WIDTH, 72*RATIOTYPE_HEIGHT) Font:10 Text:nil];
        backLabel.layer.borderWidth =1;
        backLabel.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
        backLabel.userInteractionEnabled = YES;
        [view addSubview:backLabel];
        
        //减法
        UIButton *subButton = [ZYControl createButtonWithFrame:CGRectMake(10*RATIOTYPE_WIDTH,30*RATIOTYPE_HEIGHT,58*RATIOTYPE_WIDTH, 15*RATIOTYPE_HEIGHT) ImageName:@"减号@2x.png" Target:self Action:@selector(subButtonClick:) Title:nil];
        [backLabel addSubview:subButton];
        
        //输入框
        placeField = [ZYControl createTextFieldWithFrame:CGRectMake(CGRectGetMaxX(subButton.frame)+10*RATIOTYPE_WIDTH,0, 196*RATIOTYPE_WIDTH, 72*RATIOTYPE_HEIGHT) placeholder:nil passWord:NO leftImageView:nil rightImageView:nil Font:16];
        placeField.tag = 100;
        placeField.borderStyle = UITextBorderStyleLine;
        placeField.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
        [backLabel addSubview:placeField];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
        
        //加法
        UIButton *addButton = [ZYControl createButtonWithFrame:CGRectMake(CGRectGetMaxX(placeField.frame)+10*RATIOTYPE_WIDTH,10*RATIOTYPE_HEIGHT, 50*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) ImageName:@"加号@2x.png" Target:self Action:@selector(addButtonClick:) Title:nil];
        [backLabel addSubview:addButton];
        
        UILabel *rangeLabel = [ZYControl createLabelWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, CGRectGetMaxY(titleLabel.frame)+50*RATIOTYPE_HEIGHT, 400*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:16 Text:[NSString stringWithFormat:@"当前加价幅度为￥"]];
        rangeLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [view addSubview:rangeLabel];
        
        UILabel *rangePriceLabel = [ZYControl createLabelWithFrame:CGRectMake(250*RATIOTYPE_WIDTH, CGRectGetMaxY(titleLabel.frame)+50*RATIOTYPE_HEIGHT, 200*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:16 Text:[NSString stringWithFormat:@" %@",_good_rangepriceStr]];
        rangePriceLabel.tag = 200;
        rangePriceLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [view addSubview:rangePriceLabel];
        
        UIView *boundaryView = [[UIView alloc]initWithFrame:CGRectMake(0, 290*RATIOTYPE_HEIGHT, kScreenWidth, 1*RATIOTYPE_HEIGHT)];
        boundaryView.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
        [view addSubview:boundaryView];
        
        UIButton *offerButton = [ZYControl createButtonWithFrame:CGRectMake(60*RATIOTYPE_WIDTH, CGRectGetMaxY(boundaryView.frame)+30*RATIOTYPE_HEIGHT, 200*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:@selector(offerButtonClick:) Title:@"报价竞拍"];
        offerButton.tag = 400;
        offerButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [offerButton setTitleColor:[AOColorFormat colorWithHexString:@"c70065"] forState:UIControlStateNormal];
        
        [view addSubview:offerButton];
        
        UIView *limitView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(boundaryView.frame)+20*RATIOTYPE_HEIGHT, 1*RATIOTYPE_WIDTH, 60*RATIOTYPE_HEIGHT)];
        limitView.backgroundColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
        [view addSubview:limitView];
        
        UIButton *cancelButton = [ZYControl createButtonWithFrame:CGRectMake(CGRectGetMaxX(limitView.frame)+120*RATIOTYPE_WIDTH, CGRectGetMaxY(boundaryView.frame)+30*RATIOTYPE_HEIGHT, 100*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) ImageName:nil Target:nil Action:@selector(cancelButtonClick:) Title:@"取消"];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton setTitleColor:[AOColorFormat colorWithHexString:@"808080"] forState:UIControlStateNormal];
        [view addSubview:cancelButton];
        
    }];
}

-(void)keyboardWillShow:(NSNotification*)anotification
{
    
    NSDictionary * userInfo = [anotification userInfo];
    NSValue * avalue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboard = [avalue CGRectValue];
    NSInteger aheight = keyboard.size.height;
    NSLog(@"键盘高度%ld",aheight);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        view.frame=CGRectMake(0, -aheight+kScreenHeight-390*RATIOTYPE_HEIGHT, kScreenWidth, kScreenHeight);
    }];
    
}


-(void)keyboardWillHide
{
    
    view.frame = CGRectMake(0,kScreenHeight-390*RATIOTYPE_HEIGHT,kScreenWidth,390*RATIOTYPE_HEIGHT);
    
}

//减法
-(void)subButtonClick:(UIButton *)subBtn
{
    UITextField *subfield = (UITextField *)[view viewWithTag:100];
    UILabel *subLabel = (UILabel *)[view viewWithTag:200];
    NSInteger count = 0;
    count = [subfield.text intValue];
    count-=[_good_rangepriceStr intValue];
    if (count <= [subLabel.text integerValue]) {
        NSLog(@"%@",subLabel.text);
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"竞价过低" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alView show];
        return;
    }
    subfield.text = [NSString stringWithFormat:@"%ld",count];
    
}
//加法
-(void)addButtonClick:(UIButton *)addBtn
{
    UITextField *addfield = (UITextField *)[view viewWithTag:100];
    static NSInteger count = 0;
    count = [addfield.text intValue];
    count+=[_good_rangepriceStr intValue];
    addfield.text = [NSString stringWithFormat:@"%ld",count ];
    
}
//报价竞拍
-(void)offerButtonClick:(UIButton *)offerBtn
{
    if (offerBtn.selected == NO) {
        //        [offerBtn setTitleColor:[AOColorFormat colorWithHexString:@"c70065"] forState:UIControlStateNormal];
        [offerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        [self createOfferData];
        
        offerBtn.selected = YES;
    }else{
        //                [offerBtn setTitleColor:[AOColorFormat colorWithHexString:@"c70065"] forState:UIControlStateNormal];
        
        //   [offerBtn setTitleColor:[AOColorFormat colorWithHexString:@"9f0051"] forState:UIControlStateSelected];
        offerBtn.selected = NO;
        //     [offerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    }
    
}
//取消
-(void)cancelButtonClick:(UIButton *)cancelBtn
{
    bgView.frame = CGRectMake(0, 0, 0, 0);
    view.frame = CGRectMake(0,kScreenHeight, 0, 0);
    
}


- (void)ZYrefresh
{
    
    [_newTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [_newTableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [_newTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
   
    [_newTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    
    // 马上进入刷新状态
    [_newTableView.gifHeader beginRefreshing];
    
    
}

#pragma mark - 数据处理相关
/**
 * 下拉刷新数据
 */
-(void)loadNewData
{
    if (_dataArray.count!=0) {
        [_dataArray removeAllObjects];
    }
    [timer invalidate];
    
    [self createPatProduceDetailData];
    
}

//数据请求
-(void)createPatProduceDetailData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //    if ([user objectForKey:@"client_id"] == nil) {
    //        LogInViewController *lvc = [[LogInViewController alloc]init];
    //        [self.navigationController pushViewController:lvc animated:YES];
    //    }else{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getAuctionDetail";
    //    NSLog(@"%@",sin.string);
    NSDictionary *parameters = @{@"auctionid":_strID,@"client_id":[user objectForKey:@"client_id"]};
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictData = responseObject[@"data"];
        NSLog(@"%@",dictData);
        good_imageArray = [dictData objectForKey:@"good_image"];
        goodsDict = [dictData objectForKey:@"goods"];
        //出价记录数据
        
        offerDataArray = [dictData objectForKey:@"bid_record"];
        
        NSLog(@"%@",offerDataArray);
        
        PatProduceDetailModel *model = [[PatProduceDetailModel alloc]init];
        model.good_name = [goodsDict objectForKey:@"good_name"];
        model.good_price = [goodsDict objectForKey:@"good_price"];
        model.good_deposit = [goodsDict objectForKey:@"good_deposit"];
        model.good_rangeprice = [goodsDict objectForKey:@"good_rangeprice"];
        _good_rangepriceStr = model.good_rangeprice;
        model.start_time = [goodsDict objectForKey:@"start_time"];
        model.end_time = [goodsDict objectForKey:@"end_time"];
        model.auct_time = [NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"auct_time"]];
        
        if ([model.start_time doubleValue] > [model.auct_time doubleValue]) {
            
            timeLable.text = @"今日开拍时间";
            hourLable.text = @"10";
            minuteLable.text = @"00";
            secondLable.text = @"00";
            
            //                double _interval = [model.start_time doubleValue] -[model.auct_time doubleValue];
            //                NSString *timeStampString = [NSString stringWithFormat:@"%f",_interval];
            //                NSTimeInterval _interval2 = [timeStampString doubleValue];
            //                NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval2];
            //                NSDateFormatter *objDateFormat = [[NSDateFormatter alloc]init];
            //                [objDateFormat setDateFormat:@"HH:mm:ss"];
            //                model.showTime = [objDateFormat stringFromDate:date];
            
        }else if ([model.end_time doubleValue] > [model.auct_time doubleValue]){
            timeLable.text = @"距离结束时间";
            double _interval = [model.end_time doubleValue] - [model.auct_time doubleValue];
            NSString * timeStampString = [NSString stringWithFormat:@"%f",_interval];
            NSTimeInterval _interval1=[timeStampString doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval1];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:@"HH:mm:ss"];
            model.showTime = [objDateformat stringFromDate: date];
            NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@" :"] ;
            NSArray * array1 = [model.showTime componentsSeparatedByCharactersInSet:set];
            hourLable.text = array1[0];
            minuteLable.text = array1[1];
            secondLable.text = array1[2];
            
            //        static  int count;
            for (int i = 0; i<array1.count; i++) {
                if (i == 0) {
                    number  = [array1[0] intValue]*60*60;
                }else if (i == 1)
                {
                    number += [array1[1]intValue]*60;
                }
                else if (i == 2)
                {
                    number += [array1[2]intValue];
                }
            }
            
            self.timeTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:self.timeTimer forMode:NSRunLoopCommonModes];
            countNum = [secondLable.text intValue];
            min = [minuteLable.text intValue];
            hour = [hourLable.text intValue];
        }
        
        
        
        [_dataArray addObject:model];
        //            [self createHeaderView];
        
        [_newTableView reloadData];
        [_newTableView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    //    }
}

-(void)timeFireMethod{
    secondLable.text = [NSString stringWithFormat:@"%02d",countNum-1];
    countNum--;
    if (min == 0&&hour==0) {
        if (countNum == 0) {
            [self.timeTimer invalidate];
        }
    }
    
    if (hour == 0&&min!=0) {
        if (countNum == 0) {
            countNum = 60;
            //            [self timeFireMethod];
            minuteLable.text  = [NSString stringWithFormat:@"%02d",min-1];
            if (min==0) {
                [self.timeTimer invalidate];
            }
            min--;
        }
    }
    if (hour !=0) {
        if (countNum == 0) {
            countNum = 60;
            
            if (min == 0) {
                min = 60;
                minuteLable.text  = [NSString stringWithFormat:@"%02d",min-1];
                min--;
                minCount++;
                if (min==0) {
                    min=60;
                    hourLable.text = [NSString stringWithFormat:@"%02d",hour-1];
                    hour--;
                    if (hour==0) {
                        [self.timeTimer invalidate];
                    }
                }
                
            }else{
                minuteLable.text  = [NSString stringWithFormat:@"%02d",min-1];
                min--;
                minCount++;
                if (min==0) {
                    min=60;
                    hourLable.text = [NSString stringWithFormat:@"%02d",hour-1];
                    hour--;
                    if (hour==0) {
                        [self.timeTimer invalidate];
                    }
                }
            }
            
        }
        
    }
    
}


//报价数据
-(void)createOfferData
{
    UITextField *subfield = (UITextField *)[view viewWithTag:100];
    UILabel *subLabel = (UILabel *)[view viewWithTag:200];
    UILabel *priceLabel = (UILabel *)[view viewWithTag:101];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"client_id"] == nil) {
        LogInViewController *lvc = [[LogInViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else{
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=setBidding";
        NSDictionary *parameters = @{@"auctionid":_strID,@"putprice":subfield.text,@"client_id":[user objectForKey:@"client_id"]};
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"%@",responseObject);
             
             if (([priceLabel.text integerValue] + [subfield.text integerValue])<([priceLabel.text integerValue] + [subLabel.text integerValue])) {
                 UIAlertView *alview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"拍价过低" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                 [alview show];
             }else{
                 
                 UIAlertView *alv = [[UIAlertView alloc]initWithTitle:nil message:@"拍价成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                 [alv show];
                 
             }
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
         }];
    }
    
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex) {
//        case 0:
//        {
//            //            UIButton *patButton = (UIButton *)[self.view viewWithTag:600];
//            //            [patButton setTitle:@"领先" forState:UIControlStateNormal];
//            //            [bgView removeFromSuperview];
//        }
//            break;
//        case 1:
//        {
//            UIButton *patButton = (UIButton *)[self.view viewWithTag:600];
//            [patButton setTitle:@"领先" forState:UIControlStateNormal];
//            [bgView removeFromSuperview];
//        }
//            break;
//        default:
//            break;
//    }
//
//}
//

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1) {
        
        static NSString *cellName1 = @"cellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName1];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName1];
        }
        cell.accessoryType = UITableViewCellEditingStyleNone;
        
        ///////////////////////////////////
        
        if (offerDataArray.count > 0) {
            
            for (int i = 0; i<offerDataArray.count; i++) {
                
                [recordLabel removeFromSuperview];
                UILabel *label = [ZYControl createLabelWithFrame:CGRectMake((9/375.0)*kScreenWidth+((130/375.0)*kScreenWidth)*i, (3/375.0)*kScreenHeight, (30/375.0)*kScreenWidth, (30/667.0)*kScreenHeight) Font:10 Text:nil];
                if (i == 0) {
                    label.layer.borderWidth = 1;
                    label.layer.borderColor =[AOColorFormat colorWithHexString:@"c70065"].CGColor;
                    label.text = @"领先";
                    label.textAlignment = NSTextAlignmentCenter;
                    label.textColor = [AOColorFormat colorWithHexString:@"c70065"];
                }else {
                    label.text = @"淘汰";
                    label.textColor =[AOColorFormat colorWithHexString:@"d9d9d9"];
                    label.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
                    label.textAlignment = NSTextAlignmentCenter;
                    label.layer.borderWidth = 1;
                    
                }
                [cell addSubview:label];
                //手机号
                UILabel *phoneLabel = [ZYControl createLabelWithFrame:CGRectMake((41/375.0)*kScreenWidth+((130/375.0)*kScreenWidth)*i, (3/375.0)*kScreenHeight, 110, 20) Font:10 Text:[offerDataArray[i] objectForKey:@"username"]];
                phoneLabel.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
                [cell addSubview:phoneLabel];
                //价格
                UILabel *priceLabel = [ZYControl createLabelWithFrame:CGRectMake((50/375.0)*kScreenWidth+((130/375.0)*kScreenWidth)*i, (10/375.0)*kScreenHeight, 80, 20) Font:10 Text:[offerDataArray[i] objectForKey:@"put_price"]];
                priceLabel.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
                [cell addSubview:priceLabel];
                
                
            }
            
            
        }else{
            
            
            recordLabel = [ZYControl createLabelWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, 20*RATIOTYPE_HEIGHT,180*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:14 Text:@"暂无出价记录"];
            recordLabel.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
            [cell addSubview:recordLabel];
            
            
        }
        
        ////////////////////////////////////
        //        for (int i = 0; i<offerDataArray.count; i++) {
        //
        //
        //            UILabel *label = [ZYControl createLabelWithFrame:CGRectMake((9/375.0)*kScreenWidth+((130/375.0)*kScreenWidth)*i, (3/375.0)*kScreenHeight, (30/375.0)*kScreenWidth, (30/667.0)*kScreenHeight) Font:10 Text:nil];
        //            if (i == 0) {
        //                label.layer.borderWidth = 1;
        //                label.layer.borderColor =[AOColorFormat colorWithHexString:@"c70065"].CGColor;
        //                label.text = @"领先";
        //                label.textAlignment = NSTextAlignmentCenter;
        //                label.textColor = [AOColorFormat colorWithHexString:@"c70065"];
        //            }else {
        //                label.text = @"淘汰";
        //                label.textColor =[AOColorFormat colorWithHexString:@"d9d9d9"];
        //                label.layer.borderColor = [AOColorFormat colorWithHexString:@"d9d9d9"].CGColor;
        //                label.textAlignment = NSTextAlignmentCenter;
        //                label.layer.borderWidth = 1;
        //
        //            }
        //            [cell addSubview:label];
        //            //手机号
        //            UILabel *phoneLabel = [ZYControl createLabelWithFrame:CGRectMake((41/375.0)*kScreenWidth+((130/375.0)*kScreenWidth)*i, (3/375.0)*kScreenHeight, 110, 20) Font:10 Text:[offerDataArray[i] objectForKey:@"username"]];
        //            phoneLabel.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
        //            [cell addSubview:phoneLabel];
        //            //价格
        //            UILabel *priceLabel = [ZYControl createLabelWithFrame:CGRectMake((50/375.0)*kScreenWidth+((130/375.0)*kScreenWidth)*i, (10/375.0)*kScreenHeight, 80, 20) Font:10 Text:[offerDataArray[i] objectForKey:@"put_price"]];
        //            priceLabel.textColor = [AOColorFormat colorWithHexString:@"d9d9d9"];
        //            [cell addSubview:priceLabel];
        //
        //
        //        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else{
        
        static NSString *cellName = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            switch (indexPath.row) {
                    
                case 0:
                {
                    //出价纪录
                    UILabel *offerRecordLabel = [ZYControl createLabelWithFrame:CGRectMake(9/375.0*kScreenWidth,10/667.0*kScreenHeight, 100/375.0*kScreenWidth, 20/667.0*kScreenHeight) Font:14 Text:@"出价纪录"];
                    offerRecordLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
                    [cell addSubview:offerRecordLabel];
                    
                }
                    break;
                    
                case 2:
                {
                    //商品参数
                    UILabel *goodsParameterLabel = [ZYControl createLabelWithFrame:CGRectMake(9/375.0*kScreenWidth, 15/667.0*kScreenHeight, 100/375.0*kScreenWidth, 16/667.0*kScreenHeight) Font:14 Text:@"商品参数"];
                    goodsParameterLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
                    [cell addSubview:goodsParameterLabel];
                }
                    break;
                case 3:
                {
                    //服务保障
                    UILabel *serveGuarateeLabel = [ZYControl createLabelWithFrame:CGRectMake(9/375.0*kScreenWidth, 15/667.0*kScreenHeight, 100/375.0*kScreenWidth, 16/667.0*kScreenHeight) Font:14 Text:@"服务保障"];
                    serveGuarateeLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
                    [cell addSubview:serveGuarateeLabel];
                }
                    break;
                case 4:
                {
                    //竞拍规则
                    UILabel *auctionRuleLabel = [ZYControl createLabelWithFrame:CGRectMake(9/375.0*kScreenWidth, 15/667.0*kScreenHeight, 100/375.0*kScreenWidth, 16/667.0*kScreenHeight) Font:14 Text:@"竞拍规则"];
                    auctionRuleLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
                    [cell addSubview:auctionRuleLabel];
                }
                    break;
                case 5:
                {
                    //用户协议
                    UILabel *userProtocolLabel = [ZYControl createLabelWithFrame:CGRectMake(9/375.0*kScreenWidth, 15/667.0*kScreenHeight, 100/375.0*kScreenWidth, 16/667.0*kScreenHeight) Font:14 Text:@"用户协议"];
                    userProtocolLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
                    [cell addSubview:userProtocolLabel];
                }
                    break;
                default:
                    break;
            }
            
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OfferPriceRecordViewController *opr = [[OfferPriceRecordViewController alloc]init];
        [self.navigationController pushViewController:opr animated:YES];
    }else if (indexPath.row == 3){
        
        ServeGuaranteeViewController *opr = [[ServeGuaranteeViewController alloc]init];
        [self.navigationController pushViewController:opr animated:YES];
        
    }else if (indexPath.row == 2)
    {
        
        GoodsNumberViewController *gvc = [[GoodsNumberViewController alloc]init];
        gvc.aucID = _strID;
        [self.navigationController pushViewController:gvc animated:YES];
        
    }else if (indexPath.row == 5){
        
        UserProtolViewController *upvc = [[UserProtolViewController alloc]init];
        [self.navigationController pushViewController:upvc animated:YES];
        self.tabBarController.tabBar.hidden = YES;
    }else if (indexPath.row == 4){
        AuctionRuleViewController *arvc = [[AuctionRuleViewController alloc]init];
        [self.navigationController pushViewController:arvc animated:YES];
        self.tabBarController.tabBar.hidden = YES;
    }
    
}
-(void)endRemindButtonClick:(UIButton *)endRemindButton
{
    if (endRemindButton.selected == NO) {
        [self createendReminderData:1];
        [endRemindButton setImage:[UIImage imageNamed:@"结束提醒@2x.png"] forState:UIControlStateNormal];
        
        endRemindButton.selected = YES;
        [self createendReminderData:0];
        
    }else{
        [self createendReminderData:1];
        endRemindButton.selected = NO;
        [endRemindButton setImage:[UIImage imageNamed:@"结束提醒灰@2x.png"] forState:UIControlStateSelected];
        
    }
    
    
}
-(void)createendReminderData:(NSInteger )ID
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"client_id"] == nil) {
        LogInViewController *lvc = [[LogInViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else{
        for (PatProduceDetailModel *model in _dataArray) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=setReminders";
            
            NSDictionary *parameters = @{@"specialid":@"1",@"reminders":@"ID",@"client_id":[user objectForKey:@"client_id"],@"starttime":model.start_time,@"endtime":model.end_time,@"name":[goodsDict objectForKey:@"good_name"]};
            
            [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@",responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        
    }
    
}


//登陆
-(void)createLoginView{
    
    loginView = [[UIView alloc] initWithFrame:self.view.frame];
    //    loginView  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    //    [self createNotification];
    [self createLoginView1];
    
    
}



-(void)createLoginView1
{
    // 创建导航左侧按钮
    //    [self createLeftorRightButton];
    [self createTextField];
    [self createLogInButton];
    [self createBackPasswordUnderLine];
    
}


//-(void)createLeftorRightButton
//{
//    //    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(15, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
//    //    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
//
//    UIButton *rightButton = [ZYControl createButtonWithFrame:CGRectMake(280, 0, 32, 320) ImageName:nil Target:self Action:@selector(rightButtonClick:) Title:@"注册"];
//    [rightButton setTitleColor:[AOColorFormat colorWithHexString:@"666666"] forState:UIControlStateNormal];
//    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//
//
//}

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
            titleLable.text = @"我的拍卖";
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
    [bottomView endEditing:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
