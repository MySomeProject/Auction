//
//  PatProduceCell.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/6/30.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "PatProduceCell.h"
#import "AOColorFormat.h"
#import "ZYControl.h"
#import "UIImageView+WebCache.h"

@implementation PatProduceCell
{
    UIImageView *leftImageView;
    UILabel *rightUpLabel;
    UILabel *rightDownLeftLable;
    UILabel *rightDownRightLable;

}
-(void)setModel:(PatProduceModel *)model
{
    _model = model;
    if (model.img.length == 0) {
        leftImageView.image = [UIImage imageNamed:@"230*230-01（拍品列表图）.png"];
    }else{
    
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
   }
    
    rightUpLabel.text = model.auct_title;
    rightDownLeftLable.text = model.auct_price;
    NSLog(@"%@",rightDownLeftLable.text);
    
    rightDownRightLable.text = model.auct_number;

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        leftImageView =[ZYControl createImageViewWithFrame:CGRectMake(30*RATIOTYPE_WIDTH,20*RATIOTYPE_HEIGHT,230*RATIOTYPE_WIDTH,230*RATIOTYPE_HEIGHT) ImageName:nil];
//        leftImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:leftImageView];
        
        rightUpLabel = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame)+40*RATIOTYPE_WIDTH, 20*RATIOTYPE_HEIGHT,kScreenWidth-CGRectGetMaxX(leftImageView.frame)+70*RATIOTYPE_WIDTH,80*RATIOTYPE_HEIGHT) Font:12 Text:nil];
        rightUpLabel.textColor =[AOColorFormat colorWithHexString:@"4c4c4c"];
        rightUpLabel.numberOfLines = 2;
        [self.contentView addSubview:rightUpLabel];
        rightDownLeftLable = [ZYControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame)+40*RATIOTYPE_WIDTH,CGRectGetMaxY(leftImageView.frame)-40*RATIOTYPE_HEIGHT,200*RATIOTYPE_WIDTH,40*RATIOTYPE_HEIGHT) Font:14 Text:nil];
        rightDownLeftLable.textColor = [AOColorFormat colorWithHexString:@"ff0000"];
        [self.contentView addSubview:rightDownLeftLable];
        
        rightDownRightLable = [ZYControl createLabelWithFrame:CGRectMake(kScreenWidth-200*RATIOTYPE_WIDTH,CGRectGetMaxY(leftImageView.frame)-40*RATIOTYPE_HEIGHT,160*RATIOTYPE_WIDTH,50*RATIOTYPE_HEIGHT) Font:13 Text:nil];
        rightDownRightLable.textColor = [AOColorFormat colorWithHexString:@"808080"];
        [self.contentView addSubview:rightDownRightLable];
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