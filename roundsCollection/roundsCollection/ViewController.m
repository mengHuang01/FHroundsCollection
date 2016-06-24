//
//  ViewController.m
//  roundsCollection
//
//  Created by qfh on 16/6/23.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import "ViewController.h"
#import "HHCollectionViewController.h"

@interface ViewController ()






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
}
- (IBAction)localData:(id)sender {
    HHCollectionViewController *collectionVC = [[HHCollectionViewController alloc]init];
    
    collectionVC.netFlag = NO;
    
    [self.navigationController pushViewController:collectionVC animated:YES];
    
    
}
- (IBAction)netData:(id)sender {
    
    HHCollectionViewController *collectionVC = [[HHCollectionViewController alloc]init];
    
    collectionVC.netFlag = YES;
    
    [self.navigationController pushViewController:collectionVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
