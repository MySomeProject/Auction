//
//  DataServe.m
//  myProject1
//
//  Created by 任 on 15/3/31.
//  Copyright (c) 2015年 任子松. All rights reserved.
//

#import "DataServe.h"

@implementation DataServe

+ (id)dataFromFile:(NSString *)name//json解析
{
    NSError *error;
    NSString *st = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *da = [NSData dataWithContentsOfFile:st];
    id dic = [NSJSONSerialization JSONObjectWithData:da options:NSJSONReadingAllowFragments error:&error];
//    NSArray *ar = [dic objectForKey:@"list"];
//    zsLog(@"\n用户：%@\n评论内容：%@\n评分：%@", [ar[0] objectForKey:@"nickname"], [ar[0] objectForKey:@"content"], [ar[0] objectForKey:@"rating"]);
    return dic;
}

@end
