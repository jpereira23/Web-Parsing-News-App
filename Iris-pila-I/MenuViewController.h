//
//  MenuViewController.h
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/25/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeaturedViewController.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *menuName;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) FeaturedViewController *fv;



@end
