// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LFItem.m instead.

#import "_LFItem.h"

const struct LFItemAttributes LFItemAttributes = {
	.isChecked = @"isChecked",
	.name = @"name",
	.num = @"num",
	.price = @"price",
};

const struct LFItemRelationships LFItemRelationships = {
};

const struct LFItemFetchedProperties LFItemFetchedProperties = {
};

@implementation LFItemID
@end

@implementation _LFItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Item";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Item" inManagedObjectContext:moc_];
}

- (LFItemID*)objectID {
	return (LFItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isCheckedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isChecked"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"num"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic isChecked;



- (BOOL)isCheckedValue {
	NSNumber *result = [self isChecked];
	return [result boolValue];
}

- (void)setIsCheckedValue:(BOOL)value_ {
	[self setIsChecked:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsCheckedValue {
	NSNumber *result = [self primitiveIsChecked];
	return [result boolValue];
}

- (void)setPrimitiveIsCheckedValue:(BOOL)value_ {
	[self setPrimitiveIsChecked:[NSNumber numberWithBool:value_]];
}





@dynamic name;






@dynamic num;



- (int16_t)numValue {
	NSNumber *result = [self num];
	return [result intValue];
}

- (void)setNumValue:(int16_t)value_ {
	[self setNum:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveNumValue {
	NSNumber *result = [self primitiveNum];
	return [result intValue];
}

- (void)setPrimitiveNumValue:(int32_t)value_ {
	[self setPrimitiveNum:[NSNumber numberWithInt:value_]];
}





@dynamic price;



- (int16_t)priceValue {
	NSNumber *result = [self price];
	return [result intValue];
}

- (void)setPriceValue:(int16_t)value_ {
	[self setPrice:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result intValue];
}

- (void)setPrimitivePriceValue:(int32_t)value_ {
	[self setPrimitivePrice:[NSNumber numberWithInt:value_]];
}










@end
