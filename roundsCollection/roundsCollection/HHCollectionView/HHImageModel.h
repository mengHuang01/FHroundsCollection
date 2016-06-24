//
//  HHImageModel.h
//  roundsCollection
//
//  Created by qfh on 16/6/24.
//  Copyright © 2016年 qiufuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^complete)(NSArray *imageArray);

@interface HHImageModel : NSObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imgsrc;


+ (void)imageWith:(complete)complete;


@end
