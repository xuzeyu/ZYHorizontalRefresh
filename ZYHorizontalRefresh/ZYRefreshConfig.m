//
//  ZYRefreshConfig.m
//  Example
//
//  Created by XUZY on 2024/2/3.
//

#import "ZYRefreshConfig.h"

@implementation ZYRefreshConfig

+ (instancetype)config {
    static ZYRefreshConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZYRefreshConfig alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.refreshComponentWidth = 44.0;
        self.refreshFastAnimationDuration = 0.25;
        self.refreshSlowAnimationDuration = 0.4;
        
        self.headerPullCanRefreshText = @"右拉即可刷新";
        self.headerReleaseCanRefreshText = @"松开即可刷新";
        self.headerRefreshingText = @"正在为您刷新";
        self.headerNoMoreDataText = @"已经是最后一页";
        
        self.footerPullCanRefreshText = @"左拉即可加载";
        self.footerReleaseCanRefreshText = @"松开即可加载";
        self.footerRefreshingText = @"正在为您加载";
        self.footerNoMoreDataText = @"已经是最后一页";
        
        self.imageViewColor = self.statusTextColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        
        self.imagePath = @"images";
        self.gifPath = @"gif";
    }
    return self;
}

+ (NSBundle *)zy_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        NSBundle *containnerBundle = [NSBundle bundleForClass:NSClassFromString(@"ZYRefreshComponent")];
        refreshBundle = [NSBundle bundleWithPath:[containnerBundle pathForResource:@"ZYHorizontalRefresh" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)imageNamed:(NSString *)imageName {
    NSString *imagePath = [[[ZYRefreshConfig zy_refreshBundle] bundlePath] stringByAppendingPathComponent:[ZYRefreshConfig config].imagePath];
    NSString *path = [imagePath stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:path];
}

+ (UIImage *)gifImageNamed:(NSString *)imageName {
    NSString *gifPath = [[[ZYRefreshConfig zy_refreshBundle] bundlePath] stringByAppendingPathComponent:[ZYRefreshConfig config].gifPath];
    NSString *path = [gifPath stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:path];
}

@end
