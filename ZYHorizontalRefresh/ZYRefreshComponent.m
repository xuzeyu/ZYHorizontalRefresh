//
//  ZYRefreshComponent.m
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYRefreshComponent.h"

@interface ZYRefreshComponent ()

@end

@implementation ZYRefreshComponent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.state = ZYRefreshStatePullCanRefresh;
    }
    return self;
}

- (void)initViews:(ZYRefreshState)refreshState {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)beginRefreshing {
    
}

- (void)endRefreshing {

}

- (void)reloadDataWithState {
    switch (self.state) {
        case ZYRefreshStatePullCanRefresh: {
            self.statusLabel.text = self.pullCanRefreshText;
            break;
        }
        case ZYRefreshStateReleaseCanRefresh: {
            self.statusLabel.text = self.releaseCanRefreshText;
            break;
        }
        case ZYRefreshStateRefreshing: {
            self.statusLabel.text = self.refreshingText;
            break;
        }
        case ZYRefreshStateNoMoreData: {
            self.statusLabel.text = self.noMoreDataText;
            break;
        }
    }
}

- (void)setTitle:(NSString *)title forState:(ZYRefreshState)state {
    if (!title) {
        return;
    }
    NSString *linefeedsTitle = [[title copy] insertLinefeeds];
    switch (state) {
        case ZYRefreshStatePullCanRefresh: {
            self.pullCanRefreshText = linefeedsTitle;
            break;
        }
        case ZYRefreshStateReleaseCanRefresh: {
            self.releaseCanRefreshText = linefeedsTitle;
            break;
        }
        case ZYRefreshStateRefreshing: {
            self.refreshingText = linefeedsTitle;
            break;
        }
        case ZYRefreshStateNoMoreData: {
            self.noMoreDataText = linefeedsTitle;
            break;
        }
    }
}

#pragma mark -
#pragma mark - setter methods
- (void)setState:(ZYRefreshState)state {
    _state = state;
    [self initViews:state];
    [self reloadDataWithState];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.statusLabel.textColor = _textColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.statusLabel.font = font;
}

- (void)setStateLabelHidden:(BOOL)stateLabelHidden {
    _stateLabelHidden = stateLabelHidden;
    self.statusLabel.hidden = stateLabelHidden;
}

#pragma mark -
#pragma mark - getter methods
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
    }
    return _centerView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont boldSystemFontOfSize:13];
        _statusLabel.textColor = [UIColor lightTextColor];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.numberOfLines = 0;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

#pragma mark - Other
- (void)layoutSubviews {
    [super layoutSubviews];
    self.size = CGSizeMake([ZYRefreshConfig config].refreshComponentWidth, self.superview.height);
}

@end

@implementation NSString (ZYRefresh)

- (NSString *)insertLinefeeds {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < self.length; i ++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        [string appendString:str];
        if (i != self.length - 1) { // 最后一位不加 '\n'
            [string appendString:@"\n"];            
        }
    }
    return string;
}

@end

