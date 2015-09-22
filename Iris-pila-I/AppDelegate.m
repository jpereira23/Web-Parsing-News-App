//
//  AppDelegate.m
//  Iris-pila-I
//
//  Created by Jeffery Pereira on 7/31/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "AppDelegate.h"
#import "WebPageWork.h" 
#import "Article.h"
#import "SearchAndDestroy.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define debug 1

- (CoreDataHelper *)cdh
{
    if(debug==1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if(!_coreDataHelper)
    {
        _coreDataHelper = [CoreDataHelper new];
        [_coreDataHelper setUpCoreData];
    }
    
    return _coreDataHelper;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption
{
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    return YES;
}

- (void)application:(nonnull UIApplication *)application performFetchWithCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    
    SearchAndDestroy *search = [[SearchAndDestroy alloc] init];
    [search getCoreDataArticles:self];
    [search getWebsiteArticles];
    [search getArrayOfFreshArticles];
    NSArray *array = [search getArrayOfFreshArticles];
    self.officialNew = [[NSMutableArray alloc] initWithArray:array];
    
    NSLog(@"performFetchWithCompletionHandler");
    if([self isCoreDataEmpty])
    {
        [self initializeCoreData];
    }
    NSDate *fetchStart = [NSDate date];
    
            
    [self fetchNewDataWithCompletionHandler:^(UIBackgroundFetchResult result) {
        completionHandler(result);
        
        NSDate *fetchEnd = [NSDate date];
        NSTimeInterval timeElapsed = [fetchEnd timeIntervalSinceDate:fetchStart];
        NSLog(@"Background Fetch Duration: %f seconds", timeElapsed);
        
    }];
}

- (BOOL)application:(nonnull UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)initializeCoreData
{
    NSLog(@"initializing");
    SearchAndDestroy *search = [[SearchAndDestroy alloc] init];
    [search getWebsiteArticles];
    [search removeFirstCharacters];
    NSArray *array = [search returnWebsiteArticles];
    self.articles = [[NSMutableArray alloc] initWithArray:array];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Article"];
    NSError *error = nil;
    for(NSInteger i = 0; i < [self.articles count]; i++)
    {
        Article *a = [self.articles objectAtIndex:i];
        [a getStory];
        [a getImage];
        NSManagedObject *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
        [newArticle setValue:a.titleOfArticle forKey:@"title"];
        [newArticle setValue:a.story forKey:@"story"];
        NSData *imageData = UIImageJPEGRepresentation(a.image, 1.0);
        [newArticle setValue:imageData forKey:@"image"];
        [context save:&error];
    }

}
- (BOOL)isCoreDataEmpty
{
    NSLog(@"isCoreDataEmpty");
    NSArray *temp;
    NSMutableArray *temp1;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Article"];
    temp = [context executeFetchRequest:request error:nil];
    temp1 = [[NSMutableArray alloc] initWithArray:temp];
    if([temp1 count] == 0)
    {
        return YES;
    }
    
    return NO;
}

- (void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"fetchNewDataWithCompletionHandler");
    Article *a = [self.officialNew firstObject];
    [self.officialNew removeObjectAtIndex:0];
    NSLog(@"%@", a.titleOfArticle);
    [a getStory];
    [a getImage];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newContext = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
    [newContext setValue:a.titleOfArticle forKey:@"title"];
    [newContext setValue:a.story forKey:@"story"];
    NSData *imageData = UIImageJPEGRepresentation(a.image, 1.0);
    [newContext setValue:imageData forKey:@"image"];
    
    [context save:nil];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.JPereira.Iris_pila_I" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Iris_pila_I" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Iris_pila_I.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


/*- (NSManagedObjectContext *)setupManagedObjectContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
}
 */
- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
