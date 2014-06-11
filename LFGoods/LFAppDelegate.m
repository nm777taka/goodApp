//
//  LFAppDelegate.m
//  LFGoods
//
//  Created by 古田貴久 on 2014/06/07.
//  Copyright (c) 2014年 古田貴久. All rights reserved.
//

#import "LFAppDelegate.h"
#import "LFItem.h"

@implementation LFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //MR初期化処理
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"LFGoods.sql"];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // ２回目以降の起動時
    }
    else
    {
        // 初回起動時
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //グッズをCoreDataに登録（初期値)
        NSDictionary *dict = @{@"パンフレット":@"3000", //NSNumberで格納
                               @"ポスターtypeA":@"1000",
                               @"ポスターtypeB":@"1000",
                               @"ポストカードAセット":@"500",
                               @"ポストカードBセット":@"500",
                               @"ポストカードCセット":@"500",
                               @"NANACA Collection File":@"2500",
                               @"リストバンドA(BLACK)":@"1000",
                               @"リストバンドB(RED)":@"1000",
                               @"NANA シュシュ":@"1200",
                               @"マフラータオル":@"2700",
                               @"ビーチタオル":@"4500",
                               @"NM-TEE A":@"3000",
                               @"NM-TEE B":@"3000",
                               @"NM-TEE C":@"3000",
                               @"FLIGHT-LIMITED TEE":@"3000",
                               @"FLIGHT☆ワークシャツ":@"6900",
                               @"ペンライト FLIGHT Edition":@"1600",
                               @"FLIGHT☆CAP":@"3000",
                               @"FLIGHT☆キーリングストラップ":@"1500",
                               @"ドッグダグ":@"1800",
                               @"iPhoneケース":@"3500",
                               @"ナネットさんのiPhoneカバー":@"2800",
                               @"ポータブルボストンバッグ":@"3800",
                               @"FLIGHT☆オーガナイザー":@"4800",
                               @"FLIGHT☆エアラインバッグ":@"7700",
                               @"ピンズ":@"700",
                               @"nm7レインポンチョ":@"3500"
                               };
        
                
        
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        NSArray *keys = [NSArray new];
        keys = [dict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        for (NSString *key in keys) {
            
            LFItem* newItem = [LFItem MR_createEntity];
            newItem.name = key;
            newItem.num = 0;
            newItem.isChecked = [NSNumber numberWithBool:NO];
            newItem.priceValue = [dict[key] intValue];
        }
        
        
        [context MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"------> saved!!!!");
                //NSPredicate *pre = [NSPredicate predicateWithFormat:@"(%K = NO )",@"isChecked"];
                //NSLog(@"item num is %d",[LFItem MR_countOfEntitiesWithPredicate:pre]);
                
            } else {
                NSLog(@"error : %@",error);
            }
        }];

        
        
    }

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


+ (instancetype)sharedManager
{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedManager = [[self alloc]init];
    });
    
    return _sharedManager;
}

- (NSArray *)fetchAllKeys
{
    return [self.detailDict allKeys];
}




@end
