//
//  StoryViewController.m
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/25/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "StoryViewController.h"
#import "Article.h" 
#import "SLColorArt.h"


@interface StoryViewController ()


@end

@implementation StoryViewController

@synthesize image = _image;
@synthesize label = _label;
@synthesize story = _story;

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Article"];
    
    NSArray *article = [context executeFetchRequest:request error:nil];
    
    NSManagedObjectContext *newCont = [article objectAtIndex:self.i];
    
    NSData *data = [newCont valueForKey:@"image"];
    UIImage *image = [UIImage imageWithData:data];
    
    SLColorArt *art = [[SLColorArt alloc] initWithImage:image];
    self.view.backgroundColor = art.primaryColor;
    self.image.image = image;
    
    self.label.text = [newCont valueForKey:@"title"];
    
    
    self.label.backgroundColor = [UIColor lightGrayColor];
    self.label.textColor = art.primaryColor;
    self.story.text = [newCont valueForKey:@"story"];
    self.story.backgroundColor = [UIColor lightGrayColor];
    self.story.textColor = art.primaryColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInteger:(NSInteger)integer
{
    self.i = integer;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
