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

@property (nonatomic, strong) ZYNormalRefreshHeader *header;
@property (nonatomic, strong) ZYNormalRefreshFooter *footer;
@property (nonatomic, strong) ZYGifRefreshHeader *gifHeader;
@property (nonatomic, strong) ZYGifRefreshFooter *gifFooter;

@end

@implementation UIScrollView (ZYRefresh)

YYSYNTH_DYNAMIC_PROPERTY_OBJECT(header, setHeader, RETAIN, ZYNormalRefreshHeader *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(footer, setFooter, RETAIN, ZYNormalRefreshFooter *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(gifHeader, setGifHeader, RETAIN, ZYGifRefreshHeader *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(gifFooter, setGifFooter, RETAIN, ZYGifRefreshFooter *)

- (void)addRefreshHeaderWithClosure:(ZYRefreshClosure)closure {
    if (!self.header && !self.gifHeader) {
        self.header = [ZYNormalRefreshHeader header];
        [self.header setTitle:@"右拉即可刷新" forState:ZYRefreshStatePullCanRefresh];
        [self.header setTitle:@"松开即可刷新" forState:ZYRefreshStateReleaseCanRefresh];
        [self.header setTitle:@"正在为您刷新" forState:ZYRefreshStateRefreshing];
        self.header.statusLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        [self addSubview:self.header];
        [self.header addRefreshHeaderWithClosure:closure];
    }
}

- (void)addRefreshFooterWithClosure:(ZYRefreshClosure)closure {
    if (!self.footer && !self.gifFooter) {
        self.footer = [ZYNormalRefreshFooter footer];
        [self.footer setTitle:@"左拉即可加载" forState:ZYRefreshStatePullCanRefresh];
        [self.footer setTitle:@"松开即可加载" forState:ZYRefreshStateReleaseCanRefresh];
        [self.footer setTitle:@"正在为您加载" forState:ZYRefreshStateRefreshing];
        [self.footer setTitle:@"已经是最后一页" forState:ZYRefreshStateNoMoreData];
        self.footer.statusLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        [self addSubview:self.footer];
        [self.footer addRefreshFooterWithClosure:closure];
    }
}

- (void)addGifRefreshHeaderWithClosure:(ZYRefreshClosure)closure {
    if (!self.header && !self.gifHeader) {
        self.gifHeader = [ZYGifRefreshHeader header];
        // 是否隐藏状态label
        self.gifHeader.stateLabelHidden = NO;
        [self.gifHeader setTitle:@"右拉即可刷新" forState:ZYRefreshStatePullCanRefresh];
        [self.gifHeader setTitle:@"松开即可刷新" forState:ZYRefreshStateReleaseCanRefresh];
        [self.gifHeader setTitle:@"正在为您刷新" forState:ZYRefreshStateRefreshing];
        self.gifHeader.statusLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        // 这里根据自己的需求来调整图片 by liang;
        NSMutableArray *_idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_anim__000%zd", i]];
            [_idleImages addObject:image];
        }
        [self.gifHeader setImages:_idleImages forState:ZYRefreshStatePullCanRefresh];
        NSMutableArray *_refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_loading_0%zd", i]];
            [_refreshingImages addObject:image];
        }
        [self.gifHeader setImages:_refreshingImages forState:ZYRefreshStateRefreshing];
        [self addSubview:self.gifHeader];
        [self.gifHeader addRefreshHeaderWithClosure:closure];
    }
}

- (void)addGifRefreshFooterWithClosure:(ZYRefreshClosure)closure {
    if (!self.footer && !self.gifFooter) {
        self.gifFooter = [ZYGifRefreshFooter footer];
        self.gifFooter.stateLabelHidden = NO;
        [self.gifFooter setTitle:@"左拉即可加载" forState:ZYRefreshStatePullCanRefresh];
        [self.gifFooter setTitle:@"松开即可加载" forState:ZYRefreshStateReleaseCanRefresh];
        [self.gifFooter setTitle:@"正在为您加载" forState:ZYRefreshStateRefreshing];
        [self.gifFooter setTitle:@"已经是最后一页" forState:ZYRefreshStateNoMoreData];
        self.gifFooter.statusLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_anim__000%zd", i]];
            [idleImages addObject:image];
        }
        [self.gifFooter setImages:idleImages forState:ZYRefreshStatePullCanRefresh];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_loading_0%zd", i]];
            [refreshingImages addObject:image];
        }
        [self.gifFooter setImages:refreshingImages forState:ZYRefreshStateRefreshing];
        [self addSubview:self.gifFooter];
        [self.gifFooter addRefreshFooterWithClosure:closure];
    }
}

- (void)addGifRefreshHeaderNoStatusWithClosure:(ZYRefreshClosure)closure {
    if (!self.header && !self.gifHeader) {
        self.gifHeader = [ZYGifRefreshHeader header];
        // 是否隐藏状态label
        self.gifHeader.stateLabelHidden = YES;
        NSMutableArray *_idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_anim__000%zd", i]];
            [_idleImages addObject:image];
        }
        [self.gifHeader setImages:_idleImages forState:ZYRefreshStatePullCanRefresh];
        NSMutableArray *_refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_loading_0%zd", i]];
            [_refreshingImages addObject:image];
        }
        [self.gifHeader setImages:_refreshingImages forState:ZYRefreshStateRefreshing];
        [self addSubview:self.gifHeader];
        [self.gifHeader addRefreshHeaderWithClosure:closure];
    }
}

