//
//  AddressViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "AddressViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AddressTableViewCell.h"
#import "NewAddressViewController.h"
#import "AppStatus.h"
#import "AuctionViewController.h"
#import "AFNetworking.h"

@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath *index;
    UIView *bgView;
    UIButton *deleteBtn;
    UIView *hightView;
    UIButton *cancelBtn;
    NSInteger k;
    NSArray *visibCells;
    BOOL isSelect;
    UIButton *addButton1;
    UIButton *rightButton1;  //右边添加的button
    
    NSMutableArray *selectArr;
    
    //存放数据的数组
    NSMutableArray *_dataArr;
    
    //编辑页面的时候传地址过去
    NSMutableArray *_dataArr1;
    //记录当前选中的cell的下标
    int row1;
    int row2;
    AddressTableViewCell *cell;
    
    //提示选择收货地址
    UIButton *bgView1;
    UIButton *alterbtn1;
    UILabel *alterLabel;
    
}

@end

@implementation AddressViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [[NSMutableArray alloc]init];
        _dataArr1 = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleLabel;
    self.view.backgroundColor = [UIColor whiteColor];

    _addressTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _addressTabelView.delegate = self;
    _addressTabelView.dataSource = self;
    
    _addressTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_addressTabelView];
    
    isSelect = NO;
    
    [self createData];
  
    [self createView];
    
    [self createTabItemLeftButton];
    
    [self createTabtemRightButton];

}
-(void)createView
{
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton1.frame = CGRectMake(0 ,kScreenHeight - 100 * RATIOTYPE_HEIGHT, kScreenWidth, 100 * RATIOTYPE_HEIGHT);
    addButton1.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [addButton1 setTitle:_addBtnTitle forState:UIControlStateNormal];
    [addButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    addButton1.tag = 300;
    [addButton1 addTarget:self action:@selector(drawAction6:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addButton1];
}

-(void)drawAction6:(UIButton *)button
{
    if ([addButton1.titleLabel.text isEqualToString:@"确认"]) {
        
        if (isSelect) {
            
            [self createDataAddress1];
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[AuctionViewController class]]) {
                    
                    AuctionViewController *aucitonVC = (AuctionViewController *)vc;
                    
                    aucitonVC.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController popToViewController:aucitonVC animated:YES];
                }
            }

        }else
        {
            bgView1 = [UIButton buttonWithType:UIButtonTypeCustom];
            bgView1.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            bgView1.backgroundColor = [UIColor blackColor];
            bgView1.alpha = 0.5;
            [bgView1 addTarget:self action:@selector(alterAction4:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:bgView1];
            
            
            alterbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            alterbtn1.frame = CGRectMake((kScreenWidth - 500 *RATIOTYPE_WIDTH)/2,400 *RATIOTYPE_HEIGHT, 500 * RATIOTYPE_WIDTH, 200 * RATIOTYPE_HEIGHT) ;
            alterbtn1.backgroundColor = [UIColor whiteColor];
            alterbtn1.alpha = 1;
            [alterbtn1 addTarget:self action:@selector(alterAction4:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:alterbtn1];
            
            
            alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, (120 * RATIOTYPE_HEIGHT)/2, 500 *RATIOTYPE_WIDTH-30 - 20, 20)];
            alterLabel.text = @"请选择您的收货地址！";
            alterLabel.textAlignment = NSTextAlignmentCenter;
            alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
            alterLabel.font = [UIFont systemFontOfSize:14];
            [alterbtn1 addSubview:alterLabel];
            
        }
        
    }else
    {
    NewAddressViewController * newVC = [[NewAddressViewController alloc]init];
    
    if (addButton1.tag == button.tag)
    {
        newVC.titleStr = @"添加新收货地址";
        newVC.btnTitle = @"添加";
    }
    
  
    [self.navigationController pushViewController:newVC animated:YES];
    }
    
}
-(void)alterAction4:(UIButton *)button
{
    [bgView1 removeFromSuperview];
    [alterbtn1 removeFromSuperview];
}




#pragma mark --- 添加导航栏的左右 button
-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(0, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
    if ([addButton1.titleLabel.text isEqualToString:@"确认"]) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else
    {
    
    self.tabBarController.tabBar.hidden = NO;
    }
}

-(void)createTabtemRightButton
{
    rightButton1 = [ZYControl createButtonWithFrame:CGRectMake(0, 24, 24, 24) ImageName:@"添加按钮" Target:self Action:@selector(rightButtonClick:) Title:nil];
    rightButton1.tag = 310;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
}

