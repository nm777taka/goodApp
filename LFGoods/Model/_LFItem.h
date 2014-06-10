// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LFItem.h instead.

#import <CoreData/CoreData.h>


extern const struct LFItemAttributes {
	__unsafe_unretained NSString *isChecked;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *num;
	__unsafe_unretained NSString *price;
} LFItemAttributes;

extern const struct LFItemRelationships {
} LFItemRelationships;

extern const struct LFItemFetchedProperties {
} LFItemFetchedProperties;







@interface LFItemID : NSManagedObjectID {}
@end

@interface _LFItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LFItemID*)objectID;





@property (nonatomic, strong) NSNumber* isChecked;



@property BOOL isCheckedValue;
- (BOOL)isCheckedValue;
- (void)setIsCheckedValue:(BOOL)value_;

//- (BOOL)validateIsChecked:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* num;



@property int32_t numValue;
- (int32_t)numValue;
- (void)setNumValue:(int32_t)value_;

//- (BOOL)validateNum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* price;



@property int32_t priceValue;
- (int32_t)priceValue;
- (void)setPriceValue:(int32_t)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;






@end

@interface _LFItem (CoreDataGeneratedAccessors)

@end

@interface _LFItem (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsChecked;
- (void)setPrimitiveIsChecked:(NSNumber*)value;

- (BOOL)primitiveIsCheckedValue;
- (void)setPrimitiveIsCheckedValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveNum;
- (void)setPrimitiveNum:(NSNumber*)value;

- (int32_t)primitiveNumValue;
- (void)setPrimitiveNumValue:(int32_t)value_;




- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (int32_t)primitivePriceValue;
- (void)setPrimitivePriceValue:(int32_t)value_;




@end
