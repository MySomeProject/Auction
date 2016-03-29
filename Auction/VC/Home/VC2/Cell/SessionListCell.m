//
//  SessionListCell.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "SessionListCell.h"
#import "AOColorFormat.h"
#import "UIImageView+WebCache.h"
#import "ZYControl.h"
@implementation SessionListCell
{
    UILabel *bigLable;
    UILabel *midLable;
    UILabel *midRightLabel;
    UILabel *downLeftLable;
    UILabel *downRightLable;
    UILabel *rightLable;
    UIImageView *rightDownImageView;
    UIImageView *pictureImageView;
    UILabel *timeLabel;
    //创建时间lable
    UILabel *hourLable;
    UILabel *minuteLable;
    UILabel *secondLable;
    //    NSTimer *timer;
    int count;
    int number;
    int minCount;
    int hourCount;
    int min;
    int hour;
    NSString *timeStr;
    NSString *time;
    
    
    UIButton *endButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.typeStringArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setModel:(SessionListModel *)model
{
    _model = model;
    bigLable.text = model.spec_name;
    midLable.text = model.inst_name;
    midRightLabel.text = model.auct_count;
    downLeftLable.text = model.auction_peoples;
    downRightLable.text = model.auction_number;
    
    timeStr = kappDelegate.timeStr;
    double _interval = [timeStr doubleValue];
    NSString * timeStampString = [NSString stringWithFormat:@"%f",_interval];
    NSTimeInterval _interval1=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval1];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"M-dd"];
    
    //创建一个时间戳
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"M-dd";
    
    //获取当前系统时间
    NSDate *dateToday = [NSDate date];
    //以当前时间为准，然后过了sec秒后的时间
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    
//    NSString *dateString = [df stringFromDate:dateToday];
//    NSString *dateString1 = [df stringFromDate:tomorrowDate];
//    if ([time isEqualToString:dateString]) {
//        time = @"今日";
//    }else if ([time isEqualToString:dateString1]){
//        time = @"明日";
//    }else
    time = [objDateformat stringFromDate: date];
    
    
    //距离结束时间
    if ([model.start_time doubleValue] > [model.now_time doubleValue]) {
        
        NSString *dateString = [df stringFromDate:dateToday];
        NSString *dateString1 = [df stringFromDate:tomorrowDate];
        if ([time isEqualToString:dateString]) {
            time = @"今日";
        }else if ([time isEqualToString:dateString1]){
            time = @"明日";
        }

        rightLable.text = [NSString stringWithFormat:@"%@开拍时间",time];
        hourLable.text = @"10";
        minuteLable.text = @"00";
        secondLable.text = @"00";
        
        self.typeString = @"2";
        //[self.typeStringArray addObject:self.typeString];
    }else if ([model.end_time doubleValue] > [model.now_time doubleValue]){
        rightLable.text = @"距离结束时间";
        [endButton setTitle:@"" forState:UIControlStateNormal];
        double _interval = [model.end_time doubleValue] - [model.now_time doubleValue];
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
        
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        count = [secondLable.text intValue];
        min = [minuteLable.text intValue];
        hour = [hourLable.text intValue];
        self.typeString = @"2";
        [self.typeStringArray addObject:self.typeString];
        
    }else if([model.end_time doubleValue] -[model.now_time doubleValue] == 0){
        
        hourLable.text = @"";
        minuteLable.text = @"";
        secondLable.text = @"";
        [endButton setTitle:@"已   结    束" forState:UIControlStateNormal];
        self.typeString = @"1";
        [self.typeStringArray addObject:self.typeString];
        
        
    }
    if (model.spec_image.length == 0) {
        pictureImageView.image = [UIImage imageNamed:@"690*300-01(专场图).png"];
    }else{
        
        [pictureImageView sd_setImageWithURL:[NSURL URLWithString:model.spec_image]];
        
    }
    
}

