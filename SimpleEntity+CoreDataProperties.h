//
//  SimpleEntity+CoreDataProperties.h
//  CoreDataVsRealm
//
//  Created by Artem Rakhmatulin on 05.07.2021.
//
//

#import "SimpleEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SimpleEntity (CoreDataProperties)

+ (NSFetchRequest<SimpleEntity *> *)fetchRequest;

@property (nonatomic) float floatNum;
@property (nullable, nonatomic, copy) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
