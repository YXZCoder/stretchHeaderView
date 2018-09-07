//
//  UITableView+StretchHeader.h
//  FloatHeader
//
//  Created by 杨晓周 on 2018/9/4.
//  Copyright © 2018年 杨晓周. All rights reserved.
//

#import <UIKit/UIKit.h>

@class observeManager;
@interface UITableView (StretchHeader)

@property (nonatomic, weak)   UIView *stretchView;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, strong) observeManager *observe;


- (void)addStretchHeaderView:(UIView *)stretchView;
@end

