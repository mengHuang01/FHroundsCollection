//
//  HHCollectionViewController.m
//  roundsCollection
//
//  Created by qfh on 16/6/24.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import "HHCollectionViewController.h"
#import "HHCollectionView.h"
#import "HHImageModel.h"

@interface HHCollectionViewController ()

@end

@implementation HHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    // 创建collectionView
    HHCollectionView *collectionView = [HHCollectionView collectionView];
    
    [self.view addSubview:collectionView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //加载网络数据
    if (self.netFlag) {
        
        collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
        
        collectionView.center = self.view.center;
        
        [HHImageModel imageWith:^(NSArray *imageArray) {
            
           
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:imageArray.count];
            
            for (HHImageModel *model in imageArray) {
                [tempArray addObject:model.imgsrc];
            }
            collectionView.dataTapy = self.netFlag;
            collectionView.images = tempArray.copy;
            
            
            
        }];
        
       
        
    }else //加载本地数据
    {
        
        collectionView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
        

        NSMutableArray *imgArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 9; i++)
        {
         
            [imgArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        
        collectionView.images = imgArray.copy;
        collectionView.dataTapy = self.netFlag;

    }
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