-(void)rightButtonClick:(UIButton *)rightButton
{
    NewAddressViewController * newVC1 = [[NewAddressViewController alloc]init];

    if (rightButton1.tag == rightButton.tag) {
        
        newVC1.titleStr = @"添加新收货地址";
        newVC1.btnTitle = @"添加";
    }
    
    [self.navigationController pushViewController:newVC1 animated:YES];
}

#pragma mark --- 添加数据
-(void)createData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"client_id":[user objectForKey:@"client_id"]};
    
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=addressList";
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *addressArr = (NSDictionary *)responseObject[@"data"];
        _dataArr = [[NSMutableArray alloc]initWithCapacity:10];
        
        NSArray *arr = [addressArr objectForKey:@"address"];
        NSMutableArray *ar = [[NSMutableArray alloc]init];
        selectArr = [[NSMutableArray alloc]initWithCapacity:10];

        
        for (NSDictionary *dic in arr) {
//            NSLog(@"***************%@",dic);
            
            AddressModel *model = [[AddressModel alloc]init];
            model.accept_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"accept_name"]];
            model.mobile = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mobile"]];
            model.province = [NSString stringWithFormat:@"%@",[dic objectForKey:@"province"]];
            model.city = [NSString stringWithFormat:@"%@",[dic objectForKey:@"city"]];
            model.county = [NSString stringWithFormat:@"%@",[dic objectForKey:@"county"]];
            model.addr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"addr"]];
            model.set_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            
            [ar addObject:model.set_id];
            
            [selectArr addObject:@0];

            [_dataArr1 addObject:dic];
            [_dataArr addObject:model];
        }
//        NSLog(@"地址%@",_dataArr);
        
        [_addressTabelView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",operation.error);
    }];
  
}
#pragma mark --- 确认收货地址数据的接口
//有地址的时候调用的接口
- (void)createDataAddress1
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *dic = [_dataArr1 objectAtIndex:row1];
    NSString *addId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"set_id"]];
    
    NSDictionary *parameter = @{@"client_id":[user objectForKey:@"client_id"],@"addressid":addId,@"orderid":_orderID};
    NSString *url = @"http://123.57.212.63/shepai/index.php?con=Api&act=addressConfirm";
    
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"数据返回成功＊＊＊%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据返回失败＊＊＊%@",operation.error);
    }];
    
}

#pragma mark --- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addressCell = @"addressCell";
     cell = [tableView dequeueReusableCellWithIdentifier:addressCell];
    
    if (!cell) {
        cell = [[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressCell];
        [cell.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    //加载数据
    AddressModel *model = [_dataArr objectAtIndex:indexPath.row];
    cell.modelAdd = model;
    
//    cell.tag = [indexPath row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.selectButton.tag = indexPath.row;
    cell.selectButton.selected = [selectArr[indexPath.row]boolValue];
    
    //设置每行cell上面button的tag值
    cell.addButton.tag = indexPath.row + 10;
    cell.deleteButton.tag = indexPath.row + 100;

    [cell.addButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    visibCells = [self.addressTabelView visibleCells];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < selectArr.count; i ++) {
        [selectArr replaceObjectAtIndex:i withObject:@0];
    }
    
    [selectArr replaceObjectAtIndex:indexPath.row withObject:@1];
    [_addressTabelView reloadData];
    //    index = (int)indexPath.row;
    
    AddressTableViewCell *selCell2 = (AddressTableViewCell *)[self.addressTabelView cellForRowAtIndexPath:index];
    selCell2.selectButton.selected = NO;
    
    if (0 == indexPath.section) {
        
        NSIndexPath *indexP = [self.addressTabelView indexPathForSelectedRow];
        AddressTableViewCell *selCell =(AddressTableViewCell *)[self.addressTabelView cellForRowAtIndexPath:indexP];
        
        selCell.selectButton.selected = YES;
        index = indexP;
        
        isSelect = YES;
        
    }
}



#pragma mark --- 选择收货地址接口数据
-(void)createChangeAddressData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    AddressModel *model2 = [_dataArr objectAtIndex:row1];
//    NSString *addId =model2.set_id;
    
    NSDictionary *parameter = @{@"client_id":[user objectForKey:@"client_id"]};
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=addressList";
    
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"数据返回成功＊＊＊%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据返回失败＊＊＊%@",operation.error);
    }];
}

