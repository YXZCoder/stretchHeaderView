//
//  ViewController.m
//  FloatHeader
//
//  Created by 杨晓周 on 2018/9/3.
//  Copyright © 2018年 杨晓周. All rights reserved.
//

#import "ViewController.h"

#import "StretchViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拉伸头部";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickBtn
{
    StretchViewController *vc = [[StretchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
