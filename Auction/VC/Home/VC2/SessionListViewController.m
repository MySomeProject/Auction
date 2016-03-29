//
//  SessionListViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/6/29.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "SessionListViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "SessionListCell.h"
#import "SessionListModel.h"
#import "AFNetworking.h"
#import "Single.h"
#import "YYHongShare.h"
#import "PatProductListViewController.h"
#import "MJRefresh.h"
@interface SessionListViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *dateScrollView;
    UITableView *_newTableView;
    NSMutableArray *_dataArray;
    UILabel *underline;
    UIButton *dataButton;
    NSArray *dateArray;
    NSString *dateString3;
    NSString *dateString11;
    NSArray *mutableArray;
    //NSString *typeString;
    NSMutableArray *typeArray;
    NSString *mStr;
    
    UIView *bgView;
    UIView *view;
    
}

@end
@implementation SessionListViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
        dateArray = [[NSArray alloc] init];
        mutableArray = [[NSArray alloc] init];
        typeArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"专场列表";
    [self createTabItemLeftButton];
    [self createScrollView];
    [self createTableView];
    [self createButton];
    
    underline = [[UILabel alloc] init];
    
}

-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(0, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    //分享按钮
    UIButton *shareButton = [ZYControl createButtonWithFrame:CGRectMake(300*RATIOTYPE_WIDTH, 24,46*RATIOTYPE_WIDTH,37*RATIOTYPE_HEIGHT) ImageName:@"分享@2x.png" Target:self Action:@selector(shareButtonClick:) Title:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
}
-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
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
//朋友圈

-(void)friendBtnClick:(UIButton *)btn
{
    NSString *url = @"http://share.luxji.com/index.php?con=share&act=getSpeicial";
    NSString * title = [NSString stringWithFormat:@"今日专场列表"];
    NSString * image = [NSString stringWithFormat:@"2.png"];
    NSString * description = [NSString stringWithFormat:@"今日专场列表"];
    
    
    NSDictionary * dic = @{@"title":title,
                           @"webUrl":url,
                           @"description":description,
                           @"image":image};
    
    
    [YYHongShare YYHongWeiXinShare:dic type:1];
    
    
}

-(void)weiBtnClick:(UIButton *)weibtn
{
    NSString *url = @"http://share.luxji.com/index.php?con=share&act=getSpeicial";
    NSString * title = [NSString stringWithFormat:@"今日专场列表"];
    NSString * image = [NSString stringWithFormat:@"2.png"];
    NSString * description = [NSString stringWithFormat:@"今日专场列表"];
    
    
    NSDictionary * dic = @{@"title":title,
                           @"webUrl":url,
                           @"description":description,
                           @"image":image};
    
    
    [YYHongShare YYHongWeiXinShare:dic type:0];
    
}


-(void)createScrollView
{
    dateScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64,kScreenWidth,104*RATIOTYPE_HEIGHT)];
    dateScrollView.contentSize = CGSizeMake(kScreenWidth, 0);
    [self.view addSubview:dateScrollView];
    
}
-(void)createButton
{
    //创建一个时间戳
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"M-dd";
    
    //获取当前系统时间
    NSDate *date = [NSDate date];
    //以当前时间为准，然后过了sec秒后的时间
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    NSDate *tomorrowDate1 = [NSDate dateWithTimeIntervalSinceNow:24*60*60*2];
    NSDate *tomorrowDate2 = [NSDate dateWithTimeIntervalSinceNow:24*60*60*3];
    
    mutableArray = @[yesterdayDate,date,tomorrowDate,tomorrowDate1,tomorrowDate2];
    
    NSString *dateString1 = [df stringFromDate:date];
    NSString *dateString2 = [df stringFromDate:yesterdayDate];
    dateString3 = [df stringFromDate:tomorrowDate];
    NSString *dateString4 = [df stringFromDate:tomorrowDate1];
    NSString *dateString5 = [df stringFromDate:tomorrowDate2];
    
    
    
    //创建一个时间戳
    NSDateFormatter *dff = [[NSDateFormatter alloc] init];
    dff.dateFormat = @"yyyy-MM-dd";
    dateString11 = [dff stringFromDate:date];
    NSString *dateString22 = [dff stringFromDate:yesterdayDate];
    NSString *dateString33 = [dff stringFromDate:tomorrowDate];
    NSString *dateString44 = [dff stringFromDate:tomorrowDate1];
    NSString *dateString55 = [dff stringFromDate:tomorrowDate2];
    dateArray = @[dateString22,dateString11,dateString33,dateString44,dateString55];
    
    NSArray *arr = @[dateString2,dateString1,dateString3,dateString4,dateString5];
    for (int i = 0; i <arr.count; i++) {
        dataButton = [ZYControl createButtonWithFrame:CGRectMake((((kScreenWidth-160*RATIOTYPE_WIDTH-130*RATIOTYPE_WIDTH*(arr.count-1))/4)+100*RATIOTYPE_WIDTH)*i+80*RATIOTYPE_WIDTH,20*RATIOTYPE_HEIGHT,130*RATIOTYPE_WIDTH,50/667.0*kScreenHeight) ImageName:nil Target:self Action:@selector(dataButtonClick:) Title:arr[i]];
        
        [dataButton setTitleColor:[AOColorFormat colorWithHexString:@"666666"] forState:UIControlStateNormal];
        dataButton.titleLabel.font = [UIFont systemFontOfSize:16];
        dataButton.tag = 100+i;
        
        [dateScrollView addSubview:dataButton];
    }
    
}
-(void)dataButtonClick:(UIButton *)btn
{
    typeArray = [[NSMutableArray alloc] initWithCapacity:0];
    _dataArray= [[NSMutableArray alloc] initWithCapacity:0];
    
    _la = (UILabel *)[self.view viewWithTag:110];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _la.frame = CGRectMake(btn.frame.origin.x,100*RATIOTYPE_HEIGHT,132*RATIOTYPE_WIDTH,4*RATIOTYPE_HEIGHT);
    [UIView commitAnimations];
    underline.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
    [dateScrollView addSubview:underline];
    
    
    //创建一个时间戳
    NSDateFormatter *dfv = [[NSDateFormatter alloc] init];
    dfv.dateFormat = @"yyyy-MM-dd";
    NSDate *date11 = [dfv dateFromString:dateArray[btn.tag-100]];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date11 timeIntervalSince1970]];
    [self createSessionListLoadData:timeSp];
    [self ZYrefsh:timeSp];
    
    
}
-(void)createTableView
{
    _newTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _newTableView.delegate = self;
    _newTableView.dataSource = self;
    [self.view addSubview:_newTableView];
    _newTableView.tableHeaderView = dateScrollView;
}
//请求数据
-(void)createSessionListLoadData:(NSString *)string
{
    kappDelegate.timeStr = string;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getSpeicial";
    NSDictionary *parameters =@{@"time":string};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        if (_dataArray.count > 0) {
        //            [_dataArray removeAllObjects];
        //        }
        
        NSDictionary *dataDict =responseObject[@"data"];
        NSArray *specialArray = [dataDict objectForKey:@"special"];
        
        for (NSDictionary *specialDict in specialArray) {
            
            SessionListModel *model = [[SessionListModel alloc]init];
            
            model.id = [specialDict objectForKey:@"id"];
            
            model.spec_name = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"spec_name"]];
            model.auct_count = [NSString stringWithFormat:@"(%@件拍品)",[specialDict objectForKey:@"auct_count"]];
            model.auction_peoples = [NSString stringWithFormat:@"%@人竞拍",[specialDict objectForKey:@"auction_peoples"]];
            model.auction_number = [NSString stringWithFormat:@"%@次竞拍",[specialDict objectForKey:@"auction_number"]];
            model.now_time = [specialDict objectForKey:@"now_time"];
            
            model.start_time = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"start_time"]];
            model.end_time = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"end_time"]];
            if ([model.start_time doubleValue] - [model.now_time doubleValue] == 0){
                model.typeString = @"1";
            }else
            {
                model.typeString = @"2";
                
            }
            
            [_dataArray addObject:model];
        }
        [_newTableView reloadData];
        
        [_newTableView.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",operation.error);
    }];
    
    
    
}
//********************************刷新************************************
- (void)ZYrefsh:(NSString *)string
{
    mStr = string;
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_newTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [_newTableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [_newTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_newTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
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
    [self createSessionListLoadData:mStr];
    
}
//********************************************************************

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 480*RATIOTYPE_HEIGHT;
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellName = @"CellID";
    SessionListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    [cell.timer invalidate];
    if (cell == nil) {
        //        [cell.timer invalidate];
        cell = [[SessionListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
       SessionListModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.tag = 600;
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //typeString = cell.typeString;
    //[typeArray addObject:typeString];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatProductListViewController *ppvc = [[PatProductListViewController alloc]init];
    for (SessionListModel *model in _dataArray) {
        ppvc.id = model.id;
    }
    
    NSString *str = [typeArray objectAtIndex:indexPath.row];
    ppvc.typeString = str;
    
    NSLog(@"%@",ppvc.id);
    [self.navigationController pushViewController:ppvc animated:YES];
}
//已结束按钮
-(void)endButtonClick:(UIButton *)btn
{
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.count == 1) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:101];
        [btn setTitleColor:[AOColorFormat colorWithHexString:@"c70065"] forState:UIControlStateNormal];
        [btn setTitle:@"今天" forState:UIControlStateNormal];
        underline.frame = CGRectMake(195*RATIOTYPE_WIDTH,100*RATIOTYPE_HEIGHT,132*RATIOTYPE_WIDTH,4*RATIOTYPE_HEIGHT);
        underline.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
        underline.tag = 110;
        [dateScrollView addSubview:underline];
        
        //        NSDate *date = [NSDate date];
        NSDateFormatter *dff = [[NSDateFormatter alloc] init];
        dff.dateFormat = @"yyyy-MM-dd";
        //        NSString *dateString11 = [dff stringFromDate:date];
        NSDate *date1 = [dff dateFromString:dateString11];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date1 timeIntervalSince1970]];
        //        [self createSessionListLoadData:timeSp];
        [self ZYrefsh:timeSp];
        
        
        
    }
    else if (self.count == 2) {
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:101];
        [btn1 setTitle:@"今天" forState:UIControlStateNormal];
        UIButton *btn = (UIButton *)[self.view viewWithTag:102];
        [btn setTitleColor:[AOColorFormat colorWithHexString:@"c70065"] forState:UIControlStateNormal];
        [btn setTitle:dateString3 forState:UIControlStateNormal];
        underline.frame = CGRectMake(btn.frame.origin.x,100*RATIOTYPE_HEIGHT,132*RATIOTYPE_WIDTH,4*RATIOTYPE_HEIGHT);
        underline.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
        underline.tag = 110;
        [dateScrollView addSubview:underline];
        
        //        NSDate *date = [NSDate date];
        NSDateFormatter *dff = [[NSDateFormatter alloc] init];
        dff.dateFormat = @"yyyy-MM-dd";
        NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
        NSString *dateString33 = [dff stringFromDate:tomorrowDate];
        NSDate *date1 = [dff dateFromString:dateString33];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date1 timeIntervalSince1970]];
        //        [self createSessionListLoadData:timeSp];
        [self ZYrefsh:timeSp];
        
        
        
    }else{
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:101];
        [btn setTitleColor:[AOColorFormat colorWithHexString:@"c70065"] forState:UIControlStateNormal];
        [btn setTitle:@"今天" forState:UIControlStateNormal];
        underline.frame = CGRectMake(btn.frame.origin.x,100*RATIOTYPE_HEIGHT,132*RATIOTYPE_WIDTH,4*RATIOTYPE_HEIGHT);
        //        underline = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x,100*RATIOTYPE_HEIGHT,132*RATIOTYPE_WIDTH,4*RATIOTYPE_HEIGHT)];
        underline.backgroundColor = [AOColorFormat colorWithHexString:@"c70065"];
        underline.tag = 110;
        [dateScrollView addSubview:underline];
        
        //        NSDate *date = [NSDate date];
        NSDateFormatter *dff = [[NSDateFormatter alloc] init];
        dff.dateFormat = @"yyyy-MM-dd";
        //        NSString *dateString11 = [dff stringFromDate:date];
        NSDate *date1 = [dff dateFromString:dateString11];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date1 timeIntervalSince1970]];
        //        [self createSessionListLoadData:timeSp];
        [self ZYrefsh:timeSp];
        
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end