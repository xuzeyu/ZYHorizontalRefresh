//
//  UIScrollView+ZYRefresh.m
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

#import "UIScrollView+ZYRefresh.h"
#import <objc/runtime.h>

@interface UIScrollView ()

@end

@implementation UIScrollView (ZYRefresh)

//YYSYNTH_DYNAMIC_PROPERTY_OBJECT(zy_header, setZy_header, RETAIN, ZYRefreshComponent *)
//YYSYNTH_DYNAMIC_PROPERTY_OBJECT(zy_footer, setZy_footer, RETAIN, ZYRefreshComponent *)

- (void)setZy_header:(ZYRefreshComponent *)zy_header {
    if (self.zy_header) {
        [self.zy_header removeFromSuperview];
    }
    [self addSubview:zy_header];
    objc_setAssociatedObject(self, @selector(zy_header), zy_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZYRefreshComponent *)zy_header {
    return objc_getAssociatedObject(self, @selector(zy_header));
}

- (void)setZy_footer:(ZYRefreshComponent *)zy_footer {
    if (self.zy_footer) {
        [self.zy_footer removeFromSuperview];
    }
    [self addSubview:zy_footer];
    objc_setAssociatedObject(self, @selector(zy_footer), zy_footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZYRefreshComponent *)zy_footer {
    return objc_getAssociatedObject(self, @selector(zy_footer));
}

//- (void)addRefreshHeaderWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYNormalRefreshHeader *header = [ZYNormalRefreshHeader headerWithRefreshingBlock:refreshingBlock];
//    [self addSubview:header];
//    self.zy_header = header;
//}
//
//- (void)addRefreshFooterWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYNormalRefreshFooter *footer = [ZYNormalRefreshFooter footerWithRefreshingBlock:refreshingBlock];
//    [self addSubview:footer];
//    self.zy_footer = footer;
//}
//
//- (void)addRefreshHeaderNoStatusWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYNormalRefreshHeader *header = [ZYNormalRefreshHeader headerWithRefreshingBlock:refreshingBlock];
//    header.stateLabelHidden = YES;
//    [self addSubview:header];
//    self.zy_header = header;
//}
//
//- (void)addRefreshFooterNoStatusWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYNormalRefreshFooter *footer = [ZYNormalRefreshFooter footerWithRefreshingBlock:refreshingBlock];
//    footer.stateLabelHidden = YES;
//    [self addSubview:footer];
//    self.zy_footer = footer;
//}

//- (void)addGifRefreshHeaderWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYGifRefreshHeader *gifHeader = [ZYGifRefreshHeader headerWithRefreshingBlock:refreshingBlock];
//    gifHeader.stateLabelHidden = NO;
//    // 这里根据自己的需求来调整图片 by liang;
//    NSMutableArray *_idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 60; i++) {
//        UIImage *image = [ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [_idleImages addObject:image];
//    }
//    [gifHeader setImages:_idleImages forState:ZYRefreshStatePullCanRefresh];
//    NSMutableArray *_refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 3; i++) {
//        UIImage *image =[ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [_refreshingImages addObject:image];
//    }
//    [gifHeader setImages:_refreshingImages forState:ZYRefreshStateRefreshing];
//    [self addSubview:gifHeader];
//    self.zy_header = gifHeader;
//}
//
//- (void)addGifRefreshFooterWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYGifRefreshFooter *gifFooter = [ZYGifRefreshFooter footerWithRefreshingBlock:refreshingBlock];
//    gifFooter.stateLabelHidden = NO;
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 60; i++) {
//        UIImage *image = [ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
//    [gifFooter setImages:idleImages forState:ZYRefreshStatePullCanRefresh];
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 3; i++) {
//        UIImage *image = [ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [gifFooter setImages:refreshingImages forState:ZYRefreshStateRefreshing];
//    [self addSubview:gifFooter];
//    self.zy_footer = gifFooter;
//}
//
//- (void)addGifRefreshHeaderNoStatusWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYGifRefreshHeader *gifHeader = [ZYGifRefreshHeader headerWithRefreshingBlock:refreshingBlock];
//    // 是否隐藏状态label
//    gifHeader.stateLabelHidden = YES;
//    NSMutableArray *_idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 60; i++) {
//        UIImage *image = [ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [_idleImages addObject:image];
//    }
//    [gifHeader setImages:_idleImages forState:ZYRefreshStatePullCanRefresh];
//    NSMutableArray *_refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 3; i++) {
//        UIImage *image = [ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [_refreshingImages addObject:image];
//    }
//    [gifHeader setImages:_refreshingImages forState:ZYRefreshStateRefreshing];
//    [self addSubview:gifHeader];
//    self.zy_header = gifHeader;
//}
//
//- (void)addGifRefreshFooterNoStatusWithRefreshingBlock:(ZYRefreshComponentAction)refreshingBlock {
//    ZYGifRefreshFooter *gifFooter = [ZYGifRefreshFooter footerWithRefreshingBlock:refreshingBlock];
//    gifFooter.stateLabelHidden = YES;
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 60; i++) {
//        UIImage *image = [ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
//    [gifFooter setImages:idleImages forState:ZYRefreshStatePullCanRefresh];
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i <= 3; i++) {
//        UIImage *image =  [ZYRefreshConfig gifImageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [gifFooter setImages:refreshingImages forState:ZYRefreshStateRefreshing];
//    [self addSubview:gifFooter];
//    self.zy_footer = gifFooter;
//}

- (void)beginRefreshing {
    if (self.zy_header) { [self.zy_header beginRefreshing]; }
}

- (void)endRefreshing {
    if (self.zy_header) { [self.zy_header endRefreshing]; }
    if (self.zy_footer) { [self.zy_footer endRefreshing]; }
}

@end
