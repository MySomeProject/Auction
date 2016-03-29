
//
//  HomeViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/6/25.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "HomeViewController.h"
#import "SessionListViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIImage+BlurredFrame.h"
#import "UIImage+ImageEffects.h"
#import "UIImage+Scale.h"
#import "UIImage+WebP.h"
#import "Single.h"
#import "MJRefresh.h"
#import "PatProductListViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_newTableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_headerArray;
    NSMutableArray *images_specialArray;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSTimer *timer;
    UIView *headerView;
    UIImageView *todayImageView;
    UIImageView *tomorrowImageView ;
    UIButton *todayButton;
    UIView *boundaryView1;
    UIImage *todayImage;
    UIImage *tomorrowImage;
    
}
@end

@implementation HomeViewController

-(id)init
{
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc]init];
        _headerArray = [[NSMutableArray alloc]init];
        images_specialArray = [[NSMutableArray alloc]init];
        
        self.title = @"拍大牌";
        self.tabBarItem.image = [UIImage imageNamed:@"首页.png"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"拍大牌";
    [self createTableView];
    //请求数据
  //  [self createHomeLoadData];
    [self ZYrefresh];
    
    
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
    
    // 设置正在刷新状态的动画图片
    [_newTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
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
        [timer invalidate];
        
    }
    [self createHomeLoadData];
    
}

-(void)timeFireMethod
{
    [_dataArray removeAllObjects];
    [self createHomeLoadData];
    
}
-(void)createTableView
{
    
    //创建UITableView
    _newTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-49-64) style:UITableViewStylePlain];
    _newTableView.delegate = self;
    _newTableView.dataSource = self;
//    [self ZYrefresh];
    [self.view addSubview:_newTableView];
}

-(void)createHeaderView
{
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 598*RATIOTYPE_HEIGHT)];
    //创建滚动视图
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,352*RATIOTYPE_HEIGHT)];
    scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    //设置翻页滚动
    scrollView.pagingEnabled = YES;
    //消除弹性，禁止边界回弹效果
    scrollView.bounces = NO;
    [headerView addSubview:scrollView];
    
    for (int index = 0; index <_headerArray.count; index++) {
        
        UIImageView *headerImageView = [[UIImageView alloc] init];
        headerImageView.frame = CGRectMake(kScreenWidth*index, 0,kScreenWidth,352*RATIOTYPE_HEIGHT);
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:_headerArray[index]]];
        
        [scrollView addSubview:headerImageView];
        
    }
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth/2-30*RATIOTYPE_WIDTH,300*RATIOTYPE_HEIGHT,60*RATIOTYPE_WIDTH,20*RATIOTYPE_HEIGHT)];
    //一共有多少个小白点
    pageControl.numberOfPages = 2;
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [headerView addSubview:pageControl];
    
    timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _newTableView.tableHeaderView = headerView;
    
    [self createTodayButton];
    //    [self createTomorrowButton];
    //    [self createRecommendLabel];
    
    
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

-(void)createTodayButton
{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[images_specialArray firstObject] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%ld,%ld",receivedSize,expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                todayImage = image;
                todayImage = [todayImage applyLightEffectAtFrame:CGRectMake(0, 0,170,78)];
                todayImage = [UIImage originImage:todayImage scaleToSize:CGSizeMake((kScreenWidth-70*RATIOTYPE_WIDTH)/2, 156*RATIOTYPE_HEIGHT)];
                todayImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, 362*RATIOTYPE_HEIGHT, (kScreenWidth-70*RATIOTYPE_WIDTH)/2, 156*RATIOTYPE_HEIGHT)];
                todayImageView.userInteractionEnabled = YES;
                //    [todayImageView sd_setImageWithURL:[NSURL URLWithString:[images_specialArray firstObject]]];
                todayImageView.image = todayImage;
                [headerView addSubview:todayImageView];
                
                todayButton= [ZYControl createButtonWithFrame:CGRectMake(0,0, (kScreenWidth-70*RATIOTYPE_WIDTH)/2,156*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:@selector(todayButtonClick:) Title:@"今日专场"];
                [todayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [todayImageView addSubview:todayButton];
                todayButton.tag = 601;
                
                UILabel *todayLabel = [ZYControl createLabelWithFrame:CGRectMake(70*RATIOTYPE_WIDTH, 90*RATIOTYPE_HEIGHT,300*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:10 Text:@"TODAY'  S SPECIAL"];
                todayLabel.textColor = [UIColor whiteColor];
                [todayImageView addSubview:todayLabel];
                
                /**这里执行完之后再执行添加tomorrowButton*/
                [self createTomorrowButton];
                [self createRecommendLabel];
                
            });
            NSLog(@"%@",todayImage);
            
        }else{
            NSLog(@"error ＝ %@",error);
        }
    }];
    
    
}
-(void)todayButtonClick:(UIButton *)btn
{
    SessionListViewController *todaySlvc = [[SessionListViewController alloc]init];
    todaySlvc.count = (int)(todayButton.tag) -600;
    [self.navigationController pushViewController:todaySlvc animated:YES];
    
    
}
-(void)createTomorrowButton
{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[images_specialArray lastObject] options:0  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
    }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    tomorrowImage = image;
                                    tomorrowImage = [tomorrowImage applyLightEffectAtFrame:CGRectMake(0, 0, 530, 218)];
                                    tomorrowImage = [UIImage originImage:tomorrowImage scaleToSize:CGSizeMake((kScreenWidth-70*RATIOTYPE_WIDTH)/2, 156*RATIOTYPE_HEIGHT)];
                                    tomorrowImageView.userInteractionEnabled = YES;
                                    tomorrowImageView = [ZYControl createImageViewWithFrame:CGRectMake(CGRectGetMaxX(todayImageView.frame)+10*RATIOTYPE_WIDTH, 362*RATIOTYPE_HEIGHT, (kScreenWidth-70*RATIOTYPE_WIDTH)/2, 156*RATIOTYPE_HEIGHT) ImageName:nil];
                                    tomorrowImageView.image = tomorrowImage;
                                    
                                    [headerView addSubview:tomorrowImageView];
                                    
                                    UIButton *tomorrowButton = [ZYControl createButtonWithFrame:CGRectMake(0,0,(kScreenWidth-70*RATIOTYPE_WIDTH)/2, 156*RATIOTYPE_HEIGHT) ImageName:nil Target:self Action:@selector(tomorrowButtonClick:) Title:@"明日预告"];
                                    [tomorrowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                    tomorrowButton.tag = 602;
                                    [tomorrowImageView addSubview:tomorrowButton];
                                    
                                    UILabel *todayLabel = [ZYControl createLabelWithFrame:CGRectMake(20*RATIOTYPE_WIDTH, 90*RATIOTYPE_HEIGHT, 400*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:10 Text:@"TOMORROW'  S FORECAST"];
                                    todayLabel.textColor = [UIColor whiteColor];
                                    [tomorrowImageView addSubview:todayLabel];
                                });
                            }else{
                                
                                NSLog(@"error ＝ %@",error);
                            }
                            
                        }];
    
    //    UIImage *tomorrowImage = [UIImage imageNamed:@"1.png"];
    
    NSLog(@"%@",[images_specialArray lastObject]);
    
}
-(void)tomorrowButtonClick:(UIButton *)tomorrowButton
{
    SessionListViewController *slvc = [[SessionListViewController alloc]init];
    slvc.count = (int)(tomorrowButton.tag) -600;
    [self.navigationController pushViewController:slvc animated:YES];
}

