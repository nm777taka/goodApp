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

+ (NSArray *)fetchSortedEntityCheckedInEnd
{
    NSPredicate *yesPre = [NSPredicate predicateWithFormat:@"%K = YES",@"isChecked"];
    NSArray *checkedItems = [LFItem MR_findAllSortedBy:@"name" ascending:YES withPredicate:yesPre];
    
    NSArray *notCheckedItems = [self fetchSortedEntityOnlyNotChecked];
    
    NSArray* resultArray = [notCheckedItems arrayByAddingObjectsFromArray:checkedItems];
    
    NSLog(@"resulut array %d",resultArray.count);
    
    return resultArray;
}

+ (NSArray *)fetchSortedEntityOnlyNotChecked
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = NO",@"isChecked"];
    NSArray *notCheckedItems = [LFItem MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate];
    
    NSLog(@"not checked %d",notCheckedItems.count);
    
    return notCheckedItems;
}

@end
