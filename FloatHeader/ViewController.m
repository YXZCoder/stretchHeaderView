//
//  ViewController.m
//  FloatHeader
//
//  Created by 杨晓周 on 2018/9/3.
//  Copyright © 2018年 杨晓周. All rights reserved.
//

#import "ViewController.h"
#import "TestHeadView.h"
#import "UITableView+StretchHeader.h"

//屏幕尺寸
#define UI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController
{
    CGRect originFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拉伸头部";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    self.tableView = tabelView;
    [self.view addSubview:tabelView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200)];
    imageView.image = [UIImage imageNamed:@"photo.jpg"];
    [self.tableView addStretchHeaderView:imageView];
    
    TestHeadView *header = [[TestHeadView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200)];
    self.tableView.tableHeaderView = header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"1234";
    return cell;
}






@end
