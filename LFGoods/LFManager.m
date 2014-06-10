//
//  LFManager.m
//  LFGoods
//
//  Created by 古田貴久 on 2014/06/07.
//  Copyright (c) 2014年 古田貴久. All rights reserved.
//

#import "LFManager.h"

@interface LFManager()

@property (nonatomic,strong,readwrite) NSArray* goodArray;

@end

@implementation LFManager

//シングルトン
+ (instancetype)sharedManager
{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        self.goodArray = [NSArray new];
        [self setGoodList];
        
    }
    
    return self;
}

- (void)setGoodList
{
    self.goodArray = @[@"Tシャツ"];
}


@end
