//
//  Article.h
//  JPWebPageInfo
//
//  Created by Jeffery Pereira on 6/30/15.
//  Copyright (c) 2015 Jeffery Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Article : NSObject

@property NSString *subUrl;
@property NSString *titleOfArticle;
@property NSString *finishedUrl;
@property NSString *story;
@property NSString *rootUrl;
@property NSMutableArray *NoticiasRelacionades;
@property UIImage *image;

- (void)getOneName:(NSMutableArray *)arrayOfNames;
- (void)createFinishedUrl:(NSString *)rootUrl;
- (void)getStory;
- (BOOL)checkForImage;
- (void)getImage;

- (void)getNoticiasRelacionades;

@end
