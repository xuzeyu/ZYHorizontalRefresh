//
//  ZYNormalRefresh.h
//  Example
//
//  Created by XUZY on 2024/2/19.
//

#import "ZYRefreshComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZYNormalRefresh : ZYRefreshComponent
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGSize gifImageSize;
@end

NS_ASSUME_NONNULL_END
