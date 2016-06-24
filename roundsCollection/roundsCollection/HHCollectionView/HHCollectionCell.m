//
//  HHCollectionCell.m
//  colleciontView 轮播器
//
//  Created by qfh on 16/5/10.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import "HHCollectionCell.h"

#import <UIImageView+WebCache.h>

@interface HHCollectionCell ()


@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation HHCollectionCell

- (void)setImg:(NSString *)img
{
    _img = img;
    
    
    if (self.dataTapy) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:img]];
    }else
    {
        self.imgView.image = [UIImage imageNamed:img];
        
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
