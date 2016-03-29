//
//  LeadViewController.m
//  YOU WATCH－Auction
//
//  Created by zhaoyue on 15/8/4.
//  Copyright (c) 2015年 葛宾霞151. All rights reserved.
//

#import "LeadViewController.h"

@interface LeadViewController ()

@end

@implementation LeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnClick{


        
        UIStoryboard * storyboard = [ UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *main = [storyboard instantiateInitialViewController];
        [self presentViewController:main animated:YES completion:NULL];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
