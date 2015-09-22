//
//  CoreDataHelper.h
//  Iris-pila-I
//
//  Created by Jeffery Pereira on 8/2/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, readonly) NSManagedObjectContext* context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore *store;

- (void)setUpCoreData;
- (void)saveContext; 

@end
