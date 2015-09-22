//
//  AllArticlesViewController.h
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/26/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h" 

@interface AllArticlesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;



@end
