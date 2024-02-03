//
//  ZYRefreshConfig.h
//  Example
//
//  Created by XUZY on 2024/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//默认值
@interface ZYRefreshConfig : NSObject

@property (nonatomic, strong) UIColor *statusTextColor;
@property (nonatomic, strong) UIColor *imageViewColor;

//刷新宽度
@property (nonatomic, assign) CGFloat refreshComponentWidth; //默认44.0
@property (nonatomic, assign) CGFloat refreshFastAnimationDuration;//默认0.25秒
@property (nonatomic, assign) CGFloat refreshSlowAnimationDuration;//默认0.4秒

//刷新文字
@property (nonatomic, strong) NSString *headerPullCanRefreshText;
@property (nonatomic, strong) NSString *headerReleaseCanRefreshText;
@property (nonatomic, strong) NSString *headerRefreshingText;

@property (nonatomic, strong) NSString *footerPullCanRefreshText;
@property (nonatomic, strong) NSString *footerReleaseCanRefreshText;
@property (nonatomic, strong) NSString *footerRefreshingText;
@property (nonatomic, strong) NSString *footerNoMoreDataText;

//gif默认图片
@property (nonatomic, strong) NSArray <UIImage *>*pullCanRefreshImages;
@property (nonatomic, strong) NSArray <UIImage *>*refreshingImages;

//路径
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *gifPath;

//方法
+ (instancetype)config;
+ (UIImage *)imageNamed:(NSString *)imageName;//获取图片
+ (UIImage *)gifImageNamed:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
