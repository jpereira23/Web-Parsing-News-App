//
//  SearchAndDestroy.m
//  Iris-pila-I
//
//  Created by Jeffery Pereira on 8/5/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "SearchAndDestroy.h"

@implementation SearchAndDestroy



- (void)getCoreDataArticles:(AppDelegate *)app
{
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Article"];
    NSArray *temp = [context executeFetchRequest:request error:nil];
    self.coreDataArticles = [[NSMutableArray alloc] init];
    
    for(NSInteger i = 0; i < [temp count]; i++)
    {
        NSManagedObjectContext *newContext = [temp objectAtIndex:i];
        if([newContext valueForKey:@"title"] != nil)
            [self.coreDataArticles addObject:[newContext valueForKey:@"title"]];
    }
    
    [self.coreDataArticles setArray:[[NSSet setWithArray:self.coreDataArticles] allObjects]];
    
    [self.coreDataArticles sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    [self printCoreData];
}

- (void)getWebsiteArticles
{
    WebPageWork *w = [[WebPageWork alloc] init];
    [w initializeClassProperly:[NSURL URLWithString:@"http://www.ojogo.pt"] t:@"O Jogo"];
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    temp = [w listOfArticles];
    self.websiteArticles = [[NSMutableArray alloc] init];
    for(NSInteger i = 0; i < [temp count]; i++)
    {
        Article *a = [temp objectAtIndex:i];
        [self.websiteArticles addObject: a];
    }
    [self.websiteArticles sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"titleOfArticle" ascending:YES], nil]];
    [self removeDuplicateObjects];
    [self betaFunction];
    [self printWebsites];
}

- (NSArray *)returnWebsiteArticles
{
    return self.websiteArticles;
}

- (void)printWebsites
{
    NSLog(@"PRINTING WEBSITES");
    
    for(NSInteger i = 0; i < [self.websiteArticles count]; i++)
    {
        Article *a = [self.websiteArticles objectAtIndex:i];
        NSLog(@"%@", a.titleOfArticle);
    }
}
- (void)printCoreData
{
    NSLog(@"PRINTING CORE DATA");
    for(NSInteger i = 0; i < [self.coreDataArticles count]; i++)
    {
        NSLog(@"%@", [self.coreDataArticles objectAtIndex:i]);
    }
}

- (void)printBetaFunction
{
    for(NSInteger i = 0; i < [self.firstCharacters count]; i++)
    {
        NSLog(@"first characters: %@", [self.firstCharacters objectAtIndex:i]);
    }
}
- (void)betaFunction
{
    Article *index;
    self.firstCharacters = [[NSMutableArray alloc] init];
    
    NSInteger counter = 0;
    for(NSInteger i = 0; i < [self.websiteArticles count]; i++)
    {
       
        Article *a;
        index = [self.websiteArticles objectAtIndex:i];
        NSString *subletter = [index.titleOfArticle substringToIndex:1];
        if([self.firstCharacters count] == 0)
        {
            a = [[Article alloc] init];
            [self.firstCharacters addObject:subletter];
            a.titleOfArticle = subletter;
            [self.websiteArticles insertObject:a atIndex:0];
        }
        else if(![subletter isEqualToString:[self.firstCharacters objectAtIndex:counter]])
        {
            a = [[Article alloc] init];
            [self.firstCharacters addObject:subletter];
            a.titleOfArticle = subletter;
            [self.websiteArticles insertObject:a atIndex:i];
            counter++;
        }
        
    }
    
    [self printBetaFunction];
}

- (void)removeDuplicateObjects
{
    for(NSInteger i = 0; i < [self.websiteArticles count]; i++)
    {
        NSInteger j = i;
        Article *a1 = [self.websiteArticles objectAtIndex:i];
        BOOL flag = YES;
        while(flag == YES)
        {
            if(j+1 < [self.websiteArticles count])
            {
                Article *a2 = [self.websiteArticles objectAtIndex:j+1];
            
                if([a1.titleOfArticle isEqualToString:a2.titleOfArticle])
                {
                    [self.websiteArticles removeObjectAtIndex:j+1];
                    //j++;
                }
                else
                {
                    flag = NO;
                }
            }
            else
                flag = NO;
        }
    }
}

