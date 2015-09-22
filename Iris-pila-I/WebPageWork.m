//
//  WebPage.m
//  
//
//  Created by Jeffery Pereira on 6/29/15.
//
//

#import "WebPageWork.h"
#import "TFHpple.h" 
#import "Article.h" 

@implementation WebPageWork

- (void)initializeClassProperly:(NSURL *)u t:(NSString *)t
{
    url = u;
    title = t;
    tempArray = [[NSMutableArray alloc] init];
    listOfArticles = [[NSMutableArray alloc] init];
    [self getListOfHrefs];
    [self initializeListOfArticles];
    [self finishUpInformation];
}

- (void)initializeClassForFeature:(NSURL *)u t:(NSString *)t
{
    url = u;
    title = t;
    marray1 = [[NSMutableArray alloc] init];
    marray2 = [[NSMutableArray alloc] init];
    
    NSData *htmlData = [NSData dataWithContentsOfURL:url];
    
    TFHpple *pageParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSString *XpathQueryString = @"//ul[@class='LinkList_5']/li/a/@href";
    
    NSArray *node = [pageParser searchWithXPathQuery:XpathQueryString];
    
    NSInteger j = 0;
    for(j = 0; j < 10; j++)
    {
        TFHppleElement *element = [node objectAtIndex:j];
        [marray1 addObject:[[element firstChild] content]];
    }
    j++;
    //Intiailizing them
    
    for(NSInteger i = 0; i < [marray1 count]; i++)
    {
        Article *a = [[Article alloc] init];
        
        a.subUrl = [marray1 objectAtIndex:i];
        
        [marray2 addObject:a];
    }
    
    //Finishing up information
    
    for(NSInteger i = 0; i < [marray1 count]; i++)
    {
        NSString *XPathQueryString = [NSString stringWithFormat:@"//a[@href='%@']", [marray1 objectAtIndex:i]];
        
        NSArray *node = [pageParser searchWithXPathQuery:XPathQueryString];
        
        Article *a = [marray2 objectAtIndex:i];
        
        [a createFinishedUrl:[url absoluteString]];
      
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        for(TFHppleElement *element in node)
        {
            [arr addObject:[[element firstChild] content]];
        }
        
        [a getOneName:arr];
        featuredArticles = marray2;
    }
}
- (NSMutableArray *)featuredArticles
{
    return featuredArticles;
}
- (void)getListOfHrefs
{
    NSData *htmlData = [NSData dataWithContentsOfURL: url];
    
    TFHpple *pageParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSString *XpathQueryString = @"//ul[@class='LinkList_5']/li/a/@href";
    NSArray *node = [pageParser searchWithXPathQuery:XpathQueryString];
    
    for(TFHppleElement *element in node)
    {
        [tempArray addObject:[[element firstChild] content]];
    }
}


- (void)initializeListOfArticles
{
    for(NSInteger i = 0; i < [tempArray count]; i++)
    {
        Article *a = [[Article alloc] init];
        a.subUrl = [tempArray objectAtIndex:i];
        [listOfArticles addObject:a];
    }
}

- (void)finishUpInformation
{
    NSData *htmlData = [NSData dataWithContentsOfURL: url];
    TFHpple *pageParser = [TFHpple hppleWithHTMLData:htmlData];
    
    for(NSInteger i = 0; i < [tempArray count]; i++)
    {
        NSString *XpathQueryString = [NSString stringWithFormat:@"//a[@href='%@']", [tempArray objectAtIndex:i]];
        
        NSArray *node = [pageParser searchWithXPathQuery:XpathQueryString];
        Article *a = [listOfArticles objectAtIndex:i];
        [a createFinishedUrl:[url absoluteString]];
        NSMutableArray *array = [[NSMutableArray alloc] init];
    
        for(TFHppleElement *element in node)
        {
            [array addObject:[[element firstChild] content]];
        }
        
        [a getOneName:array];
    }
}

- (NSMutableArray *)listOfArticles
{
    return listOfArticles;
}

@end
