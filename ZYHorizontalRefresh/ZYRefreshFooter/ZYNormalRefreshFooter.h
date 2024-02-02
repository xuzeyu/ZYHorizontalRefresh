//
//  ZYNormalRefreshFooter.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYBaseRefreshControl.h"

@interface ZYNormalRefreshFooter : ZYBaseRefreshControl

+ (instancetype)footer;

// 如果是最后一页，则禁止刷新动作
@property (nonatomic, assign) BOOL isLastPage;

- (void)addRefreshFooterWithClosure:(ZYRefreshClosure)closure;

@end
