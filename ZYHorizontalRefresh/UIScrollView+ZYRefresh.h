//
//  UIScrollView+ZYRefresh.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYGifRefreshHeader.h"
#import "ZYGifRefreshFooter.h"

@interface UIScrollView (ZYRefresh)

/**
 * 是否是最后一页
 */
@property (nonatomic, assign) BOOL isLastPage;

/**
 * header背景色
 */
@property (nonatomic, strong) UIColor *refreshHeaderBackgroundColor;

/**
 * footer背景色
 */
@property (nonatomic, strong) UIColor *refreshFooterBackgroundColor;

/**
 * header 字体
 */
@property (nonatomic, strong) UIFont *refreshHeaderFont;

/**
 * header 字体颜色
 */
@property (nonatomic, strong) UIColor *refreshHeaderTextColor;

/**
 * footer 字体
 */
@property (nonatomic, strong) UIFont *refreshFooterFont;

/**
 * footer 字体颜色
 */
@property (nonatomic, strong) UIColor *refreshFooterTextColor;

/**
 * ********************** 以下是调用的方法 **********************
 */
/**
 * 普通的刷新及加载
 */
- (void)addRefreshHeaderWithClosure:(ZYRefreshClosure)closure;

- (void)addRefreshFooterWithClosure:(ZYRefreshClosure)closure;

/**
 * gif 图刷新及加载（带有状态提示）
 */
- (void)addGifRefreshHeaderWithClosure:(ZYRefreshClosure)closure;

- (void)addGifRefreshFooterWithClosure:(ZYRefreshClosure)closure;

/**
 * gif 图刷新及加载（不带有状态提示）
 */
- (void)addGifRefreshHeaderNoStatusWithClosure:(ZYRefreshClosure)closure;

- (void)addGifRefreshFooterNoStatusWithClosure:(ZYRefreshClosure)closure;


/**
 * ****************** 以下三个方法是对上面方法的再次封装 ******************
 */
/**
 * 普通的刷新及加载
 */
- (void)addRefreshHeaderWithClosure:(ZYRefreshClosure)headerClosure
        addRefreshFooterWithClosure:(ZYRefreshClosure)footerClosure;

/**
 * gif 图刷新及加载（带有状态提示）
 */
- (void)addGifRefreshHeaderWithClosure:(ZYRefreshClosure)headerClosure
        addGifRefreshFooterWithClosure:(ZYRefreshClosure)footerClosure;

/**
 * gif 图刷新及加载（不带有状态提示）
 */
- (void)addGifRefreshHeaderNoStatusWithClosure:(ZYRefreshClosure)headerClosure
        addGifRefreshFooterNoStatusWithClosure:(ZYRefreshClosure)footerClosure;

/**
 * 结束刷新
 */
- (void)endRefreshing;

@end
