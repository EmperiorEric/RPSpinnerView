//
//  RPSpinner.m
//  RPSpinnerDemo
//
//  Created by Ryan Poolos on 5/19/12.
//  Copyright (c) 2012 Frozen Fire Studios. All rights reserved.
//

#import "RPSpinner.h"

@implementation RPSpinner

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);

    
    NSLog(@"Center: %@",NSStringFromCGPoint(self.center));
    NSLog(@"Frame: %@",NSStringFromCGRect(self.frame));
    
    CGRect center = CGRectMake((self.frame.size.width/2.0)-1.0, (self.frame.size.height/2.0)-1.0, 2.0, 2.0);
    
    CGContextFillEllipseInRect(context, center);
    
    CGRect rim = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    
    CGContextStrokeEllipseInRect(context, rim);
}


@end
