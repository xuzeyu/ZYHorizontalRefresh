//
//  ZYGifRefreshHeader.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYNormalRefreshHeader.h"

@interface ZYGifRefreshHeader : ZYNormalRefreshHeader

+ (instancetype)headerWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock;

+ (instancetype)headerWithPullCanRefreshImages:(NSArray *)pullCanRefreshImages refreshingImages:(NSArray *)refreshingImages refreshingBlock:(ZYRefreshComponentAction)refreshingBlock;

- (void)setImages:(NSArray *)images forState:(ZYRefreshState)state;

@end
