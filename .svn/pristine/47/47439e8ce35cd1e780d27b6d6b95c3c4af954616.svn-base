//
//  EditViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/13.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "EditViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AffirmViewController.h"
#import "AFNetworking.h"
#import "AffirmModel.h"
@interface EditViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_newTableView1;
    UITableView *_newTableView2;
    UITableView *_newTableView3;
    NSMutableArray *_dataArray;
    NSArray *_titleArray;
    NSArray *_locationArray;
    NSArray *_regionArray;
    
    NSArray *cityArray;
    NSMutableDictionary *cityDict;
    NSArray *townArray;
    NSArray *_citiesArray;
}
@end

@implementation EditViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
        _titleArray = [[NSArray alloc]init];
        _locationArray = [[NSArray alloc]init];
        _regionArray = [[NSArray alloc]init];
        cityDict = [[NSMutableDictionary alloc]init];
        townArray = [[NSArray alloc] init];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置退款账户";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTabItemLeftButton];
    [self createView];
//    [self createEditViewData];

    
    
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

-(void)createView
{
    _name = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, 64 + 30 * RATIOTYPE_HEIGHT, kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 20)];
    _name.text = @"开户人姓名";
    _name.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _name.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_name];
    
    _nameText = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth - 690 * RATIOTYPE_WIDTH)/2, _name.frame.origin.y + _name.frame.size.height + 30 * RATIOTYPE_HEIGHT, 690 * RATIOTYPE_WIDTH, 72 * RATIOTYPE_HEIGHT)];
    _nameText.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _nameText.font = [UIFont systemFontOfSize:14];
    _nameText.borderStyle = UITextBorderStyleNone;
    _nameText.layer.masksToBounds = YES;
    _nameText.layer.borderColor = [[AOColorFormat colorWithHexString:@"#b5b5b5"]CGColor];
    _nameText.layer.borderWidth = 1.0f;
    [self.view addSubview:_nameText];
    
    _cardNumbers = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, _nameText.frame.origin.y + _nameText.frame.size.height + 50 * RATIOTYPE_HEIGHT, _name.frame.size.width, 20)];
    _cardNumbers.text = @"请输入银行卡号";
    _cardNumbers.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _cardNumbers.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_cardNumbers];
    
    _cardText = [[UITextField alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, _cardNumbers.frame.origin.y + _cardNumbers.frame.size.height + 30 * RATIOTYPE_HEIGHT, _nameText.frame.size.width, _nameText.frame.size.height)];
    _cardText.textColor = [AOColorFormat colorWithHexString:@"#4C4C4C"];
    _cardText.font = [UIFont systemFontOfSize:14];
    _cardText.layer.borderColor = [[AOColorFormat colorWithHexString:@"#b5b5b5"]CGColor];
    _cardText.layer.masksToBounds = YES;
    _cardText.layer.borderWidth = 1.0f;
    [self.view addSubview:_cardText];
    
    _openingBank = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, _cardText.frame.origin.y + _cardText.frame.size.height + 50 * RATIOTYPE_HEIGHT, kScreenWidth - 512 * RATIOTYPE_WIDTH - 30 * RATIOTYPE_WIDTH * 2, 72 * RATIOTYPE_HEIGHT)];
    _openingBank.text = @"选择开户行";
    _openingBank.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _openingBank.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_openingBank];
    
    _openingBankText = [[UITextField alloc]initWithFrame:CGRectMake(_openingBank.frame.origin.x + _openingBank.frame.size.width + 12 * RATIOTYPE_WIDTH, _openingBank.frame.origin.y, 500 * RATIOTYPE_WIDTH, 72 * RATIOTYPE_HEIGHT)];
    _openingBankText.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _openingBankText.font = [UIFont systemFontOfSize:14];
    _openingBankText.placeholder = @"请选择";
    _openingBankText.layer.masksToBounds = YES;
    _openingBankText.layer.borderColor = [[AOColorFormat colorWithHexString:@"#b5b5b5"]CGColor];
    _openingBankText.layer.borderWidth = 1.0f;
    [self.view addSubview:_openingBankText];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(_openingBankText.frame.size.width - 60*RATIOTYPE_WIDTH, 0, 60*RATIOTYPE_WIDTH, 72 * RATIOTYPE_HEIGHT);
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"bank"] forState:UIControlStateNormal];
    btn1.tag = 100;
