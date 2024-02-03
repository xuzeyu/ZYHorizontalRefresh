//
//  ZYNormalRefreshHeader.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYRefreshComponent.h"

@interface ZYNormalRefreshHeader : ZYRefreshComponent

+ (instancetype)headerWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock;

@end
