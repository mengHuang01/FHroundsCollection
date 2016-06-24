//
//  HHCollectionView.h
//  colleciontView 轮播器
//
//  Created by qfh on 16/5/10.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHCollectionView : UIView

/**
 *  图片数组  或者  url 数组
 */
@property (nonatomic, strong) NSArray <NSString *>*images;

/**
 *  数据类型  网络 或者本地
 */
@property (nonatomic, assign) BOOL dataTapy;

/**
 * 类方法
 *
 *  @return collectionView
 */
+ (instancetype)collectionView;

/**
 *  关闭定时器
 */
- (void)stopTimer;

@end
