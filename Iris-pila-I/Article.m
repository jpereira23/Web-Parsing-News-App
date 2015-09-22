//
//  Article.m
//  JPWebPageInfo
//
//  Created by Jeffery Pereira on 6/30/15.
//  Copyright (c) 2015 Jeffery Pereira. All rights reserved.
//

#import "Article.h"
#import "TFHpple.h"

@implementation Article


- (void)getOneName:(NSMutableArray *)arrayOfNames
{
    NSInteger i = 0;
    while([[arrayOfNames objectAtIndex:i] isEqualToString:@""])
    {
        i++;
    }
    
    self.titleOfArticle = [arrayOfNames objectAtIndex:i];
}

- (void)createFinishedUrl:(NSString *)rootUrl
{
    NSString *temp = [rootUrl stringByAppendingString:self.subUrl];
    self.rootUrl = rootUrl;
    self.finishedUrl = temp;
    

}

- (void)getStory
{
    //NSMutableArray *stories = [[NSMutableArray alloc] init];
    NSString *work;
    NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.finishedUrl]];
    
    TFHpple *pageParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSString *XPathQueryString = @"//div[@class='ArtText_1']";
    
    NSArray *node = [pageParser searchWithXPathQuery:XPathQueryString];
    
    for(TFHppleElement *element in node)
    {
        work = [[element firstChild] content];
    }
    
    NSRange range = [work rangeOfString:@"window.onload"];
    self.story  = [work substringToIndex:range.location];
    
    //self.story = [self threeArticleRendevous:self.story];
    [self getNoticiasRelacionades];
}

- (void)getNoticiasRelacionades
{
    NSMutableArray *theArray = [[NSMutableArray alloc] init];
    NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.finishedUrl]];
    
    TFHpple *pageParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSString *XPathQueryString = @"//div[@class='LinkList_Rel']//strong";
    
    NSArray *node = [pageParser searchWithXPathQuery:XPathQueryString];
    
    for(TFHppleElement *element in node)
    {
        [theArray addObject:[[element firstChild] content]];
    }
    
    self.NoticiasRelacionades = theArray;
    
    NSString *temp = self.story;
    
    temp = [temp stringByReplacingOccurrencesOfString:@"Notícias Relacionadas" withString:@""];
    
    self.story = temp;
    
    
    for(NSInteger i = 0; i < [theArray count]; i++)
    {
        temp = self.story;
        
        temp = [temp stringByReplacingOccurrencesOfString:[theArray objectAtIndex:i] withString:@""];
        
        self.story = temp;
    }
    //[self getImage];
}

- (BOOL)checkForImage
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.finishedUrl]];
    
    TFHpple *pageParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSString *XPathQueryString = @"//figure[@class='ArtPic_1']/img/@src";
    
    NSArray *node = [pageParser searchWithXPathQuery:XPathQueryString];
    
    for(TFHppleElement *element in node)
    {
        [array addObject:[[element firstChild] content]];
    }
    
    if([array count] == 0)
        return FALSE;
    
    return TRUE;
}
- (void)getImage
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.finishedUrl]];
    
    TFHpple *pageParser = [TFHpple hppleWithHTMLData:htmlData];
    
    NSString *XPathQueryString = @"//figure[@class='ArtPic_1']/img/@src";
    
    NSArray *node = [pageParser searchWithXPathQuery:XPathQueryString];
    
    for(TFHppleElement *element in node)
    {
        [array addObject:[[element firstChild] content]];
    }
    
    NSString *fullURL;
    if([array count] != 0)
    {
        fullURL = [self.rootUrl stringByAppendingString:[array objectAtIndex:0]];
        
        self.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fullURL]]];
    }
    
    
    //self.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:[NSURL URLWithString:@"http://www.ojogo.pt/storage/OJ/2015/big/ng4430197.jpg?type=big"]]];
}


@end
