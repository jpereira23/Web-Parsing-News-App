//
//  MenuTableViewCell.m
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/26/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

@synthesize imageView = _imageView;
@synthesize title = _title;

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //CGRect rectangle = CGRectMake(0, 0, 375, 5);
    CGRect rectangle1 = CGRectMake(0, 129, 414, 5);
    CGRect rectangle2 = CGRectMake(160, 40, 210, 60);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    //CGContextFillRect(context, rectangle);
    CGContextFillRect(context, rectangle1);
    CGContextFillRect(context, rectangle2);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
