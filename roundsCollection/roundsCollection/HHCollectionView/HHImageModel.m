//
//  HHImageModel.m
//  roundsCollection
//
//  Created by qfh on 16/6/24.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import "HHImageModel.h"
#import "HHNetTools.h"
#import <YYModel.h>

@implementation HHImageModel


+ (void)imageWith:(complete)complete
{
    [[HHNetTools sharedNetTools] dataWithUrl:@"http://c.m.163.com/nc/ad/headline/0-4.html" finshBlcok:^(id response) {
        
        NSArray *array = ((NSDictionary *)response)[@"headline_ad"];
        
        NSMutableArray *tmepArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            [tmepArray addObject:[HHImageModel yy_modelWithDictionary:dict]];
        }
        
        complete(tmepArray.copy);
        
        
    }];
}
@end
