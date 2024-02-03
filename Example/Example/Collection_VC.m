//
//  Collection_VC.m
//  Example
//
//  Created by XUZY on 2022/10/24.
//

#import "Collection_VC.h"
#import "ZYRefreshHeader.h"

#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

@interface Collection_VC () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Collection_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [NSMutableArray arrayWithObjects:@0, @0, @0, nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat padding = 40;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth - padding * 2, kScreenHeight - padding * 2);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    layout.minimumLineSpacing = padding;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"defaultCell"];
    
    /**
     * 只需 #import "UIScrollView+ZYRefresh.h" 即可
     */
    switch (self.index) {
        case 0:
            [self normalDemo];
            break;
        case 1:
            [self gifDemo];
            break;
        case 2:
            [self gifDemoWithoutText];
            break;
        default:
            break;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark -
#pragma mark - refresh control Using Example
- (void)normalDemo {
    WeakSelf(self)
    _collectionView.zy_header = [ZYNormalRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    _collectionView.zy_footer = [ZYNormalRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadingData];
    }];
}

- (void)gifDemo {
    WeakSelf(self)
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    _collectionView.zy_header = [ZYGifRefreshHeader headerWithPullCanRefreshImages:idleImages refreshingImages:refreshingImages refreshingBlock:^{
        [weakSelf refreshData];
    }];
    
    _collectionView.zy_footer = [ZYGifRefreshFooter footerWithPullCanRefreshImages:idleImages refreshingImages:refreshingImages refreshingBlock:^{
        [weakSelf loadingData];
    }];
}

- (void)gifDemoWithoutText {
    WeakSelf(self)
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    _collectionView.zy_header = [ZYGifRefreshHeader headerWithPullCanRefreshImages:idleImages refreshingImages:refreshingImages refreshingBlock:^{
        [weakSelf refreshData];
    }];
    
    _collectionView.zy_footer = [ZYGifRefreshFooter footerWithPullCanRefreshImages:idleImages refreshingImages:refreshingImages refreshingBlock:^{
        [weakSelf loadingData];
    }];
    _collectionView.zy_header.stateLabelHidden = _collectionView.zy_footer.stateLabelHidden = YES;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"defaultCell" forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    return cell;
}

- (UIColor *)randomColor {
    CGFloat hue = arc4random() % 256 / 256.0;
    CGFloat saturation = arc4random() % 128 / 256.0 + 0.5;
    CGFloat brightness = arc4random() % 128 / 256.0 + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark -
#pragma mark - refresh and loading
- (void)refreshData {
    self.dataArray = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.collectionView.isLastPage = NO;
        [self.collectionView endRefreshing];
        [self.collectionView reloadData];
    });
}

- (void)loadingData {
    for (int i = 0; i < 3; i ++) {
        [self.dataArray addObject:@0];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView endRefreshing];
        if (self.dataArray.count > 7) {
//            self.collectionView.isLastPage = YES;
        }
        [self.collectionView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

