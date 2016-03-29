//
//  YYHongShare.m
//  Auction
//
//  Created by zhaoyue on 15/8/8.
//  Copyright (c) 2015年 zhaoyue. All rights reserved.
//

#import "YYHongShare.h"
#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"

@implementation YYHongShare

+ (void)YYHongWeiXinShare:(NSDictionary *)dic type:(int )type
{
    NSString * strTitle = [dic objectForKey:@"title"]; // 分享的标题
    NSString * strUrl = [dic objectForKey:@"webUrl"]; // 分享的url
    NSString * strDescription = [dic objectForKey:@"description"]; // 简介
    NSString * strImage = [dic objectForKey:@"image"]; // 分享的显示的图标
    
  
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = strTitle;
    message.description = strDescription;
    [message setThumbImage:[UIImage imageNamed:strImage]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = strUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = type;
    
    [WXApi sendReq:req];
    
}

+ (void)YYHongZhiFuBaoZhiFu:(NSDictionary *)dic
{
//    NSString * partner = [dic objectForKey:@"partner"];
//    NSString * seller = [dic objectForKey:@"seller"];
//    NSString * tradeNO = [dic objectForKey:@"tradeNO"]; //订单ID(由商家□自□行制定)
//    NSString * productName = [dic objectForKey:@"productName"]; //商品标题
//    NSString * productDescription = [dic objectForKey:@"productDescription"]; //商品描述
//    CGFloat amount = [[dic objectForKey:@"amount"] floatValue];   //商 品价格
//    
//    
//    
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = tradeNO; //订单ID(由商家□自□行制定)
//    order.productName = productName; //商品标题
//    order.productDescription = productDescription; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",amount]; //商 品价格
    
}


@end
