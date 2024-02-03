//
//  UIScrollView+ZYRefresh.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRefreshComponent.h"

@interface UIScrollView (ZYRefresh)

/**
 * header
 */
@property (nonatomic, strong) ZYRefreshComponent *zy_header;

/**
 * footer
 */
@property (nonatomic, strong) ZYRefreshComponent *zy_footer;


/**
 * 结束刷新
 */
- (void)endRefreshing;

@end
