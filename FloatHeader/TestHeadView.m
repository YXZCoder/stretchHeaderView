//
//  TestHeadView.m
//  FloatHeader
//
//  Created by 杨晓周 on 2018/9/3.
//  Copyright © 2018年 杨晓周. All rights reserved.
//

#import "TestHeadView.h"
#import "Masonry.h"

@implementation TestHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIButton *redView = [[UIButton alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [redView addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.bottom.equalTo(self).offset(-50);
        make.width.height.mas_equalTo(50);
    }];
}

- (void)clickButton
{
    NSLog(@"ddd");
}
@end
