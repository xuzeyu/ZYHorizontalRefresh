//
//  ZYNormalRefreshHeader.m
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYNormalRefreshHeader.h"

@interface ZYNormalRefreshHeader ()

@end

@implementation ZYNormalRefreshHeader

+ (instancetype)headerWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
    ZYNormalRefreshHeader *header = [[ZYNormalRefreshHeader alloc] init];
    [header setTitle:[ZYRefreshConfig config].headerPullCanRefreshText forState:ZYRefreshStatePullCanRefresh];
    [header setTitle:[ZYRefreshConfig config].headerReleaseCanRefreshText forState:ZYRefreshStateReleaseCanRefresh];
    [header setTitle:[ZYRefreshConfig config].headerRefreshingText forState:ZYRefreshStateRefreshing];
    [header setTitle:[ZYRefreshConfig config].headerNoMoreDataText forState:ZYRefreshStateNoMoreData];
    header.statusLabel.textColor = [ZYRefreshConfig config].statusTextColor;
    header.imageView.tintColor = [ZYRefreshConfig config].imageViewColor;
    header.refreshingBlock = refreshingBlock;
    return header;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:kContentOffsetKey context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.size = CGSizeMake([ZYRefreshConfig config].refreshComponentWidth, newSuperview.height);
        self.right = 0;
        self.top = 0;
        
        self.originInsets = self.scrollView.contentInset;
        self.state = ZYRefreshStatePullCanRefresh;
        self.statusLabel.text = self.pullCanRefreshText;
        self.stateLabelHidden = self.stateLabelHidden;
    }
}

- (void)setStateLabelHidden:(BOOL)stateLabelHidden {
    [super setStateLabelHidden:stateLabelHidden];
    
    if (self.stateLabelHidden) {
        [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.centerView);
        }];
    }else {
        [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.imageView);
        }];
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
        } else if (self.state ==     ZYRefreshStateReleaseCanRefresh && contentOffsetX >= releaseToRefreshOffsetX) {
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
        BLOCK_EXE(self.refreshingBlock)
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
            self.imageView.image = [[ZYRefreshConfig imageNamed:@"arrow.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [UIView animateWithDuration:[ZYRefreshConfig config].refreshFastAnimationDuration animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(0);
            }];
            break;
        }
        case     ZYRefreshStateReleaseCanRefresh: {
            self.imageView.hidden = NO;
            self.activityView.hidden = YES;
            [UIView animateWithDuration:[ZYRefreshConfig config].refreshFastAnimationDuration animations:^{
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
    self.state = ZYRefreshStateReleaseCanRefresh;
    [self reloadStateWithContentOffsetX];
    [UIView animateWithDuration:[ZYRefreshConfig config].refreshFastAnimationDuration animations:^{
        self.scrollView.contentOffset = CGPointMake(- [ZYRefreshConfig config].refreshComponentWidth, 0);
    }completion:^(BOOL finished) {
        self.state = ZYRefreshStateRefreshing;
    }];
}

- (void)endRefreshing {
    [UIView animateWithDuration:[ZYRefreshConfig config].refreshFastAnimationDuration animations:^{
        self.scrollView.contentInset = self.originInsets;
    }];
    self.state = ZYRefreshStatePullCanRefresh;
}

- (void)setIsLastPage:(BOOL)isLastPage {
    _isLastPage = isLastPage;
    if (_isLastPage) {
        self.state = ZYRefreshStateNoMoreData;
    } else {
        self.state = ZYRefreshStatePullCanRefresh;
    }
}

@end
