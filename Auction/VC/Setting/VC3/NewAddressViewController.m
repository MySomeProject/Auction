//
//  NewAddressViewController.m
//  YOU WATCH－Auction
//
//  Created by 葛宾霞151 on 15/7/9.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "NewAddressViewController.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "AddressViewController.h"
#import "AppStatus.h"
#import "HZAreaPickerView.h"
#import "AFNetworking.h"

@interface NewAddressViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,HZAreaPickerDelegate>

{
    
    NSArray *address;
    UILabel *alterLabel;
    NSMutableArray *addressText;
    
    UIButton *bgView;
    UIButton *alterBtn;

    
    //存放数据
    NSMutableArray *_dataArray;
    
    //传递省市区的数据
    NSString *provice;
    NSString *city;
    NSString *county;
    
}


@end

@implementation NewAddressViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleStr ;
    self.view.backgroundColor = [UIColor whiteColor];
    
    address = @[@"收货人姓名",@"手机",@"所在地区",@"详细地址"];

    addressText = [[NSMutableArray alloc]init];
    

    [self createTabItemLeftButton];
    [self createView];
}

#pragma mark --- 返回按钮的自定义
-(void)createTabItemLeftButton
{
    UIButton *leftButton = [ZYControl createButtonWithFrame:CGRectMake(0, 24,9,17) ImageName:@"返回@2x.png" Target:self Action:@selector(leftButtonClick:) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];   
}

-(void)leftButtonClick:(UIButton *)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 加载数据
#pragma mark --- 添加收货地址的接口
-(void)createAddData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameter = @{@"client_id":[user objectForKey:@"client_id"],@"province":provice,@"city":city,@"county":county,@"accept_name":_textMassage.text,@"mobile":_textMassage1.text,@"is_default":@"1",@"addr":_textMassage3.text};
    
    NSString *url = @"http://123.57.212.63/paimai/index.php?con=Api&act=addAddress";
    
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"成功返回数据＊＊＊%@   %@ %@ %@ %@ %@",responseObject ,provice,city,county,_textMassage.text,_textMassage3.text);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据返回失败＊＊＊%@",operation.error);
    }];
}

#pragma mark --- 编辑收货地址的接口
-(void)createEditData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameter = @{@"id":[_neDic objectForKey:@"id"],@"client_id":[user objectForKey:@"client_id"],@"province":provice,@"city":city,@"county":county,@"accept_name":_textMassage.text,@"mobile":_textMassage1.text,@"is_default":@"1",@"addr":_textMassage3.text};
    NSString *url1 = @"http://123.57.212.63/paimai/index.php?con=Api&act=addAddress";
    [manager POST:url1 parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"成功返回数据＊＊＊＊%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据返回失败＊＊＊＊%@",operation.error);
    }];

}

-(void)alterAction:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark --- 创建页面
//添加按钮的定义
-(void)createView
{
    _textMassage = [[UITextField alloc]initWithFrame:CGRectMake(15, 64, kScreenWidth - 30, 100 *RATIOTYPE_HEIGHT)];
    _textMassage.placeholder = @"收货人姓名";
    _textMassage.font = [UIFont systemFontOfSize:16];
    _textMassage.tag = 10;
    _textMassage.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_textMassage];

    
    _textMassage1 = [[UITextField alloc]initWithFrame:CGRectMake(15, _textMassage.frame.size.height + _textMassage.frame.origin.y + 1, kScreenWidth - 30, 100 *RATIOTYPE_HEIGHT)];
    _textMassage1.placeholder = @"手机";
    _textMassage1.font = [UIFont systemFontOfSize:16];
    _textMassage.tag = 11;
    _textMassage1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textMassage1.keyboardType = UIKeyboardTypeDecimalPad;
