//
//  ZYBaseRefreshControl.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ZYFrame.h"
#import "Masonry.h"
#import "ZYRefreshConfig.h"

typedef NS_ENUM(NSUInteger, ZYRefreshState) {
    ZYRefreshStatePullCanRefresh = 1, // 拖拽可以刷新状态
    ZYRefreshStateReleaseCanRefresh = 2, // 松开即可刷新状态
    ZYRefreshStateRefreshing = 3, // 正在刷新状态
    ZYRefreshStateNoMoreData = 4, // 没有更多数据状态
};

static NSString *const kContentOffsetKey = @"contentOffset";
static NSString *const kContentSizeKey = @"contentSize";

/// 刷新控件的宽度，在这里调整
static CGFloat const kZYRefreshControlWidth = 44.0;
static CGFloat const kZYRefreshFastAnimationDuration = 0.25;
static CGFloat const kZYRefreshSlowAnimationDuration = 0.4;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * */

@interface ZYBaseRefreshControl : UIView

/// 基础控件
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *gifImageView;

/**
 * 状态显示文字
 */
// 拉动可以（刷新/加载）
@property (nonatomic, copy) NSString *pullCanRefreshText;
// 松开可以（刷新/加载）
@property (nonatomic, copy) NSString *releaseCanRefreshText;
// 正在（刷新/加载）
@property (nonatomic, copy) NSString *refreshingText;
// 没有更多数据
@property (nonatomic, copy) NSString *noMoreDataText;

/// 基本属性
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

/// 状态
@property (nonatomic, assign) ZYRefreshState state;
/// 父视图（scrollView）
@property (nonatomic, weak) UIScrollView *scrollView;

/// 设置状态相应文字
- (void)setTitle:(NSString *)title forState:(ZYRefreshState)state;

/// 拖拽的比例
@property (nonatomic, assign) CGFloat pullingPercent;
/// 原边距
@property (nonatomic, assign) UIEdgeInsets originInsets;

- (void)endRefreshing;

/// 是否隐藏状态label，注意：如果要隐藏状态label，要先设置这个属性
@property (nonatomic, assign) BOOL stateLabelHidden;

@end

@interface NSString (ZYRefresh)

- (NSString *)insertLinefeeds;

@end
