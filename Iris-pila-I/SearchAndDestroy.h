//
//  SearchAndDestroy.h
//  Iris-pila-I
//
//  Created by Jeffery Pereira on 8/5/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebPageWork.h"
#import "AppDelegate.h"
#import "Article.h"

@interface SearchAndDestroy : NSObject

@property (nonatomic, strong) NSMutableArray *coreDataArticles;
@property (nonatomic, strong) NSMutableArray *websiteArticles;
@property (nonatomic, strong) NSMutableArray *firstCharacters;

- (void)getCoreDataArticles:(AppDelegate *)app;
- (void)getWebsiteArticles;
- (void)betaFunction;
- (NSArray *)returnWebsiteArticles; 
- (void)removeFirstCharacters;
- (NSArray *)getArrayOfFreshArticles;
@end