- (void)addGifRefreshFooterNoStatusWithClosure:(ZYRefreshClosure)closure {
    if (!self.footer && !self.gifFooter) {
        self.gifFooter = [ZYGifRefreshFooter footer];
        self.gifFooter.stateLabelHidden = YES;
        [self.gifFooter setTitle:@"已经是最后一页" forState:ZYRefreshStateNoMoreData];
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_anim__000%zd", i]];
            [idleImages addObject:image];
        }
        [self.gifFooter setImages:idleImages forState:ZYRefreshStatePullCanRefresh];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ZYHorizontalRefresh.bundle/GifImages/dropdown_loading_0%zd", i]];
            [refreshingImages addObject:image];
        }
        [self.gifFooter setImages:refreshingImages forState:ZYRefreshStateRefreshing];
        [self addSubview:self.gifFooter];
        [self.gifFooter addRefreshFooterWithClosure:closure];
    }
}

- (void)addRefreshHeaderWithClosure:(ZYRefreshClosure)headerClosure
        addRefreshFooterWithClosure:(ZYRefreshClosure)footerClosure {
    [self addRefreshHeaderWithClosure:headerClosure];
    [self addRefreshFooterWithClosure:footerClosure];
}

- (void)addGifRefreshHeaderWithClosure:(ZYRefreshClosure)headerClosure
        addGifRefreshFooterWithClosure:(ZYRefreshClosure)footerClosure {
    [self addGifRefreshHeaderWithClosure:headerClosure];
    [self addGifRefreshFooterWithClosure:footerClosure];
}

- (void)addGifRefreshHeaderNoStatusWithClosure:(ZYRefreshClosure)headerClosure
        addGifRefreshFooterNoStatusWithClosure:(ZYRefreshClosure)footerClosure {
    [self addGifRefreshHeaderNoStatusWithClosure:headerClosure];
    [self addGifRefreshFooterNoStatusWithClosure:footerClosure];
}

- (void)endRefreshing {
    if (self.header) { [self.header endRefreshing]; }
    if (self.footer) { [self.footer endRefreshing]; }
    if (self.gifHeader) { [self.gifHeader endRefreshing]; }
    if (self.gifFooter) { [self.gifFooter endRefreshing]; }
}

- (void)setIsLastPage:(BOOL)isLastPage {
    if (self.footer) {
        self.footer.isLastPage = isLastPage;
        return;
    }
    self.gifFooter.isLastPage = isLastPage;
}

- (BOOL)isLastPage {
    if (self.footer) {
        return self.footer.isLastPage;
    }
    return self.gifFooter.isLastPage;
}

- (void)setRefreshHeaderBackgroundColor:(UIColor *)refreshHeaderBackgroundColor {
    if (self.header) {
        self.header.backgroundColor = refreshHeaderBackgroundColor;
    }
    if (self.gifHeader) {
        self.gifHeader.backgroundColor = refreshHeaderBackgroundColor;
    }
}

- (UIColor *)refreshHeaderBackgroundColor {
    if (self.header) {
        return self.header.backgroundColor;
    }
    if (self.gifHeader) {
        return self.gifHeader.backgroundColor;
    }
    return [UIColor clearColor];
}

- (void)setRefreshFooterBackgroundColor:(UIColor *)refreshFooterBackgroundColor {
    if (self.footer) {
        self.footer.backgroundColor = refreshFooterBackgroundColor;
    }
    if (self.gifFooter) {
        self.gifFooter.backgroundColor = refreshFooterBackgroundColor;
    }
}

- (UIColor *)refreshFooterBackgroundColor {
    if (self.footer) {
        return self.footer.backgroundColor;
    }
    if (self.gifFooter) {
        return self.gifFooter.backgroundColor;
    }
    return [UIColor clearColor];
}

- (void)setRefreshHeaderFont:(UIFont *)refreshHeaderFont {
    if (self.header) {
        self.header.font = refreshHeaderFont;
    }
    if (self.gifHeader) {
        self.gifHeader.font = refreshHeaderFont;
    }
}

- (UIFont *)refreshHeaderFont {
    if (self.header) {
        return self.header.font;
    }
    if (self.gifHeader) {
        return self.gifHeader.font;
    }
    return [UIFont systemFontOfSize:13];
}

- (void)setRefreshHeaderTextColor:(UIColor *)refreshHeaderTextColor {
    if (self.header) {
        self.header.textColor = refreshHeaderTextColor;
    }
    if (self.gifHeader) {
        self.gifHeader.textColor = refreshHeaderTextColor;
    }
}

- (UIColor *)refreshHeaderTextColor {
    if (self.header) {
        return self.header.textColor;
    }
    if (self.gifHeader) {
        return self.gifHeader.textColor;
    }
    return [UIColor clearColor];
}

- (void)setRefreshFooterFont:(UIFont *)refreshFooterFont {
    if (self.footer) {
        self.footer.font = refreshFooterFont;
    }
    if (self.gifFooter) {
        self.gifFooter.font = refreshFooterFont;
    }
}

- (UIFont *)refreshFooterFont {
    if (self.footer) {
        return self.footer.font;
    }
    if (self.gifFooter) {
        return self.gifFooter.font;
    }
    return [UIFont systemFontOfSize:13];
}

- (void)setRefreshFooterTextColor:(UIColor *)refreshFooterTextColor {
    if (self.footer) {
        self.footer.textColor = refreshFooterTextColor;
    }
    if (self.gifFooter) {
        self.gifFooter.textColor = refreshFooterTextColor;
    }
}

- (UIColor *)refreshFooterTextColor {
    if (self.footer) {
        return self.footer.textColor;
    }
    if (self.gifFooter) {
        return self.gifFooter.textColor;
    }
    return [UIColor clearColor];
}

@end
