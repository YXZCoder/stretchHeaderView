//
//  UITableView+StretchHeader.m
//  FloatHeader
//
//  Created by 杨晓周 on 2018/9/4.
//  Copyright © 2018年 杨晓周. All rights reserved.
//

#import "UITableView+StretchHeader.h"
#import <objc/runtime.h>

@interface observeManager : NSObject
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *stretchView;
@property (nonatomic, assign) CGRect originFrame;
@end

@implementation observeManager
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self stretchScrollViewDidScroll:self.scrollView];
    }
}

- (void)stretchScrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;
    if (offy < 0) {
        CGFloat offsetY = - scrollView.contentOffset.y;
        self.stretchView.frame = CGRectMake(- offsetY / 2, - offsetY, scrollView.frame.size.width + offsetY,  self.originFrame.size.height + offsetY);
    }
}

@end



@implementation UITableView (StretchHeader)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSEL:NSSelectorFromString(@"dealloc")
                         withSEL:@selector(mf_dealloc)];
    });

}

+ (void)swizzleInstanceSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
    
    [self swizzleInstanceSEL:originalSEL withSEL:swizzledSEL forClass:[self class]];
}

+ (void)swizzleInstanceSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL forClass:(Class)cls {
    
    Method originalMethod = class_getInstanceMethod(cls, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(cls,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

- (void)mf_dealloc{
    if ([self hasKey:@"contentOffset"] && self.observe) {
        [self removeObserver:self.observe forKeyPath:@"contentOffset"];
    }

    [self mf_dealloc];
}

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

- (void)setObserve:(observeManager *)observe{
    objc_setAssociatedObject(self, _cmd,
                             observe,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (observeManager *)observe{
    return objc_getAssociatedObject(self, @selector(setObserve:));

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
        [self insertSubview:stretchView atIndex:0];
    }
    self.observe = [[observeManager alloc] init];
    self.observe.scrollView = self;
    self.observe.stretchView = stretchView;
    self.observe.originFrame = stretchView.frame;
    
    if (![self hasKey:@"contentOffset"]) {
       [self addObserver:self.observe forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (BOOL)hasKey:(NSString *)kvoKey {
    BOOL hasKey = NO;
    id info = self.observationInfo;
    NSArray *arr = [info valueForKeyPath:@"_observances._property._keyPath"];
    for (id keypath in arr) {
        // 存在kvo 的key
        if ([keypath isEqualToString:kvoKey]) {
            hasKey = YES;
            break;
        }
    }
    return hasKey;
}


@end