//    _textMassage1.delegate = self;
    [self.view addSubview:_textMassage1];

    
    _textMassage2 = [[UITextField alloc]initWithFrame:CGRectMake(15, _textMassage1.frame.size.height + _textMassage1.frame.origin.y + 1, kScreenWidth - 30, 100 *RATIOTYPE_HEIGHT)];
    _textMassage2.placeholder = @"所在地区";
    _textMassage2.font = [UIFont systemFontOfSize:16];
    _textMassage.tag = 12;
    _textMassage2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textMassage2.delegate = self;
    [self.view addSubview:_textMassage2];

    
    _textMassage3 = [[UITextField alloc]initWithFrame:CGRectMake(15, _textMassage2.frame.size.height + _textMassage2.frame.origin.y + 1, kScreenWidth - 30, 100 *RATIOTYPE_HEIGHT)];
    _textMassage3.placeholder = @"详细地址";
    _textMassage3.font = [UIFont systemFontOfSize:16];
    _textMassage.tag = 13;
    _textMassage3.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_textMassage3];
    
    for (int i = 0; i < 4; i ++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, _textMassage.frame.size.height + _textMassage.frame.origin.y + i * (_textMassage.frame.size.height + 1), kScreenWidth - 30, 1)];
        line.backgroundColor = [AOColorFormat colorWithHexString:@"#d9d9d9"];
        [self.view addSubview:line];
    }

    if ([_titleStr isEqualToString:@"编辑收货地址"])
    {
        
        _textMassage.text =[_neDic objectForKey:@"accept_name"];
        _textMassage1.text = [_neDic objectForKey:@"mobile"];
        _textMassage2.text = [NSString stringWithFormat:@"%@%@%@",[_neDic objectForKey:@"province"],[_neDic objectForKey:@"city"],[_neDic objectForKey:@"county"]];
        _textMassage3.text = [_neDic objectForKey:@"addr"];
        
    }
   
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(30 * RATIOTYPE_WIDTH ,_textMassage3.frame.size.height + _textMassage3.frame.origin.y + 100 * RATIOTYPE_HEIGHT , kScreenWidth - 30 * RATIOTYPE_WIDTH * 2, 100 * RATIOTYPE_HEIGHT);
    addButton.backgroundColor = [AOColorFormat colorWithHexString:@"#c70065"];
    [addButton setTitle:_btnTitle forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addButton addTarget:self action:@selector(drawAction11:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addButton];
}
//点击添加按钮需要执行的方法
-(void)drawAction11:(UIButton *)button
{
    if (_textMassage.text.length == 0 || [_textMassage.text isEqualToString:@"收货人姓名"]||_textMassage1.text.length == 0 || [_textMassage1.text isEqualToString:@"手机"]||_textMassage2.text.length == 0 || [_textMassage2.text isEqualToString:@"所在地区"]||_textMassage3.text.length == 0 || [_textMassage3.text isEqualToString:@"详细地址"])
    {
        bgView = [UIButton buttonWithType:UIButtonTypeCustom];
        bgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.5;
        [self.view addSubview:bgView];
        
        alterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        alterBtn.frame = CGRectMake((kScreenWidth - 500 *RATIOTYPE_WIDTH)/2,400 * RATIOTYPE_HEIGHT, 500 * RATIOTYPE_WIDTH, 200 * RATIOTYPE_HEIGHT) ;
        alterBtn.backgroundColor = [UIColor whiteColor];
        alterBtn.alpha = 1;
        [alterBtn addTarget:self action:@selector(alterAction4:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:alterBtn];
        
        UIImageView *alterImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, (200 * RATIOTYPE_HEIGHT - 20)/2, 20, 20)];
        alterImage.image = [UIImage imageNamed:@"提示"];
        [alterBtn addSubview:alterImage];
        
        alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, (200 * RATIOTYPE_HEIGHT - 20)/2, 500 * RATIOTYPE_WIDTH-30 - 20, 20)];
        alterLabel.text = @"请完善您的收货信息！";
        alterLabel.textAlignment = NSTextAlignmentCenter;
        alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
        alterLabel.font = [UIFont systemFontOfSize:15];
        [alterBtn addSubview:alterLabel];
        
    }else
    {
    
    bgView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    
    alterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    alterBtn.frame = CGRectMake((kScreenWidth - 500 *RATIOTYPE_WIDTH)/2,200 *RATIOTYPE_HEIGHT, 500 * RATIOTYPE_WIDTH, 200 * RATIOTYPE_HEIGHT) ;
    alterBtn.backgroundColor = [UIColor whiteColor];
    alterBtn.alpha = 1;
    [alterBtn addTarget:self action:@selector(alterAction4:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alterBtn];
    
    
    alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, (120 * RATIOTYPE_HEIGHT)/2, 500 *RATIOTYPE_WIDTH-30 - 20, 20)];
    alterLabel.textAlignment = NSTextAlignmentCenter;
    alterLabel.textColor = [AOColorFormat colorWithHexString:@"#4c4c4c"];
    alterLabel.font = [UIFont systemFontOfSize:14];
    [alterBtn addSubview:alterLabel];
    
    if ([_btnTitle isEqualToString:@"添加"]) {
        alterLabel.text = @"添加成功";
        [self createAddData];
    }else if ([_btnTitle isEqualToString:@"编辑完成"])
    {
        alterLabel.text = @"您的收货地址修改完成";
        [self createEditData];
    }
    }
}
//添加成功按钮的执行的方法
-(void)alterAction4:(UIButton *)button
{
        if ([alterLabel.text isEqualToString:@"添加成功"]||[alterLabel.text isEqualToString:@"您的收货地址修改完成"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [bgView removeFromSuperview];
            [alterBtn removeFromSuperview];
        }
}

#pragma mark --- PickerViewDelegate,PickerViewDatasourse
-(void)setCityValue:(NSString *)cityValue
{
    if (![_cityValue isEqualToString:cityValue]) {
        _textMassage2.text = cityValue;
    }
}
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
//    if ([_cityValue isEqualToString:@""]) {
//        picker.locate.state = @"北京";
//        picker.locate.city = @"通州";
//        picker.locate.district = @"";
//        _textMassage2.text = [NSString stringWithFormat:@"%@%@%@",picker.locate.state,picker.locate.city,picker.locate.district];
//        
//    }else
//    {
//        picker.locate.state = [_neDic objectForKey:@"province"];
//        picker.locate.city = [_neDic objectForKey:@"city"];
//        picker.locate.district = [_neDic objectForKey:@"county"];
//        
//        NSLog(@"%@%@%@",picker.locate.state,picker.locate.city,picker.locate.district);
//        
//        _textMassage2.text = [NSString stringWithFormat:@"%@%@%@",picker.locate.state,picker.locate.city,picker.locate.district];
//        
//    }
    
    self.cityValue = [NSString stringWithFormat:@"%@ %@ %@",picker.locate.state,picker.locate.city,picker.locate.district];
    provice = picker.locate.state;
    city = picker.locate.city;
    county = picker.locate.district;
    
}

-(void)cancelLocatePicker
{
    [self.cityPicker cancelPicker];
    self.cityPicker.delegate = nil;
    self.cityPicker = nil;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    for (UITextField *tf in [self.view subviews]) {
        
        if (tf.tag != 12) {
            [tf resignFirstResponder];
        }
    }

    if ([textField isEqual:_textMassage2]) {

        [self cancelLocatePicker];
        self.cityPicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
        [self.cityPicker showInView:self.view];
    }
    
    
    return NO;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self cancelLocatePicker];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_textMassage2) {
        [super touchesBegan:touches withEvent:event];
        [self cancelLocatePicker];

    }else
    {
        [self.view endEditing:YES];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag == 11) {
        NSInteger strlength = textField.text.length - range.length + string.length;
        if (strlength > 11) {
            return NO;
        }
        NSString *text = nil;
        
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }else
        {
            text = [textField.text substringToIndex:range.location];
        }
        
    }
    if (textField.tag == 12) {
        if ([textField isEqual:self.cityValue]) {

        }
    }
    
    return YES;
}


@end