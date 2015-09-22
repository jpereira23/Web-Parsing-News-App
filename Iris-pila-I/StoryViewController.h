//
//  StoryViewController.h
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/25/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "AppDelegate.h"

@interface StoryViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UITextView *story;
@property NSInteger i;

- (void)getInteger:(NSInteger)integer;

@end
