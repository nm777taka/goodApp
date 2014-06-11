#import "LFItem.h"


@interface LFItem ()

// Private interface goes here.

@end


@implementation LFItem

// Custom logic goes here.

+ (NSArray *)fetchSortedEntity
{
    NSArray *entity = [LFItem MR_findAll];
    
    
    return entity;
}

+ (NSArray *)fetchSortedEntityCheckedAtFirst
{
    NSPredicate *yesPre = [NSPredicate predicateWithFormat:@"%K = YES",@"isChecked"];
    NSArray *checkedItems = [LFItem MR_findAllWithPredicate:yesPre];
    
    NSArray *notCheckedItems = [self fetchSortedEntityOnlyNotChecked];
    
    NSArray* resultArray = [checkedItems arrayByAddingObjectsFromArray:notCheckedItems];
    
    NSLog(@"resulut array %d",resultArray.count);
    
    return resultArray;
}

+ (NSArray *)fetchSortedEntityOnlyNotChecked
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = NO",@"isChecked"];
    NSArray *notCheckedItems = [LFItem MR_findAllWithPredicate:predicate];
    
    NSLog(@"not checked %d",notCheckedItems.count);
    
    return notCheckedItems;
}

@end
