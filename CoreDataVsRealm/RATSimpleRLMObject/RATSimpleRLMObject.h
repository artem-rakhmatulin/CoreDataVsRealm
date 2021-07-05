//
//  RATSimpleRLMObject.h
//  CoreDataVsRealm
//
//  Created by Artem Rakhmatulin on 05.07.2021.
//

#import <Realm/Realm.h>
#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RATSimpleRLMObject : RLMObject

@property (nonatomic) float floatNum;
@property (nullable, nonatomic, copy) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
