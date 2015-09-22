//
//  NewsOutletCollectionViewController.m
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/25/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "NewsOutletCollectionViewController.h"
#import "NewsOutletCollectionViewCell.h"
#import "MenuViewController.h"
#import "WebPageWork.h" 
#import "Article.h"

@interface NewsOutletCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *articles;

@end

@implementation NewsOutletCollectionViewController
{
    NSMutableArray *newsOutlets;
}

static NSString * const reuseIdentifier = @"NewsOutlet";

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if([app isCoreDataEmpty])
    {
        [app initializeCoreData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    newsOutlets = [[NSMutableArray alloc] init];
    [newsOutlets addObject:@"O Jogo"];
    for(int i = 0; i < 3; i++)
    {
        [newsOutlets addObject:@"Coming Soon..."];
    }
    
     [self.collectionView registerNib:[UINib nibWithNibName:@"NewsOutletCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NewsOutlet"];
    self.collectionView.backgroundColor = [UIColor darkGrayColor];
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

#pragma mark <UICollectionViewDataSource>

- (void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MenuViewController *menu = (MenuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"theMenu"];
        [self.navigationController pushViewController:menu animated:YES];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [newsOutlets count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(180.0, 275.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsOutletCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"NewsOutlet" forIndexPath:indexPath];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsOutletCollectionViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.newsOutletTitle.text = [newsOutlets objectAtIndex:indexPath.row];
    
    if([cell.newsOutletTitle.text isEqualToString:@"O Jogo"])
        cell.imageView.image = [UIImage imageNamed:@"OJogo.gif"];
    else
        cell.imageView.image = [UIImage imageNamed:@"ComingSoon.png"];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 6;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 3.0f;
    cell.newsOutletTitle.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    cell.newsOutletTitle.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