//    btn1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bank"]];
    [_openingBankText addSubview:btn1];
    
    
    _location = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, _openingBank.frame.origin.y + _openingBank.frame.size.height + 50 * RATIOTYPE_HEIGHT, _openingBank.frame.size.width, 72 * RATIOTYPE_HEIGHT)];
    _location.text = @"开户所在地" ;
    _location.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _location.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_location];
    
    _addressText = [[UITextField alloc]initWithFrame:CGRectMake(_openingBankText.frame.origin.x, _openingBankText.frame.origin.y + _openingBankText.frame.size.height + 50 * RATIOTYPE_HEIGHT, _openingBankText.frame.size.width, 72 * RATIOTYPE_HEIGHT)];
    _addressText.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _addressText.font = [UIFont systemFontOfSize:14];
    _addressText.placeholder = @"请选择";
    _addressText.layer.masksToBounds = YES;
    _addressText.layer.borderWidth = 1.0f;
    _addressText.layer.borderColor = [[AOColorFormat colorWithHexString:@"#b5b5b5"]CGColor];
    [self.view addSubview:_addressText];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(_openingBankText.frame.size.width - 30, 0, 30, 72 * RATIOTYPE_HEIGHT);
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
//    btn2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bank"]];
    [btn2 setImage:[UIImage imageNamed:@"bank"] forState:UIControlStateNormal];
    btn2.tag = 200;
    [_addressText addSubview:btn2];
    
    
    _addressText2 = [[UITextField alloc]initWithFrame:CGRectMake(_addressText.frame.origin.x, _addressText.frame.origin.y + _addressText.frame.size.height + 30 * RATIOTYPE_HEIGHT, _addressText.frame.size.width, _addressText.frame.size.height)];
    _addressText2.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    _addressText2.font = [UIFont systemFontOfSize:14];
    _addressText2.placeholder = @"请选择";
    _addressText2.layer.masksToBounds = YES;
    _addressText2.layer.borderColor = [[AOColorFormat colorWithHexString:@"#b5b5b5"]CGColor];
    _addressText2.layer.borderWidth = 1.0f;
    [self.view addSubview:_addressText2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(_openingBankText.frame.size.width - 30, 0, 30, 72 * RATIOTYPE_HEIGHT);
    [btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:UIControlEventTouchUpInside];
//    btn3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bank"]];
    [btn3 setImage:[UIImage imageNamed:@"bank"] forState:UIControlStateNormal];
    btn3.tag = 300;
    [_addressText2 addSubview:btn3];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(30 * RATIOTYPE_WIDTH, _addressText2.frame.origin.y + _addressText2.frame.size.height + 106 * RATIOTYPE_HEIGHT, kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 100 *RATIOTYPE_HEIGHT);
    nextButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextButton addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30 * RATIOTYPE_WIDTH, nextButton.frame.size.height + nextButton.frame.origin.y, kScreenWidth - 2 * 30 * RATIOTYPE_WIDTH, 40)];
    label.text = @"请正确填写提取账户，您提取的保证金将退还到该账户";
    label.textColor = [AOColorFormat colorWithHexString: @"#808080"];
    label.font = [UIFont systemFontOfSize:13];
    
    //自动换行
//    label.lineBreakMode =UILineBreakModeWordWrap;
    label.numberOfLines = 0;

    [self.view addSubview:label];
    
}

-(void)drawAction:(UIButton *)button
{
    
    AffirmViewController * affirmVC = [[AffirmViewController alloc]init];

    [self.navigationController pushViewController:affirmVC animated:YES];
    
    affirmVC.nameString =_nameText.text;
    affirmVC.cardNumString = _cardText.text;
    affirmVC.openingBankString =_openingBankText.text;
    affirmVC.locationString = _addressText.text;
    affirmVC.stateString = _addressText2.text;
    
    if (_sign == 10000) {
        
        affirmVC.btnTitle = @"下一步";
    }else
    {
        affirmVC.btnTitle = @"确认";
    }
    
}

//// 数据请求
//-(void)createEditViewData
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    NSString *url = @"http://123.57.212.63/paimai/index.php?con=api&act=addAccount";
//    NSDictionary *parameters = @{@"holder":_nameText.text,@"cardnumber":_cardText.text,@"cardname":_cardText.text,@"provinces":_addressText.text,@"city":_addressText2,@"client_id":@"1001"};
//    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    
//    NSLog(@"%@",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//
//
//}
//下拉button
-(void)btn1Click:(UIButton *)btn
{
    NSLog(@"*******");
        if (btn.selected == NO) {
            [self createOpeningBankTableView];
            btn.selected = YES;
        }else{
            btn.selected =NO;
            _newTableView1.frame = CGRectMake(_openingBank.frame.origin.x + _openingBank.frame.size.width + 12 * RATIOTYPE_WIDTH, _openingBank.frame.origin.y,0, 0);
        }

}

-(void)btn2Click:(UIButton *)btn
{
    NSLog(@"*******");
    if (btn.selected == NO) {
        [self createBankLocationTableView];
        btn.selected = YES;
    }else{
        btn.selected =NO;
         _newTableView2.frame = CGRectMake(_openingBank.frame.origin.x + _openingBank.frame.size.width + 12 * RATIOTYPE_WIDTH, _openingBankText.frame.origin.y + _openingBankText.frame.size.height + 50 * RATIOTYPE_HEIGHT+72*RATIOTYPE_HEIGHT, 0, 0);
    }
    
}
-(void)btn3Click:(UIButton *)btn
{
    NSLog(@"*******");
    if (btn.selected == NO) {
        [self createBankRegionTableView];
        btn.selected = YES;
    }else{
        btn.selected =NO;
         _newTableView3.frame = CGRectMake(_openingBank.frame.origin.x + _openingBank.frame.size.width + 12 * RATIOTYPE_WIDTH, _openingBankText.frame.origin.y + _openingBankText.frame.size.height + 50 * RATIOTYPE_HEIGHT+72*RATIOTYPE_HEIGHT, 0, 0);
    }
    
}



