//
//  StretchViewController.m
//  FloatHeader
//
//  Created by 杨晓周 on 2018/9/4.
//  Copyright © 2018年 杨晓周. All rights reserved.
//

#import "StretchViewController.h"
#import "TestHeadView.h"
#import "UITableView+StretchHeader.h"
#import "BaseTableView.h"

//屏幕尺寸
#define UI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface StretchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) BaseTableView *tableView;

@end

@implementation StretchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BaseTableView *tabelView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    self.tableView = tabelView;
    [self.view addSubview:tabelView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200)];
    imageView.image = [UIImage imageNamed:@"photo.jpeg"];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
