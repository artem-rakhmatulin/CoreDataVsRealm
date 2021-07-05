//
//  AppDelegate.h
//  CoreDataVsRealm
//
//  Created by Artem Rakhmatulin on 05.07.2021.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) UIWindow *window;

- (void)saveContext;

@end

