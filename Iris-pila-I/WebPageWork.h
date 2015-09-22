//
//  WebPage.h
//  
//
//  Created by Jeffery Pereira on 6/29/15.
//
//

#import <Foundation/Foundation.h>

@interface WebPageWork : NSObject
{
    NSURL *url;
    NSString *title;
    NSMutableArray *tempArray;
    NSMutableArray *listOfArticles;
    NSMutableArray *featuredArticles;
    NSMutableArray *marray1;
    NSMutableArray *marray2;
}

- (void)initializeClassProperly:(NSURL *)u t:(NSString *)t;
- (void)initializeClassForFeature:(NSURL *)u t:(NSString *)t;
- (NSMutableArray *)featuredArticles;
- (NSMutableArray *)listOfArticles;





@end
