//
//  ZYNormalRefreshHeader.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYBaseRefreshControl.h"

@interface ZYNormalRefreshHeader : ZYBaseRefreshControl

+ (instancetype)header;

- (void)addRefreshHeaderWithClosure:(ZYRefreshClosure)closure;

@end
