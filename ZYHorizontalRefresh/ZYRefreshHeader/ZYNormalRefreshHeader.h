//
//  ZYNormalRefreshHeader.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYRefreshComponent.h"

@interface ZYNormalRefreshHeader : ZYRefreshComponent

// 如果是最后一页，则禁止刷新动作 适配左右边加载的情况，左边加载结束
@property (nonatomic, assign) BOOL isLastPage;

+ (instancetype)headerWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock;

@end
