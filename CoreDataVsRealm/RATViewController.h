//
//  RATViewController.h
//  CoreDataVsRealm
//
//  Created by Artem Rakhmatulin on 05.07.2021.
//

@import UIKit;
@import CoreData;

typedef NS_ENUM(NSUInteger, WRITE_COUNT) {
    WRITE_COUNT_1 = 100,
    WRITE_COUNT_2 = 1000,
    WRITE_COUNT_3 = 10000
};

NS_ASSUME_NONNULL_BEGIN

@interface RATViewController : UIViewController

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

@end

NS_ASSUME_NONNULL_END
