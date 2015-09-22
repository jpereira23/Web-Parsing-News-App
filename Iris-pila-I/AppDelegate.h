//
//  AppDelegate.h
//  Iris-pila-I
//
//  Created by Jeffery Pereira on 7/31/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelper.h" 

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) NSMutableArray *oldArticles;
@property (strong, nonatomic) NSMutableArray *theArticles;
@property (strong, nonatomic) NSMutableArray *theNewArticles;
@property (strong, nonatomic) NSMutableArray *finalDeal; 
@property (strong, nonatomic) NSMutableArray *theOldArticles;
@property (strong, nonatomic) NSMutableArray *articles;
@property (strong, nonatomic) NSMutableArray *officialNew;
@property (strong, nonatomic) NSMutableArray *onesToDelete;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *tempNew;
@property (strong, nonatomic) NSMutableArray *tempOld;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) CoreDataHelper *coreDataHelper;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObjectContext *)managedObjectContext;
- (void)fetchNewDataWithCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler;
- (BOOL)isCoreDataEmpty;
- (void)initializeCoreData;
- (void)checkForNewArticles;
- (void)makeThingsRight; 
- (void)getOldArticles;
- (void)getNewArticles;
- (void)deleteArticles;

@end

