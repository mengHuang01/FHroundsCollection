//
//  HHNetTools.h
//  roundsCollection
//
//  Created by qfh on 16/6/24.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>
typedef void(^finshBlcok)(id response);

@interface HHNetTools : AFHTTPSessionManager

+ (instancetype)sharedNetTools;


- (void)dataWithUrl:(NSString *)url finshBlcok:(finshBlcok)finshBlcok;


@end