#pragma mark -- 选择cell
-(void)selectAction:(UIButton *)sender
{
    AddressTableViewCell * cell1 = (AddressTableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [self.addressTabelView indexPathForCell:cell1];
    [self tableView:_addressTabelView didSelectRowAtIndexPath:path];
}


#pragma mark -- 编辑cell
-(void)editAction:(UIButton *)button
{
    //创建数组传值
    NSArray *array = _dataArr1;
    
    //导航push到下一个页面
    
    NewAddressViewController *newVC2 = [[NewAddressViewController alloc]init];
    newVC2.titleStr = @"编辑收货地址";
    newVC2.btnTitle = @"编辑完成";
    newVC2.inde = (int)button.tag - 10;
    newVC2.neDic = array[button.tag - 10];
    
    [self.navigationController pushViewController:newVC2 animated:YES];
    
}

#pragma mark -- 删除cell

-(void)deleteAction:(UIButton *)button
{
    row1 = (int)button.tag - 100;
    
    [self createAlterView];

}

#pragma mark --- 删除收货地址接口
-(void)createDeleteData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AddressModel *model = [_dataArr objectAtIndex:row1];
 
    NSString *address_id =model.set_id;

    NSDictionary *parameter = @{@"client_id":[user objectForKey:@"client_id"],@"address_id":address_id};
    NSString *url1 = @"http://123.57.212.63/paimai/index.php?con=api&act=delAddress";
    
    [manager POST:url1 parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"数据返回成功－－－%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据返回失败－－－%@",operation.error);
    }];
}


#pragma mark -- 自定义UIAlterView
-(void)createAlterView
{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    
    
    hightView = [[UIView alloc]init];
    hightView.frame = CGRectMake((kScreenWidth - 690 *RATIOTYPE_WIDTH)/2,200 + 5, 690 * RATIOTYPE_WIDTH, 300 * RATIOTYPE_HEIGHT) ;
    hightView.backgroundColor = [UIColor whiteColor];
    hightView.alpha = 1;
    [self.view addSubview:hightView];
    
    UIImageView *alterImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 30, 20, 20)];
    alterImage.image = [UIImage imageNamed:@"提示"];
    [hightView addSubview:alterImage];
    
    UILabel *alterLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, 690 * RATIOTYPE_WIDTH-30 - 20, 20)];
    alterLabel1.text = @"确定删除地址吗？";
    alterLabel1.textAlignment = NSTextAlignmentCenter;
    alterLabel1.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    alterLabel1.font = [UIFont systemFontOfSize:16];
    [hightView addSubview:alterLabel1];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake((690 /2 - 200) *RATIOTYPE_WIDTH /2, 280 * RATIOTYPE_HEIGHT - 40, 200 * RATIOTYPE_WIDTH, 30);
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.borderColor = [[AOColorFormat colorWithHexString:@"#4c4c4c"]CGColor];
    cancelBtn.layer.borderWidth = 1.0f;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitleColor:[AOColorFormat colorWithHexString:@"#4c4c4c"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAct:) forControlEvents:UIControlEventTouchUpInside];
    [hightView addSubview:cancelBtn];
    
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(cancelBtn.frame.origin.x + cancelBtn.frame.size.width + (690 /2 - 200) * RATIOTYPE_WIDTH, 280 * RATIOTYPE_HEIGHT - 40, 200 * RATIOTYPE_WIDTH, 30);
    deleteBtn.layer.masksToBounds = YES;
    deleteBtn.layer.borderColor = [[AOColorFormat colorWithHexString:@"#4c4c4c"]CGColor];
    deleteBtn.layer.borderWidth = 1.0f;
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [deleteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor whiteColor]];
    [deleteBtn setTitleColor:[AOColorFormat colorWithHexString:@"#4c4c4c"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAct:) forControlEvents:UIControlEventTouchUpInside];
    [hightView addSubview:deleteBtn];
}


-(void)deleteAct:(UIButton *)btn
{
    [self createDeleteData];
    
    [_dataArr1 removeObjectAtIndex:row1];
    [self createData];
    [_addressTabelView reloadData];

    [bgView removeFromSuperview];
    [hightView removeFromSuperview];
    
}

-(void)cancelAct:(UIButton *)btn
{
    deleteBtn.selected = NO;
    cancelBtn.selected = !cancelBtn.selected;
    
    [bgView removeFromSuperview];
    [hightView removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self createData];
    [_addressTabelView reloadData];
}


@end
