//
//  ZYGifRefreshFooter.m
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYGifRefreshFooter.h"

@interface ZYGifRefreshFooter ()
@property (nonatomic, strong) NSMutableDictionary *imagesDic;
@end

@implementation ZYGifRefreshFooter

+ (instancetype)footerWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
    return [self footerWithPullCanRefreshImages:nil refreshingImages:nil refreshingBlock:refreshingBlock];
}

+ (instancetype)footerWithPullCanRefreshImages:(NSArray *)pullCanRefreshImages refreshingImages:(NSArray *)refreshingImages refreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
    ZYGifRefreshFooter *footer = [[ZYGifRefreshFooter alloc] init];
    [footer setTitle:[ZYRefreshConfig config].footerPullCanRefreshText forState:ZYRefreshStatePullCanRefresh];
    [footer setTitle:[ZYRefreshConfig config].footerReleaseCanRefreshText forState:ZYRefreshStateReleaseCanRefresh];
    [footer setTitle:[ZYRefreshConfig config].footerRefreshingText forState:ZYRefreshStateRefreshing];
    [footer setTitle:[ZYRefreshConfig config].footerNoMoreDataText forState:ZYRefreshStateNoMoreData];
    footer.statusLabel.textColor = [ZYRefreshConfig config].statusTextColor;
    footer.refreshingBlock = refreshingBlock;
    if (pullCanRefreshImages) {
        [footer setImages:pullCanRefreshImages forState:ZYRefreshStatePullCanRefresh];
    }else if ([ZYRefreshConfig config].pullCanRefreshImages) {
        [footer setImages:pullCanRefreshImages forState:ZYRefreshStatePullCanRefresh];
    }
    if (refreshingImages) {
        [footer setImages:refreshingImages forState:ZYRefreshStateRefreshing];
    }else if ([ZYRefreshConfig config].pullCanRefreshImages) {
        [footer setImages:refreshingImages forState:ZYRefreshStateRefreshing];
    }
    return footer;
}

- (void)initViews:(ZYRefreshState)refreshState {
    [super initViews:refreshState];
    if (refreshState != ZYRefreshStateNoMoreData) {
        if (self.stateLabelHidden) {
            [self.imageView removeFromSuperview];
            [self.centerView addSubview:self.gifImageView];
            [self.gifImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.gifImageView);
            }];
        }else {
            [self.imageView removeFromSuperview];
            [self.centerView addSubview:self.gifImageView];
            [self.gifImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.statusLabel.mas_bottom).offset(8);
                make.centerX.mas_equalTo(1);
                make.bottom.mas_equalTo(0);
                make.size.mas_equalTo(self.gifImageSize);
            }];
            
            [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.gifImageView);
            }];
        }
    }
}

//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    [super willMoveToSuperview:newSuperview];
//    
//    [self.imageView removeFromSuperview];
//    [self.activityView removeFromSuperview];
//    
//    self.gifImageView = [[UIImageView alloc] init];
//    self.gifImageView.contentMode = UIViewContentModeCenter;
//    [self.centerView addSubview:self.gifImageView];
//
////    self.gifImageView.frame = self.bounds;
////
////    if (!self.stateLabelHidden) {
////        self.gifImageView.center = CGPointMake(self.width / 2, self.height / 2 + 120);
////    }
//}

- (void)setState:(ZYRefreshState)state {
    if (self.state == state) { return; }
    [super setState:state];

    NSArray *images = self.imagesDic[@(state)];
    switch (state) {
        case ZYRefreshStatePullCanRefresh: {
            self.gifImageView.hidden = NO;
            break;
        }
        case     ZYRefreshStateReleaseCanRefresh:
        case ZYRefreshStateRefreshing: {
            [self.gifImageView stopAnimating];
            if (images.count == 1) {
                self.gifImageView.image = images.lastObject;
            } else {
                self.gifImageView.animationImages = images;
                self.gifImageView.animationDuration = images.count * 0.1;
                [self.gifImageView startAnimating];
            }
            break;
        }
        case ZYRefreshStateNoMoreData: {
            self.gifImageView.hidden = YES;
            self.stateLabelHidden = NO;
            [self.gifImageView stopAnimating];
            break;
        }
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.imagesDic[@(self.state)];
    switch (self.state) {
        case ZYRefreshStatePullCanRefresh: {
            [self.gifImageView stopAnimating];
            NSUInteger index =  images.count * self.pullingPercent;
            if (index >= images.count) index = images.count - 1;
            self.gifImageView.image = images[index];
            break;
        }
        default:
            break;
    }
}

- (void)setImages:(NSArray *)images forState:(ZYRefreshState)state {
    if (images == nil) { return; }
    self.imagesDic[@(state)] = images;
    
    // 根据图片设置控件的高度
    UIImage *image = images.firstObject;
    if (image.size.width > self.width) {
        self.width = image.size.width;
    }
}

- (NSMutableDictionary *)imagesDic {
    if (!_imagesDic) {
        _imagesDic = [NSMutableDictionary dictionary];
    }
    return _imagesDic;
}

@end
