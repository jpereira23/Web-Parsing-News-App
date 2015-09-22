//
//  CoreDataHelper.m
//  Iris-pila-I
//
//  Created by Jeffery Pereira on 8/2/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper
#define debug 1

NSString *storeFilename = @"Iris_pila_I.sqlite";

- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSURL *)applicationStoresDirectory
{
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"Articles"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:[storesDirectory path]])
    {
        NSError *error = nil;
        if([fileManager createDirectoryAtPath:storesDirectory withIntermediateDirectories:YES attributes:nil error:&error])
        {
            if(debug==1)
                NSLog(@"Successfully created Articles directory");
            else
                NSLog(@"FAILED to create Articles Directory");
        }
    }
    return storesDirectory;
}

- (NSURL *)storeURL
{
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

- (id)init
{
    self = [super init];
    if(!self)
        return nil;
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [_context setPersistentStoreCoordinator:_coordinator];
    
    return self;
}

- (void)loadStore
{
    if(_store)
        return;
    
    NSDictionary *options = @{NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}};
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:options error:&error];
    
    
    if(!_store)
         NSLog(@"Failed to add store. Error %@", error);
    else
    {
        if(debug == 1)
            NSLog(@"Successfully added article: %@", _store);
    }
}

- (void)setUpCoreData
{
    [self loadStore];
}

- (void)saveContext
{
   if([_context hasChanges])
   {
       NSError *error = nil;
       if([_context save:&error])
           NSLog(@"_context SAVED changes to persistent store");
       else
           NSLog(@"Failed to save _context %@", error);
   }
    else
        NSLog(@"SKIPPED");
}
@end
