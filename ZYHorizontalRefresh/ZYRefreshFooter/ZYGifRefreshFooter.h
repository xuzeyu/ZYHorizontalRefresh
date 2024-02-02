//
//  ZYGifRefreshFooter.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "ZYNormalRefreshFooter.h"

@interface ZYGifRefreshFooter : ZYNormalRefreshFooter

+ (instancetype)footer;

- (void)setImages:(NSArray *)images forState:(ZYRefreshState)state;

@end
