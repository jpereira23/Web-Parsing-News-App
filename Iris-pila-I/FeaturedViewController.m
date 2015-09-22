//
//  FeaturedViewController.m
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/25/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "FeaturedViewController.h"
#import "WebPageWork.h" 
#import "Article.h"
#import "StoryViewController.h"
#import "ArticlesTableViewCell.h" 

@interface FeaturedViewController ()

@end

@implementation FeaturedViewController
{
    NSArray *articles;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Article"];
    
    articles = [context executeFetchRequest:request error:nil];
    
    
    
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
    StoryViewController *story = (StoryViewController *)[storyboard instantiateViewControllerWithIdentifier:@"storyView"];
    [story getInteger:indexPath.row];
    [self.navigationController pushViewController:story animated:YES];
        
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 210;
}
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ArticlesTableViewCell *cell = (ArticlesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"articleCell" forIndexPath:indexPath];
    
    NSManagedObjectContext *newCont = [articles objectAtIndex:indexPath.row];
    tableView.separatorColor = [UIColor lightGrayColor];
    cell.label.text = [newCont valueForKey:@"title"];
    NSData *data = [newCont valueForKey:@"image"];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;
    cell.label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    cell.label.textColor = [UIColor whiteColor];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
