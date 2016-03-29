//
//  BaseModel.m
//  myProject1
//
//  Created by 任 on 15/3/31.
//  Copyright (c) 2015年 任子松. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setAttributes:dic];//将字典中的数据赋给model对象
    }
    return self;
}

- (void)setAttributes:(NSDictionary *)dic
{
    for (NSString *key in dic) {
        NSString *a = [[key substringToIndex:1] uppercaseString];
//        NSLog(@"%@", [key capitalizedString]);//不能用这个，如果字符串中有多个单词(下划线隔开)，则首字母都大写
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:", a, [key substringFromIndex:1]];
        SEL method = NSSelectorFromString(methodName);
        if ([self respondsToSelector:method]) {
            SuppressPerformSelectorLeakWarning([self performSelector:method withObject:[dic objectForKey:key]]);//不能加afterDelay:!!!!
//            PerformSelector may cause a leak because its selector is unknown
//            这个错误：使用 [someController performSelector: NSSelectorFromString(@"someMethod")]; 时ARC并不知道该方法的返回值是什么，以及该如何处理
        }
    }
    //设置key和属性名不同的变量
    for (NSString *key in _map) {
        NSString *methodName = [_map objectForKey:key];
        SEL method = NSSelectorFromString(methodName);
        if ([self respondsToSelector:method]) {//self有这个方法才执行
            SuppressPerformSelectorLeakWarning([self performSelector:method withObject:[dic objectForKey:key]]);
        /*若withObject为nil可用这个
            IMP imp = [self methodForSelector:method];
            void (*func)(id, SEL) = (void *)imp;
            func(self, method);
        */
        }
    }
}

@end
