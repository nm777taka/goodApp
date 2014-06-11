#import "_LFItem.h"

@interface LFItem : _LFItem {}
// Custom logic goes here.

+ (NSArray *)fetchSortedEntity;
+ (NSArray *)fetchSortedEntityCheckedInEnd;
+ (NSArray *)fetchSortedEntityOnlyNotChecked;

@end
