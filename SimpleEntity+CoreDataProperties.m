//
//  SimpleEntity+CoreDataProperties.m
//  CoreDataVsRealm
//
//  Created by Artem Rakhmatulin on 05.07.2021.
//
//

#import "SimpleEntity+CoreDataProperties.h"

@implementation SimpleEntity (CoreDataProperties)

+ (NSFetchRequest<SimpleEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SimpleEntity"];
}

@dynamic floatNum;
@dynamic uuid;

@end
