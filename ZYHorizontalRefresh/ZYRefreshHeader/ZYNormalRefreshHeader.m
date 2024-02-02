//
//  ZYNormalRefreshHeader.m
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYNormalRefreshHeader.h"

@interface ZYNormalRefreshHeader ()

@property (nonatomic, copy) ZYRefreshClosure closure;

@end

@implementation ZYNormalRefreshHeader

+ (instancetype)header {
    return [[ZYNormalRefreshHeader alloc] init];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:kContentOffsetKey context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.size = CGSizeMake(kZYRefreshControlWidth, newSuperview.height);
        self.right = 0;
        self.top = 0;
        
        self.originInsets = self.scrollView.contentInset;
        self.state = ZYRefreshStatePullCanRefresh;
        self.statusLabel.text = self.pullCanRefreshText;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentOffsetKey]) {
        if (self.state == ZYRefreshStateRefreshing) { return; }
        // 调整控件状态
        [self reloadStateWithContentOffsetX];
    }
}

- (void)reloadStateWithContentOffsetX {
    // 当前偏移量
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    // 刚好出现刷新footer的偏移量
    CGFloat appearOffsetX = 0;
    // 松开即可刷新的偏移量
    CGFloat releaseToRefreshOffsetX = appearOffsetX - self.width;
    
    // 如果是向下滚动，看不到尾部footer，直接return
    if (contentOffsetX >= appearOffsetX) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        // 拖拽的百分比
        self.pullingPercent = (appearOffsetX - contentOffsetX) / self.width;
        
        if (self.state == ZYRefreshStatePullCanRefresh && contentOffsetX < releaseToRefreshOffsetX) {
            // 转为松开即可刷新状态
            self.state = ZYRefreshStateReleaseCanRefresh;
        } else if (self.state == ZYRefreshStateReleaseCanRefresh && contentOffsetX >= releaseToRefreshOffsetX) {
            // 转为拖拽可以刷新状态
            self.state = ZYRefreshStatePullCanRefresh;
        }
    } else if (self.state == ZYRefreshStateReleaseCanRefresh && !self.scrollView.isDragging) {
        // 开始刷新
        self.state = ZYRefreshStateRefreshing;
        self.pullingPercent = 1.f;
        
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.left += self.width;
        self.scrollView.contentInset = insets;
        
        // 回调
        BLOCK_EXE(_closure)
    } else {
        self.pullingPercent = (contentOffsetX - appearOffsetX) / self.width;
    }
}

- (void)setState:(ZYRefreshState)state {
    [super setState:state];
    
    switch (state) {
        case ZYRefreshStatePullCanRefresh: {
            self.imageView.hidden = NO;
            self.activityView.hidden = YES;
            self.imageView.image = [UIImage imageNamed:@"ZYHorizontalRefresh.bundle/arrow.png"];
            [UIView animateWithDuration:kZYRefreshFastAnimationDuration animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(0);
            }];
            break;
        }
        case ZYRefreshStateReleaseCanRefresh: {
            self.imageView.hidden = NO;
            self.activityView.hidden = YES;
            [UIView animateWithDuration:kZYRefreshFastAnimationDuration animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            break;
        }
        case ZYRefreshStateRefreshing: {
            self.imageView.hidden = YES;
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
            break;
        }
        case ZYRefreshStateNoMoreData: {
            self.imageView.hidden = YES;
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            break;
        }
    }
}

- (void)beginRefreshing {
    [UIView animateWithDuration:kZYRefreshFastAnimationDuration animations:^{
        self.scrollView.contentInset = self.originInsets;
    }];
    [self reloadStateWithContentOffsetX];
}

- (void)endRefreshing {
    [UIView animateWithDuration:kZYRefreshFastAnimationDuration animations:^{
        self.scrollView.contentInset = self.originInsets;
    }];
    self.state = ZYRefreshStatePullCanRefresh;
}

- (void)addRefreshHeaderWithClosure:(ZYRefreshClosure)closure {
    self.closure = closure;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