//选择开户行下拉
-(void)createOpeningBankTableView
{
    NSString *plistpath = [[NSBundle mainBundle]pathForResource:@"bank" ofType:@"plist"];
    _titleArray = [[NSArray alloc]initWithContentsOfFile:plistpath];
    [UIView animateWithDuration:2 animations:^{
        _newTableView1 = [[UITableView alloc]initWithFrame:CGRectMake(_openingBank.frame.origin.x + _openingBank.frame.size.width + 12 * RATIOTYPE_WIDTH, _openingBank.frame.origin.y+72*RATIOTYPE_HEIGHT,  500 * RATIOTYPE_WIDTH,40*_titleArray.count) style:UITableViewStylePlain];
    }];

    _newTableView1.layer.borderWidth =0.8;
    _newTableView1.layer.borderColor = [AOColorFormat colorWithHexString:@"b5b5b5"].CGColor;
    _newTableView1.tag = 400;
    _newTableView1.delegate = self;
    _newTableView1.dataSource = self;
    [self.view addSubview:_newTableView1];
}
//开户所在地省份
-(void)createBankLocationTableView
{
    NSString *plistpath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    cityArray = [[NSArray alloc]initWithContentsOfFile:plistpath];
    
    for (NSDictionary *dict in cityArray) {
        _citiesArray = [dict objectForKey:@"cities"];
        //        [_stateArray addObject:[dict objectForKey:@"state"]];
        NSString *cityKey = [dict objectForKey:@"state"];
        [cityDict setObject:_citiesArray forKey:cityKey];
        NSLog(@"%@",cityDict);
    }

    [UIView animateWithDuration:2 animations:^{
        _newTableView2 = [[UITableView alloc]initWithFrame:CGRectMake(_openingBankText.frame.origin.x,  _openingBankText.frame.origin.y + _openingBankText.frame.size.height + 50 * RATIOTYPE_HEIGHT+72*RATIOTYPE_HEIGHT,  500 * RATIOTYPE_WIDTH,40*[cityDict allKeys].count) style:UITableViewStylePlain];
    }];
    
    _newTableView2.layer.borderWidth =0.8;
    _newTableView2.layer.borderColor = [AOColorFormat colorWithHexString:@"b5b5b5"].CGColor;
    _newTableView2.tag = 500;
    _newTableView2.delegate = self;
    _newTableView2.dataSource = self;
    [self.view addSubview:_newTableView2];
    
}
//开户所在区域
-(void)createBankRegionTableView
{
    [UIView animateWithDuration:2 animations:^{
        _newTableView3 = [[UITableView alloc]initWithFrame:CGRectMake(_openingBankText.frame.origin.x,   _addressText.frame.origin.y + _addressText.frame.size.height + 30 * RATIOTYPE_HEIGHT+72*RATIOTYPE_HEIGHT,  500 * RATIOTYPE_WIDTH,40*townArray.count) style:UITableViewStylePlain];
    }];
    
    _newTableView3.layer.borderWidth =0.8;
    _newTableView3.layer.borderColor = [AOColorFormat colorWithHexString:@"b5b5b5"].CGColor;
    _newTableView3.tag = 600;
    _newTableView3.delegate = self;
    _newTableView3.dataSource = self;
    [self.view addSubview:_newTableView3];

}

#pragma mark - UITableView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==400 ) {
        return 40*RATIOTYPE_HEIGHT;

    }else if (tableView.tag == 500){
        return 40*RATIOTYPE_HEIGHT;
    }else{
        return 40*RATIOTYPE_HEIGHT;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 400) {
        return _titleArray.count;

    }else if (tableView.tag == 500){
        
        return [cityDict allKeys].count;

    }else{
        
        return townArray.count;

    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 400) {
        static NSString *cellName = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.textLabel.text =_titleArray[indexPath.row];
        cell.selectedBackgroundView.backgroundColor = [UIColor blueColor];
        return cell;
    }else if (tableView.tag == 500){
    
        static NSString *cellName = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.textLabel.text = [cityDict allKeys][indexPath.row];
        return cell;
    
    }else{
        static NSString *cellName = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text =townArray[indexPath.row];
        return cell;
    
    }
    
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag == 400) {
        _openingBankText.text = _titleArray[indexPath.row];
        [_newTableView1 removeFromSuperview];

    }else if (tableView.tag == 500){
        _addressText.text = [cityDict allKeys][indexPath.row];
        townArray = [cityDict objectForKey:_addressText.text];
        [_newTableView3 reloadData];
        [_newTableView2 removeFromSuperview];
    }else{
        
        _addressText2.text = townArray[indexPath.row];
        [_newTableView3 removeFromSuperview];
    }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
