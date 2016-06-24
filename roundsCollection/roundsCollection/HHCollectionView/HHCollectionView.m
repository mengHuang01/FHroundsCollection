//
//  HHCollectionView.m
//  colleciontView 轮播器
//
//  Created by qfh on 16/5/10.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import "HHCollectionView.h"
#import "HHCollectionCell.h"

@interface HHCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

/**
 *  collectionView
 */
@property (nonatomic, weak) UICollectionView *collectionView;
/**
 *  pageControl
 */
@property (nonatomic, weak) UIPageControl *pageControl;
/**
 *  flowLayout 流水布局
 */
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

/**
 *  图片的角标
 */
@property (nonatomic, assign) NSInteger imgIndex;


/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;




@end

@implementation HHCollectionView

#pragma mark- timer 操作

/**
 *  懒加载定时器
 *
 *  @return timer
 */

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
    }
    return _timer;
}
/**
 *  开启定时器
 */
- (void)starTimer
{
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 *  关闭定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
/**
 *  定时器 执行方法
 */
- (void)timerAction
{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
    
    
}


#pragma mark- 数据源 代理方法


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger index =( indexPath.item - 1 + self.imgIndex + self.images.count) % self.images.count;
    
    HHCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.dataTapy = self.dataTapy;
    cell.img = self.images[index];
    
    
    
    return cell;
    
    
}

#pragma mark- UIScrollViewDelegate



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger sizeOf = scrollView.contentOffset.x / scrollView.bounds.size.width  - 1;

    
//    NSLog(@"%ld", sizeOf);
    if (sizeOf == 0) {
        return;
    }
    
    self.imgIndex =  ( self.imgIndex + sizeOf + self.images.count ) % self.images.count;
    
    
    self.pageControl.currentPage = self.imgIndex;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fistTiem];
    });
    
}
/**
 *  手动滑动停止定时器
 *
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
/**
 *  滑动停止定时器
 *
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self starTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger sizeOf = scrollView.contentOffset.x / scrollView.bounds.size.width  - 1;
    
    if (sizeOf == 0) {
        return;
    }
    
    
    self.imgIndex =  ( self.imgIndex + sizeOf + self.images.count ) % self.images.count;
    
    
    self.pageControl.currentPage = self.imgIndex;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fistTiem];
    });

}




#pragma mark- set方法重写
- (void)setImages:(NSArray *)images
{
    _images = images;
    
    
    [self setCollectionUI];

    
    [self starTimer];
    
    
    self.pageControl.numberOfPages = _images.count;
    
    [self.collectionView reloadData];
    
    [self fistTiem];
    
    
    
}

- (void)setCollectionUI
{
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;

    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    
    self.pageControl.multipleTouchEnabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    
}



- (void)fistTiem
{
    NSIndexPath *index = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}


- (instancetype)init
{
    if (self = [super init]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
      
        [self addSubview:collectionView];
        _collectionView = collectionView;
        
        _flowLayout = flowLayout;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        
        [self addSubview:pageControl];
        _pageControl = pageControl;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"HHCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        NSArray *collectH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(num)-[view]-(num)-|" options:NSLayoutFormatAlignmentMask metrics:@{@"num":@0} views:@{@"view":self.collectionView}];
        
        NSArray *collectV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(num)-[view]-(num)-|" options:(NSLayoutFormatAlignmentMask) metrics:@{@"num":@0} views:@{@"view":self.collectionView}];
        
        
        
        [self addConstraints:collectH];
        [self addConstraints:collectV];
        
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSArray *pageH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(num)-[view]-(num)-|" options:NSLayoutFormatAlignmentMask metrics:@{@"num":@0} views:@{@"view":self.pageControl}];
        
        NSArray *pageV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(30)]-(num)-|" options:NSLayoutFormatAlignmentMask metrics:@{@"num":@20} views:@{@"view":self.pageControl}];
        
        [self addConstraints:pageH];
        [self addConstraints:pageV];
        
        
        

    }
    return self;
}

+ (instancetype)collectionView
{
    return [[self alloc]init];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    
    if (self.images.count) {
        [self fistTiem];

    }

    
}







@end
