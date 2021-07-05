//
//  RATViewController.m
//  CoreDataVsRealm
//
//  Created by Artem Rakhmatulin on 05.07.2021.
//


#import "RATViewController.h"

#import "SimpleEntity+CoreDataProperties.h"
#import "RATSimpleRLMObject.h"

#import <Realm/Realm.h>
@import CoreData;

@interface RATViewController ()

@property (weak, nonatomic) IBOutlet UILabel *writeTitleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *writeTitleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *writeTitleLabel3;

@property (weak, nonatomic) IBOutlet UILabel *coreDataWrite1ResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *coreDataWrite2ResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *coreDataWrite3ResultLabel;

@property (weak, nonatomic) IBOutlet UILabel *realmWrite1ResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *realmWrite2ResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *realmWrite3ResultLabel;

@property (weak, nonatomic) IBOutlet UILabel *coreDataObjCnt;
@property (weak, nonatomic) IBOutlet UILabel *realmObjCnt;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation RATViewController

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.writeTitleLabel1.text = [NSString stringWithFormat:@"sw%tu", WRITE_COUNT_1];
    self.writeTitleLabel2.text = [NSString stringWithFormat:@"sw%tu", WRITE_COUNT_2];
    self.writeTitleLabel3.text = [NSString stringWithFormat:@"sw%tu", WRITE_COUNT_3];
    
    [self updateObjCntLabels];
} // viewDidLoad

#pragma mark - Actions

- (IBAction)startButtonAction
{
    [self writeTestWithCount:WRITE_COUNT_1];
    [self writeTestWithCount:WRITE_COUNT_2];
    [self writeTestWithCount:WRITE_COUNT_3];
    
    [self updateObjCntLabels];
} // startButtonAction

#pragma mark - Tests
- (void)writeTestWithCount:(WRITE_COUNT)count
{
    // Setup
    NSDate *startDate;
    NSError *err;
    
    // Core Data
    NSManagedObjectContext *moc = self.persistentContainer.viewContext;
    startDate = [NSDate date];
    
    for (int i = 0; i < count; i++)
    {
        SimpleEntity *simpleEntity = [NSEntityDescription insertNewObjectForEntityForName:@"SimpleEntity" inManagedObjectContext:moc];
        simpleEntity.floatNum = (float)i;
        simpleEntity.uuid = [[NSUUID UUID] UUIDString];
    }
    
    if ([moc save:&err])
    {
        NSTimeInterval timeIntervalSinceStart = [[NSDate date] timeIntervalSinceDate:startDate];
        
        switch (count)
        {
            case WRITE_COUNT_1:
                self.coreDataWrite1ResultLabel.text = [NSString stringWithFormat:@"%.3fs", timeIntervalSinceStart];
                break;
                
            case WRITE_COUNT_2:
                self.coreDataWrite2ResultLabel.text = [NSString stringWithFormat:@"%.3fs", timeIntervalSinceStart];
                break;
                
            case WRITE_COUNT_3:
                self.coreDataWrite3ResultLabel.text = [NSString stringWithFormat:@"%.3fs", timeIntervalSinceStart];
                break;
        }
    } else {
        NSLog(@"%@", err.localizedDescription);
    }
    
    // Teardown
    startDate = nil;
    err = nil;
    
    // Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    startDate = [NSDate date];
    
    [realm beginWriteTransaction];
    for (int i = 0; i < count; i++)
    {
        RATSimpleRLMObject *simpleRLMObject = [[RATSimpleRLMObject alloc] init];
        simpleRLMObject.floatNum = (float)i;
        simpleRLMObject.uuid = [[NSUUID UUID] UUIDString];
        [realm addObject:simpleRLMObject];
    }
    [realm commitWriteTransaction:&err];

    if (err)
    {
        NSLog(@"%@", err.localizedDescription);
    } else {
        NSTimeInterval timeIntervalSinceStart = [[NSDate date] timeIntervalSinceDate:startDate];
        
        switch (count)
        {
            case WRITE_COUNT_1:
                self.realmWrite1ResultLabel.text = [NSString stringWithFormat:@"%.3fs", timeIntervalSinceStart];
                break;
                
            case WRITE_COUNT_2:
                self.realmWrite2ResultLabel.text = [NSString stringWithFormat:@"%.3fs", timeIntervalSinceStart];
                break;
                
            case WRITE_COUNT_3:
                self.realmWrite3ResultLabel.text = [NSString stringWithFormat:@"%.3fs", timeIntervalSinceStart];
                break;
        }
    }
    
} // writeTestWithCount:

#pragma mark - Private

- (void)updateObjCntLabels
{
    // Core Data
    NSManagedObjectContext *moc = self.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SimpleEntity"];
    NSError *err;
    
    NSUInteger coreDataObjCnt = [moc countForFetchRequest:fetchRequest error:&err];
    
    if (err)
    {
        NSLog(@"%@", err.localizedDescription);
    } else {
        self.coreDataObjCnt.text = [NSString stringWithFormat:@"%tu", coreDataObjCnt];
    }
    
    //Realm
    RLMResults<RATSimpleRLMObject *> *results = [RATSimpleRLMObject allObjects];
    if (results)
    {
        NSUInteger realmObjCnt = results.count;
        self.realmObjCnt.text = [NSString stringWithFormat:@"%tu", realmObjCnt];
    }

} // updateObjCntLabels

@end
