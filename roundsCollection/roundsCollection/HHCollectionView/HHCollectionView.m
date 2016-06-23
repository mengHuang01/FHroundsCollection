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


@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, assign) NSInteger imgIndex;

@property (nonatomic, strong) NSTimer *timer;




@end

@implementation HHCollectionView

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
    }
    return _timer;
}

- (void)starTimer
{
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

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
    
    
    cell.img = self.images[index];
    
    NSLog(@"%ld  %ld", indexPath.item, self.imgIndex);
    
    return cell;
    
    
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger sizeOf = scrollView.contentOffset.x / scrollView.bounds.size.width  - 1;
    
  
    
    NSLog(@"%ld", sizeOf);
    if (sizeOf == 0) {
        return;
    }
    
    
    self.imgIndex =  ( self.imgIndex + sizeOf + self.images.count ) % self.images.count;
    
    
    self.pageControl.currentPage = self.imgIndex;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fistTiem];
    });
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self starTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger sizeOf = scrollView.contentOffset.x / scrollView.bounds.size.width  - 1;
    
    
    
    NSLog(@"%ld", sizeOf);
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
    
}

- (void)setCollectionUI
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;

    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.multipleTouchEnabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    

    
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
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *collectH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(num)-[view]-(num)-|" options:NSLayoutFormatAlignAllTop metrics:@{@"num":@0} views:@{@"view":self.collectionView}];
    
    NSArray *collectV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(num)-[view]-(num)-|" options:NSLayoutFormatAlignAllBottom metrics:@{@"num":@0} views:@{@"view":self.collectionView}];
    
    [self addConstraints:collectH];
    [self addConstraints:collectV];
    
                         
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *pageH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(num)-[view]-(num)-|" options:NSLayoutFormatAlignAllBottom metrics:@{@"num":@0} views:@{@"view":self.pageControl}];
    NSArray *pageV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(30)]-(num)-|" options:NSLayoutFormatAlignAllBottom metrics:@{@"num":@20} views:@{@"view":self.pageControl}];
    [self addConstraints:pageH];
    [self addConstraints:pageV];
    
    self.flowLayout.itemSize = self.collectionView.bounds.size;

    [self fistTiem];
    
    [self starTimer];
    
    
    
    
}








@end
