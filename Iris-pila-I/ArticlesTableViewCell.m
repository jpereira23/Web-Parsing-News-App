//
//  ArticlesTableViewCell.m
//  Iris-pila
//
//  Created by Jeffery Pereira on 7/26/15.
//  Copyright © 2015 Jeffery Pereira. All rights reserved.
//

#import "ArticlesTableViewCell.h"

@implementation ArticlesTableViewCell

@synthesize imageView = _imageView;
@synthesize label = _label;

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    CGRect rectangle = CGRectMake(0, 180, 404, 30);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGContextFillRect(context, rectangle);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
