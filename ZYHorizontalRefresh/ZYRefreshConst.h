//
//  ZYRefreshConfig.h
//  ZYRefresh
//
//  Created by xuzy on 24/2/2.
//  Copyright © 2024年 xuzy. All rights reserved.
//

/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* * * * * * * * * define and typedef  * * * * * * * * */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * */

typedef void (^ZYRefreshComponentAction) (void);

#ifndef WeakSelf
#define WeakSelf(self) __weak typeof(self) weakSelf = self;
#endif

#ifndef StrongSelf
#define StrongSelf(weakSelf) __strong typeof(weakSelf) strongSelf = weakSelf;
#endif

#ifndef YYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define YYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

#ifndef BLOCK_EXE
#define BLOCK_EXE(block, ...) \
if (block) { \
    block(__VA_ARGS__); \
}
#endif