- (BOOL)isItInFirstCharacter:(NSString *)letter
{
    for(NSInteger i = 0; i < [self.firstCharacters count]; i++)
    {
        if([[self.firstCharacters objectAtIndex:i] isEqualToString:letter])
            return YES;
    }
    
    return NO;
}

- (NSInteger)findLetter:(NSString *)letter
{
    for(NSInteger i = 0; i < [self.websiteArticles count]; i++)
    {
        Article *a = [self.websiteArticles objectAtIndex:i];
        NSString *temp = [a.titleOfArticle substringToIndex:1];
        if([temp isEqualToString:letter])
        {
            return i;
        }
    }
    return NSNotFound;
}

- (NSInteger)returnIndexOfNextCharacter:(NSString *)letter
{
    for(NSInteger i = 0; i < [self.firstCharacters count]; i++)
    {
        if([[self.firstCharacters objectAtIndex:i] isEqualToString:letter])
        {
            if((i+1) < [self.firstCharacters count])
            {
                return [self findLetter:[self.firstCharacters objectAtIndex:i+1]];
            }
            else
            {
                return [self.websiteArticles count]-1;
            }
        }
    }
    return NSNotFound;
}

- (NSInteger)checkArrayOfProvidedRanges:(NSInteger)firstIndex :(NSInteger)secondIndex :(NSString *)title
{
    for(NSInteger i = firstIndex; i < secondIndex; i++)
    {
        Article *a = [self.websiteArticles objectAtIndex:i];
        if([a.titleOfArticle isEqualToString:title])
        {
            return i;
        }
    }
    
    return NSNotFound;
}
- (void)removeFirstCharacters
{
    NSInteger counter = 0;
    for(NSInteger i = 0; i < [self.websiteArticles count]; i++)
    {
        Article *a = [self.websiteArticles objectAtIndex:i];
        if(counter >= [self.firstCharacters count])
        {
            break;
        }
        else if((counter < [self.firstCharacters count]) && [[self.firstCharacters objectAtIndex:counter] isEqualToString:a.titleOfArticle])
        {
            [self.websiteArticles removeObjectAtIndex:i];
            ++counter;
            a = [self.websiteArticles objectAtIndex:i];
             if((counter < [self.firstCharacters count]) && [[self.firstCharacters objectAtIndex:counter] isEqualToString:a.titleOfArticle])
             {
                 [self.websiteArticles removeObjectAtIndex:i];
                 ++counter;
             }
        }
    }
}
- (NSArray *)getArrayOfFreshArticles
{
    if([self.websiteArticles count] == 2)
    {
        [self.websiteArticles removeObjectAtIndex:0];
    }
    else
    {
        for(NSInteger i = 0; i < [self.coreDataArticles count]; i++)
        {
            NSString *word = [self.coreDataArticles objectAtIndex:i];
            //NSLog(@"title of article: %@", word);
            NSString *letter = [word substringToIndex:1];
            if([self isItInFirstCharacter:letter])
            {
                NSInteger theInt = [self findLetter:letter];
            
                //NSLog(@"The integer for letter: %ld", theInt);
        
                NSInteger newInt = [self returnIndexOfNextCharacter:letter];
                
                //NSLog(@"The integer of the next letter %ld", newInt);
        
                NSInteger delete = [self checkArrayOfProvidedRanges:theInt :newInt :word];
        
                if(delete != NSNotFound)
                    [self.websiteArticles removeObjectAtIndex:delete];
        
            }
        }
    }
    [self removeFirstCharacters];
    [self printWebsites];
   
    
    return self.websiteArticles;
}
@end
