//
//  MenuViewController.m
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/25/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "FeaturedViewController.h"
#import "AllArticlesViewController.h" 


@interface MenuViewController ()

@end

@implementation MenuViewController
{
    NSArray *menus;
    NSArray *menuIcons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    menus = [[NSArray alloc] initWithObjects:@"Featured", @"All present articles", @"Coming Soon.", @"Coming Soon.", nil];
    
    menuIcons = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"Featured.png"], [UIImage imageNamed:@"AllArticles.png"], [UIImage imageNamed:@"empty.jpeg"], [UIImage imageNamed:@"empty.jpeg"], nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        FeaturedViewController *f = (FeaturedViewController *)[storyboard instantiateViewControllerWithIdentifier:@"theFeature"];
        [self.navigationController pushViewController:f animated:YES];
        
    }
    else if(indexPath.row == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AllArticlesViewController *allArticles = (AllArticlesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"allArticlesView"];
        
        [self.navigationController pushViewController:allArticles animated:YES];
    }
    else if(indexPath.row == 2)
        NSLog(@"Hello this is 3");
    else if(indexPath.row == 3)
        NSLog(@"Hello this is 4");
}
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menus count];
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 134;
}
- (UITableViewCell *)tableView:(nonnull UITableView *)tv cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    const NSString *identifier = @"menuCells";
    MenuTableViewCell *cell = (MenuTableViewCell *)[tv dequeueReusableCellWithIdentifier:@"menuCells" forIndexPath:indexPath];
    
    tv.separatorColor = [UIColor lightGrayColor];
    cell.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    cell.title.textColor = [UIColor whiteColor];
    cell.title.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.title.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
    cell.title.layer.shadowOpacity = 1.0f;
    cell.title.layer.shadowRadius = 1.0f;
    cell.title.text = [menus objectAtIndex:indexPath.row];
    cell.title.layer.masksToBounds = YES;
    cell.title.layer.cornerRadius = 6.0;
    cell.imageView.image = [menuIcons objectAtIndex:indexPath.row];
    cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.imageView.layer.borderWidth = 1.0f;
    cell.title.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 6.0;
    
    return cell;
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
