//
//  HomeCell.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/7/6.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "HomeCell.h"
#import "ZYControl.h"
#import "AOColorFormat.h"
#import "UIImageView+WebCache.h"
@implementation HomeCell
{
    
    UILabel *bigLable;
    UILabel *midLable;
    UILabel *midRightLabel;
    UILabel *downLeftLable;
    UILabel *downRightLable;
    UILabel *rightLable;
    UIImageView *rightDownImageView;
    UIImageView *pictureImageView;
    //创建时间lable
    UILabel *hourLable;
    UILabel *minuteLable;
    UILabel *secondLable;
    UILabel *timeLabel;
    //    NSTimer *timer;
    int count;
    int number;
    int minCount;
    int hourCount;
    int min;
    int hour;
    
}

-(void)setModel:(HomeModel *)model
{
    _model = model;
    bigLable.text = model.spec_name;
    midLable.text = model.inst_name;
    midRightLabel.text = model.auct_count;
    downLeftLable.text = model.auction_peoples;
    downRightLable.text = model.auction_number;
    //    timeLabel.text = model.showTime;
    //距离结束时间
    if ([model.start_time doubleValue] > [model.now_time doubleValue]) {
        rightLable.text = @"今日开拍时间";
        hourLable.text = @"10";
        minuteLable.text = @"00";
        secondLable.text = @"00";
        
        //        double _interval = [model.start_time doubleValue] - [model.now_time doubleValue];
        //        NSString * timeStampString = [NSString stringWithFormat:@"%f",_interval];
        //        NSTimeInterval _interval2=[timeStampString doubleValue];
        //        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval2];
        //        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        //        [objDateformat setDateFormat:@"HH:mm:ss"];
        //        model.showTime = [objDateformat stringFromDate: date];
        //        NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@" :"] ;
        //        NSArray * array1 = [model.showTime componentsSeparatedByCharactersInSet:set];
        //        hourLable.text = array1[0];
        //        minuteLable.text = array1[1];
        //        secondLable.text = array1[2];
        
        //        //        static  int count;
        //        for (int i = 0; i<array1.count; i++) {
        //            if (i == 0) {
        //                number  = [array1[0] intValue]*60*60;
        //            }else if (i == 1)
        //            {
        //                number += [array1[1]intValue]*60;
        //            }
        //            else if (i == 2)
        //            {
        //                number += [array1[2]intValue];
        //            }
        //        }
        //        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        //        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //        count = [secondLable.text intValue];
        //        min = [minuteLable.text intValue];
        //        hour = [minuteLable.text intValue];
        
    }else if ([model.end_time doubleValue] > [model.now_time doubleValue]){
        rightLable.text = @"距离结束时间";
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
    }
    if (model.spec_image.length == 0) {
        pictureImageView.image = [UIImage imageNamed:@"340*156-01（首页预告图）.png"];
    }else{
        
        [pictureImageView sd_setImageWithURL:[NSURL URLWithString:model.spec_image]];
        
    }
    
    
}


-(void)timeFireMethod{
    secondLable.text = [NSString stringWithFormat:@"%02d",count-1];
    count--;
    if (min == 0&&hour==0) {
        if (count == 0) {
            [self.timer invalidate];
        }
    }
    
    if (hour == 0&&min!=0) {
        if (count == 0) {
            count = 60;
            //            [self timeFireMethod];
            minuteLable.text  = [NSString stringWithFormat:@"%02d",min-1];
            if (min==0) {
                [self.timer invalidate];
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
        bigLable = [ZYControl createLabelWithFrame:CGRectMake(30*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT, 380*RATIOTYPE_WIDTH,50*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        bigLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [self.contentView addSubview:bigLable];
        
        midLable = [ZYControl createLabelWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, CGRectGetMaxY(bigLable.frame),100*RATIOTYPE_WIDTH,50*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        midLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:midLable];
        
        midRightLabel = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(midLable.frame), CGRectGetMaxY(bigLable.frame), 200*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        midRightLabel.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:midRightLabel];
        
        downLeftLable = [ZYControl createLabelWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, CGRectGetMaxY(midLable.frame)-10*RATIOTYPE_HEIGHT, 125*RATIOTYPE_WIDTH, 70*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        downLeftLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:downLeftLable];
        
        downRightLable = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(downLeftLable.frame)+20*RATIOTYPE_WIDTH, CGRectGetMaxY(midLable.frame)-10*RATIOTYPE_HEIGHT, 125*RATIOTYPE_WIDTH, 70*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        downRightLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:downRightLable];
        
        rightLable =[ZYControl createLabelWithFrame:CGRectMake(kScreenWidth-100*RATIOTYPE_WIDTH-180*RATIOTYPE_WIDTH,50*RATIOTYPE_HEIGHT, 180*RATIOTYPE_WIDTH, 40*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        rightLable.textColor = [AOColorFormat colorWithHexString:@"4c4c4c"];
        [self.contentView addSubview:rightLable];
        
        //        for (int i  =0; i <3; i++) {
        //            rightDownImageView = [ZYControl createImageViewWithFrame:CGRectMake(kScreenWidth-312*RATIOTYPE_WIDTH, CGRectGetMaxY(bigLable.frame)+10*RATIOTYPE_HEIGHT,232*RATIOTYPE_WIDTH, 55*RATIOTYPE_HEIGHT) ImageName:@"倒计时@2x.png"];
        //            [self.contentView addSubview:rightDownImageView];
        //        }
        rightDownImageView = [ZYControl createImageViewWithFrame:CGRectMake(kScreenWidth-312*RATIOTYPE_WIDTH, CGRectGetMaxY(bigLable.frame)+10*RATIOTYPE_HEIGHT,232*RATIOTYPE_WIDTH, 55*RATIOTYPE_HEIGHT) ImageName:@"倒计时@3x.png"];
        [self.contentView addSubview:rightDownImageView];
        
        /**************显示时间*******************/
        //        timeLabel = [ZYControl createLabelWithFrame:CGRectMake(5*RATIOTYPE_WIDTH, 0,800*RATIOTYPE_WIDTH, 55*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        //        [rightDownImageView addSubview:timeLabel];
        
        hourLable = [ZYControl createLabelWithFrame:CGRectMake(1*RATIOTYPE_WIDTH,2*RATIOTYPE_HEIGHT,70*RATIOTYPE_WIDTH,50*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        hourLable.textAlignment =NSTextAlignmentCenter;
        [rightDownImageView addSubview:hourLable];
        
        minuteLable = [ZYControl createLabelWithFrame:CGRectMake(80*RATIOTYPE_WIDTH,1*RATIOTYPE_HEIGHT, 70*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        minuteLable.textAlignment = NSTextAlignmentCenter;
        [rightDownImageView addSubview:minuteLable];
        secondLable = [ZYControl createLabelWithFrame:CGRectMake(165*RATIOTYPE_WIDTH, 1*RATIOTYPE_HEIGHT, 70*RATIOTYPE_WIDTH, 50*RATIOTYPE_HEIGHT) Font:16 Text:nil];
        secondLable.textAlignment = NSTextAlignmentCenter;
        [rightDownImageView addSubview:secondLable];
        
        [self.contentView addSubview:rightDownImageView];
        
        pictureImageView = [ZYControl createImageViewWithFrame:CGRectMake(30*RATIOTYPE_WIDTH, CGRectGetMaxY(downLeftLable.frame)-10*RATIOTYPE_HEIGHT, kScreenWidth-60*RATIOTYPE_WIDTH, 300*RATIOTYPE_HEIGHT) ImageName:nil];
        [self.contentView addSubview:pictureImageView];
        
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
