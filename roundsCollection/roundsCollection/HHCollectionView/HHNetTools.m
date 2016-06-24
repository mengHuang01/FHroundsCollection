//
//  HHNetTools.m
//  roundsCollection
//
//  Created by qfh on 16/6/24.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import "HHNetTools.h"

@implementation HHNetTools

+ (instancetype)sharedNetTools
{
    static dispatch_once_t onceToken;
    static HHNetTools *_tools;
    dispatch_once(&onceToken, ^{
        _tools = [[self alloc]init];
    });
    
    return _tools;
}


- (void)dataWithUrl:(NSString *)url finshBlcok:(finshBlcok)finshBlcok
{
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finshBlcok(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
@end
