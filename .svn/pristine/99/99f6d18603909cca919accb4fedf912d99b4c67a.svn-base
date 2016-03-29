//
//  SubmitSecurityPaymentsCell.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/4.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "SubmitSecurityPaymentsCell.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
@implementation SubmitSecurityPaymentsCell
{
    UILabel *unionPaymentLabel;
    UIButton *selectButton;
    UILabel *alipayLabel;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        unionPaymentLabel = [ZYControl createLabelWithFrame:CGRectMake(10/375.0*kScreenWidth,40/667.0*kScreenHeight+44, 100/375.0*kScreenWidth, 20/667.0*kScreenHeight) Font:20 Text:@"银联支付"];
        unionPaymentLabel.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [self.contentView addSubview:unionPaymentLabel];
        
        //设置button
        selectButton =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2+130/375.0*kScreenWidth, 40/667.0*kScreenHeight+44, 18/375.0*kScreenWidth, 18/667.0*kScreenHeight)];
        [selectButton setBackgroundImage:[UIImage imageNamed:@"未选中状态@2x.png"]forState:UIControlStateNormal];
        [selectButton setBackgroundImage:[UIImage imageNamed:@"选择状态按钮@2x.png"] forState:UIControlStateSelected];
        [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectButton];
    }
    return self;
}

-(void)selectButtonClick:(UIButton *)btn
{



}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
