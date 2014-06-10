//
//  LFManager.h
//  LFGoods
//
//  Created by 古田貴久 on 2014/06/07.
//  Copyright (c) 2014年 古田貴久. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,strong,readonly)NSArray *goodsArray;

@end
