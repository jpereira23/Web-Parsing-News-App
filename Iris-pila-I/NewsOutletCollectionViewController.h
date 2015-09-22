//
//  NewsOutletCollectionViewController.h
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/25/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h" 

@interface NewsOutletCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
