//
//  BaseModel.h
//  myProject1
//
//  Created by 任 on 15/3/31.
//  Copyright (c) 2015年 任子松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, copy) NSDictionary *map;//放key和属性名不同的变量的..

- (id)initWithDictionary:(NSDictionary *)dic;
- (void)setAttributes:(NSDictionary *)dic;

@end
