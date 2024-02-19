//
//  ZYNormalRefresh.m
//  Example
//
//  Created by XUZY on 2024/2/19.
//

#import "ZYNormalRefresh.h"

@implementation ZYNormalRefresh

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageSize = self.gifImageSize = CGSizeMake(40, 40);
    }
    return self;
}

- (void)setStateLabelHidden:(BOOL)stateLabelHidden {
    [super setStateLabelHidden:stateLabelHidden];
    [self initViews:self.state];
}

- (void)initViews:(ZYRefreshState)refreshState {
    [super initViews:refreshState];
    if (refreshState == ZYRefreshStateNoMoreData) {
        [self.centerView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }else {
        if (self.stateLabelHidden) {
            [self.centerView addSubview:self.imageView];
            [self.centerView addSubview:self.activityView];
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.imageView);
            }];
        }else {
            [self.centerView addSubview:self.statusLabel];
            [self.centerView addSubview:self.imageView];
            [self.centerView addSubview:self.activityView];
            [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(0);
            }];
            
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.statusLabel.mas_bottom).offset(8);
                make.centerX.mas_equalTo(1);
                make.bottom.mas_equalTo(0);
                make.size.mas_equalTo(self.imageSize);
            }];
            
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.imageView);
            }];
        }
    }
}

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.imageSize);
    }];
}

- (void)setGifImageSize:(CGSize)gifImageSize {
    _gifImageSize = gifImageSize;
    [self.gifImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.imageSize);
    }];
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
        case ZYRefreshStateReleaseCanRefresh: {
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

#pragma mark -
#pragma mark - getter methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UIImageView *)gifImageView {
    if (!_gifImageView) {
        _gifImageView = [[UIImageView alloc] init];
        _gifImageView.contentMode = UIViewContentModeCenter;
    }
    return _gifImageView;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

@end
