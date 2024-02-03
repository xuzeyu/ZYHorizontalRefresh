//
//  ZYRefreshComponent.m
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYRefreshComponent.h"

@implementation ZYRefreshComponent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.state = ZYRefreshStatePullCanRefresh;
        
        [self addSubview:self.centerView];
        [self.centerView addSubview:self.statusLabel];
        [self.centerView addSubview:self.imageView];
        [self.centerView addSubview:self.activityView];
        
        self.stateLabelHidden = NO;
        
        WeakSelf(self)
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.statusLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerX.equalTo(self.statusLabel);
            make.bottom.mas_equalTo(0);
        }];
        
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.imageView);
        }];        
    }
    return self;
}

- (void)endRefreshing {

}

- (void)reloadDataWithState {
    switch (self.state) {
        case ZYRefreshStatePullCanRefresh: {
            self.statusLabel.text = self.pullCanRefreshText;
            break;
        }
        case     ZYRefreshStateReleaseCanRefresh: {
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
        case     ZYRefreshStateReleaseCanRefresh: {
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

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

#pragma mark - Other
- (void)layoutSubviews {
    [super layoutSubviews];
    self.size = CGSizeMake(kZYRefreshComponentWidth, self.superview.height);
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

