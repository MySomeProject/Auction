//
//  OfferRecordCell.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/31.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "OfferRecordCell.h"
#import "ZYControl.h"
#import "AOColorFormat.h"



@implementation OfferRecordCell
{
    UILabel *leaderLabel;
    UILabel *weedOutLabel;
    UILabel *phoneLabel;
    UILabel *priceLabel;
    UILabel *dateLabel;
    UILabel *timeLabel;
    
}
-(void)setModel:(OfferPriceRecordModel *)model
{
    _model = model;
    phoneLabel.text = model.username;
    priceLabel.text = model.put_price;
    
    //时间戳转标准时间
    NSString * timeStampString = [NSString stringWithFormat:@"%@",model.add_time];
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *dateString = [objDateformat stringFromDate: date];
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@" "] ;
    NSArray * array1 = [dateString componentsSeparatedByCharactersInSet:set];
    
    dateLabel.text  = array1[0];
    timeLabel.text = array1[1];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        phoneLabel = [ZYControl createLabelWithFrame:CGRectMake((40/375.0)*kScreenWidth+40+(20/375.0)*kScreenWidth,(20/667.0)*kScreenHeight+((20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight)*0, 100, 20) Font:12 Text:nil ];
        phoneLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self addSubview:phoneLabel];
        
        priceLabel = [ZYControl createLabelWithFrame:CGRectMake((40/375.0)*kScreenWidth+40+(20/375.0)*kScreenWidth+(60/375.0)*kScreenWidth+(10/375.0)*kScreenWidth, (20/667.0)*kScreenHeight+((20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight)*0, 100, 20) Font:12 Text:nil ];
        priceLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:priceLabel];
        
        
        //创建日期
        dateLabel = [ZYControl createLabelWithFrame:CGRectMake((40/375.0)*kScreenWidth+40+(20/375.0)*kScreenWidth+(60/375.0)*kScreenWidth+(10/375.0)*kScreenWidth+(60/375.0)*kScreenWidth+(40/375.0)*kScreenWidth,(20/667.0)*kScreenHeight+((20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight)*0, 100, 20) Font:12 Text:@"6 月 13 日"];
        dateLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:dateLabel];
        
        //竞拍时间
        timeLabel = [ZYControl createLabelWithFrame:CGRectMake((40/375.0)*kScreenWidth+40+(20/375.0)*kScreenWidth+(60/375.0)*kScreenWidth+(10/375.0)*kScreenWidth+(60/375.0)*kScreenWidth+(40/375.0)*kScreenWidth,(20/667.0)*kScreenHeight+(22/667.0)*kScreenWidth+((20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight+(20/667.0)*kScreenHeight)*0, 100, 20) Font:12 Text:@"09:00:00"];
        timeLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:timeLabel];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
