//
//  ZYGifRefreshFooter.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYNormalRefreshFooter.h"

@interface ZYGifRefreshFooter : ZYNormalRefreshFooter

+ (instancetype)footerWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock;

+ (instancetype)footerWithPullCanRefreshImages:(NSArray *)pullCanRefreshImages refreshingImages:(NSArray *)refreshingImages refreshingBlock:(ZYRefreshComponentAction)refreshingBlock;

- (void)setImages:(NSArray *)images forState:(ZYRefreshState)state;

@end