-(void)createRecommendLabel
{
    boundaryView1 = [[UIView alloc]initWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, CGRectGetMaxY(todayImageView.frame)+80*RATIOTYPE_HEIGHT, 260*RATIOTYPE_WIDTH, 1*RATIOTYPE_HEIGHT)];
    boundaryView1.backgroundColor = [UIColor grayColor];
    boundaryView1.alpha = 0.5;
    [headerView addSubview:boundaryView1];
    
    UIView *boundaryView2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-290*RATIOTYPE_WIDTH, CGRectGetMaxY(todayImageView.frame)+80*RATIOTYPE_HEIGHT, 260*RATIOTYPE_WIDTH, 1*RATIOTYPE_HEIGHT)];
    boundaryView2.backgroundColor = [UIColor grayColor];
    boundaryView1.alpha = 0.5;
    [headerView addSubview:boundaryView2];
    
    
    UILabel *recommendLabel = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX (boundaryView1.frame)+(kScreenWidth-580*RATIOTYPE_WIDTH-200*RATIOTYPE_WIDTH)/2,CGRectGetMaxY(todayImageView.frame)+50*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,60*RATIOTYPE_HEIGHT) Font:18 Text:@"推荐专场"];
    recommendLabel.textAlignment = NSTextAlignmentCenter;
    recommendLabel.textColor =[AOColorFormat colorWithHexString:@"4c4c4c"];
    [headerView addSubview:recommendLabel];
}

//请求数据
-(void)createHomeLoadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=getSpeicial";
    //    NSDictionary *parameters = @{@"keyword":@"名匠系列"};
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDict =(NSDictionary *)responseObject[@"data"];
        //    NSLog(@"%@",dataDict);
        
        NSArray *headerArr = [dataDict objectForKey:@"images_carousel"];
        for (NSDictionary *headerDict in headerArr) {
            [_headerArray addObject:[headerDict objectForKey:@"path"]];
            
        }
        
        NSArray *images_specialArr = [dataDict objectForKey:@"images_special"];
        for (NSDictionary *images_specialDict in images_specialArr) {
            [images_specialArray addObject:[images_specialDict objectForKey:@"path"]];
        }
        //        NSLog(@"%@",images_specialArray);
        
        //专场数据
        NSArray *specialArray = [dataDict objectForKey:@"special"];
        NSLog(@"%@",specialArray);
        for (NSDictionary *specialDict in specialArray) {
            
            HomeModel *model = [[HomeModel alloc]init];
            model.id = [specialDict objectForKey:@"id"];
            model.spec_name = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"spec_name"]];
            model.inst_name = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"inst_name"]];
            model.spec_image = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"spec_image"]];
            model.auct_count = [NSString stringWithFormat:@"(%@件拍品)",[specialDict objectForKey:@"auct_count"]];
            model.auction_peoples = [NSString stringWithFormat:@"%@人竞拍",[specialDict objectForKey:@"auction_peoples"]];
            model.auction_number = [NSString stringWithFormat:@"%@次竞价",[specialDict objectForKey:@"auction_number"]];
            model.now_time = [specialDict objectForKey:@"now_time"];
            
            model.start_time = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"start_time"]];
            model.end_time = [NSString stringWithFormat:@"%@",[specialDict objectForKey:@"end_time"]];
            
            [_dataArray addObject:model];
        }
        
        [_newTableView reloadData];
        [_newTableView.header endRefreshing];
        
        [self createHeaderView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",operation.error);
    }];
    
}


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
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    [cell.timer invalidate];
    
    if (cell == nil) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    HomeModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatProductListViewController *ppvc = [[PatProductListViewController alloc]init];
    for (HomeModel *model in _dataArray) {
        ppvc.id =model.id;
    }
    ppvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ppvc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