//已结束
-(void)complete
{
    [hourLable removeFromSuperview];
    [minuteLable removeFromSuperview];
    [secondLable removeFromSuperview];
    [rightLable removeFromSuperview];
    [rightDownImageView removeFromSuperview];
    UIButton *button = [ZYControl createButtonWithFrame:CGRectMake(kScreenWidth-262*RATIOTYPE_WIDTH,CGRectGetMaxY(rightLable.frame)+20*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,55*RATIOTYPE_HEIGHT)ImageName:nil Target:nil Action:nil Title:@"已结束"];
    
    [button setTitleColor:[AOColorFormat colorWithHexString:@"4c4c4c"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:button];
    
}


-(void)timeFireMethod{
    secondLable.text = [NSString stringWithFormat:@"%02d",count-1];
    count--;
    if (min == 0&&hour==0) {
        if (count == 0) {
            [self.timer invalidate];
            //            [self complete];
            hourLable.text = @"";
            minuteLable.text = @"";
            secondLable.text = @"";
            [endButton setTitle:@"已   结    束" forState:UIControlStateNormal];
            
        }
    }
    
    if (hour == 0&&min!=0) {
        if (count == 0) {
            count = 60;
            //            [self timeFireMethod];
            minuteLable.text  = [NSString stringWithFormat:@"%02d",min-1];
            if (min==0) {
                [self.timer invalidate];
                //                [self complete];
                hourLable.text = @"";
                minuteLable.text = @"";
                secondLable.text = @"";
                [endButton setTitle:@"已   结    束" forState:UIControlStateNormal];
            }
            min--;
        }
    }
    if (hour !=0) {
        if (count == 0) {
            count = 60;
            
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
                        [self.timer invalidate];
                        hourLable.text = @"";
                        minuteLable.text = @"";
                        secondLable.text = @"";
                        [endButton setTitle:@"已   结    束" forState:UIControlStateNormal];
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
                        [self.timer invalidate];
                        hourLable.text = @"";
                        minuteLable.text = @"";
                        secondLable.text = @"";
                        [endButton setTitle:@"已   结    束" forState:UIControlStateNormal];
                    }
                }
            }
            
            
        }
        
    }
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bigLable = [[UILabel alloc]initWithFrame:CGRectMake(30*RATIOTYPE_WIDTH,30*RATIOTYPE_HEIGHT, 350*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT)];
        bigLable.font = [UIFont systemFontOfSize:14];
        bigLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [self.contentView addSubview:bigLable];
        
        midLable = [[UILabel alloc]initWithFrame:CGRectMake(30*RATIOTYPE_WIDTH,CGRectGetMaxY(bigLable.frame),380*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT)];
        midLable.font = [UIFont systemFontOfSize:14];
        midLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:midLable];
        midRightLabel = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(midLable.frame)-100*RATIOTYPE_WIDTH, CGRectGetMaxY(bigLable.frame), 200*RATIOTYPE_WIDTH, 35*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        midRightLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:midRightLabel];
        
        downLeftLable = [[UILabel alloc]initWithFrame:CGRectMake(30*RATIOTYPE_WIDTH,CGRectGetMaxY(midLable.frame),150*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT)];
        downLeftLable.font= [UIFont systemFontOfSize:12];
        downLeftLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:downLeftLable];
        
        downRightLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(downLeftLable.frame)+40*RATIOTYPE_WIDTH,CGRectGetMaxY(midLable.frame),150*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT)];
        downRightLable.font = [UIFont systemFontOfSize:12];
        downRightLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:downRightLable];
        
        rightLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bigLable.frame)+150*RATIOTYPE_WIDTH,30*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,30*RATIOTYPE_HEIGHT)];
        //        rightLable.text = @"距离结束还有";
        rightLable.font = [UIFont systemFontOfSize:12];
        rightLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        
        rightLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:rightLable];
        
        rightDownImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-262*RATIOTYPE_WIDTH,CGRectGetMaxY(rightLable.frame)+20*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,55*RATIOTYPE_HEIGHT)];
        rightDownImageView.image = [UIImage imageNamed:@"倒计时@3x.png"];
        [self.contentView addSubview:rightDownImageView];
        /**************显示时间*******************/
        //        timeLabel = [ZYControl createLabelWithFrame:CGRectMake(10*RATIOTYPE_WIDTH, 2*RATIOTYPE_HEIGHT, 200*RATIOTYPE_WIDTH, 55*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        //        timeLabel.backgroundColor = [UIColor redColor];
        //        [rightDownImageView addSubview:timeLabel];
        
        //创建时间表
        hourLable = [[UILabel alloc]initWithFrame:CGRectMake(-10*RATIOTYPE_WIDTH,2*RATIOTYPE_HEIGHT,70*RATIOTYPE_WIDTH,50*RATIOTYPE_HEIGHT)];
        hourLable.font = [UIFont systemFontOfSize:16];
        hourLable.textAlignment = NSTextAlignmentCenter;
        [rightDownImageView addSubview:hourLable];
        
        minuteLable = [[UILabel alloc]initWithFrame:CGRectMake(70*RATIOTYPE_WIDTH,1*RATIOTYPE_HEIGHT,70*RATIOTYPE_WIDTH,50*RATIOTYPE_HEIGHT)];
        minuteLable.font = [UIFont systemFontOfSize:16];
        minuteLable.textAlignment = NSTextAlignmentCenter;
        [rightDownImageView addSubview:minuteLable];
        
        secondLable = [[UILabel alloc]initWithFrame:CGRectMake(135*RATIOTYPE_WIDTH,1*RATIOTYPE_HEIGHT,70*RATIOTYPE_WIDTH,50*RATIOTYPE_WIDTH)];
        secondLable.font  =[UIFont systemFontOfSize:16];
        secondLable.textAlignment = NSTextAlignmentCenter;
        [rightDownImageView addSubview:secondLable];
        
        pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*RATIOTYPE_WIDTH,CGRectGetMaxY(downLeftLable.frame)+10*RATIOTYPE_HEIGHT,kScreenWidth-60*RATIOTYPE_WIDTH,300*RATIOTYPE_HEIGHT)];
        //        pictureImageView.image = [UIImage imageNamed:@"headPoster4.jpg"];
        [self.contentView addSubview:pictureImageView];
        
        endButton = [ZYControl createButtonWithFrame:CGRectMake(kScreenWidth-262*RATIOTYPE_WIDTH,CGRectGetMaxY(rightLable.frame)+20*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,55*RATIOTYPE_HEIGHT)ImageName:nil Target:nil Action:nil Title:nil];
        
        [endButton setTitleColor:[AOColorFormat colorWithHexString:@"4c4c4c"] forState:UIControlStateNormal];
        endButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:endButton];
        
        
    }
    return self;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
