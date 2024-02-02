//
//  ZYNormalRefreshFooter.m
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYNormalRefreshFooter.h"

@interface ZYNormalRefreshFooter ()

@property (nonatomic, copy) ZYRefreshClosure closure;

@end

@implementation ZYNormalRefreshFooter

+ (instancetype)footer {
    return [[ZYNormalRefreshFooter alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isLastPage = NO;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:kContentSizeKey context:nil];
    [self.superview removeObserver:self forKeyPath:kContentOffsetKey context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:kContentSizeKey options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.size = CGSizeMake(kZYRefreshControlWidth, newSuperview.height);
        if (self.scrollView.contentSize.width >= self.scrollView.width) {
            self.left = self.scrollView.contentSize.width;
        } else {
            self.left = self.scrollView.width;
        }
        self.top = 0;
        
        self.originInsets = self.scrollView.contentInset;
        self.state = ZYRefreshStatePullCanRefresh;
        self.statusLabel.text = self.pullCanRefreshText;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentSizeKey]) {
        // 刷新完成后调整控件位置
        self.left = self.scrollView.contentSize.width;
    } else if ([keyPath isEqualToString:kContentOffsetKey]) {
        if (self.state == ZYRefreshStateRefreshing || self.state == ZYRefreshStateNoMoreData) {
            return;
        }
        // 调整控件状态
        [self reloadStateWithContentOffsetX];
    }
}

- (void)reloadStateWithContentOffsetX {
    // 当前偏移量
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    // 刚好出现刷新footer的偏移量
    CGFloat appearOffsetX = self.scrollView.contentSize.width - self.scrollView.width;
    // 松开即可刷新的偏移量
    CGFloat releaseToRefreshOffsetX = appearOffsetX + self.width;
    
    // 如果是向下滚动，看不到尾部footer，直接return
    if (contentOffsetX <= appearOffsetX) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        // 拖拽的百分比
        self.pullingPercent = (contentOffsetX - appearOffsetX) / self.width;
        
        if (self.state == ZYRefreshStatePullCanRefresh && contentOffsetX > releaseToRefreshOffsetX) {
            // 转为松开即可刷新状态
            self.state = ZYRefreshStateReleaseCanRefresh;
        } else if (self.state == ZYRefreshStateReleaseCanRefresh && contentOffsetX <= releaseToRefreshOffsetX) {
            // 转为拖拽可以刷新状态
            self.state = ZYRefreshStatePullCanRefresh;
        }
    } else if (self.state == ZYRefreshStateReleaseCanRefresh && !self.scrollView.isDragging) {
        // 开始刷新
        self.state = ZYRefreshStateRefreshing;
        self.pullingPercent = 1.f;
        
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.right += self.width;
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

- (void)endRefreshing {
    [UIView animateWithDuration:kZYRefreshFastAnimationDuration animations:^{
        self.scrollView.contentInset = self.originInsets;        
    }];
    if (self.state == ZYRefreshStateNoMoreData) {
        return;
    }
    self.state = ZYRefreshStatePullCanRefresh;
}

- (void)addRefreshFooterWithClosure:(ZYRefreshClosure)closure {
    self.closure = closure;
}

- (void)setIsLastPage:(BOOL)isLastPage {
    _isLastPage = isLastPage;
    if (_isLastPage) {
        self.state = ZYRefreshStateNoMoreData;
    } else {
        self.state = ZYRefreshStatePullCanRefresh;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
