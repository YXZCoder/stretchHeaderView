//
//  UITableView+StretchHeader.m
//  FloatHeader
//
//  Created by 杨晓周 on 2018/9/4.
//  Copyright © 2018年 杨晓周. All rights reserved.
//

#import "UITableView+StretchHeader.h"
#import <objc/runtime.h>

@implementation UITableView (StretchHeader)

- (void)setOriginFrame:(CGRect)originFrame{
    
    objc_setAssociatedObject(self, _cmd,
                             [NSValue valueWithCGRect:originFrame],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setStretchView:(UIView *)stretchView{
    objc_setAssociatedObject(self, _cmd,
                             stretchView,
                             OBJC_ASSOCIATION_ASSIGN);
}

- (CGRect)originFrame{
    return [(NSValue *)objc_getAssociatedObject(self, @selector(setOriginFrame:)) CGRectValue];
}

- (UIView *)stretchView{
    return objc_getAssociatedObject(self, @selector(setStretchView:));
}

- (void)addStretchHeaderView:(UIView *)stretchView
{
    self.stretchView = stretchView;
    self.originFrame = stretchView.frame;
        
    if (self.tableHeaderView) {
        [self insertSubview:stretchView belowSubview:self.tableHeaderView];
    } else {
        [self addSubview:stretchView];
    }
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewDidScroll:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;
    
    if (offy < 0) {
        CGFloat offsetY = - scrollView.contentOffset.y;
        self.stretchView.frame = CGRectMake(- offsetY / 2, - offsetY, scrollView.frame.size.width + offsetY,  self.originFrame.size.height + offsetY);
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}
@end
