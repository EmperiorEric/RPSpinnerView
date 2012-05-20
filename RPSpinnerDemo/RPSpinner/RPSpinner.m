//
//  RPSpinner.m
//  RPSpinnerDemo
//
//  Created by Ryan Poolos on 5/19/12.
//  Copyright (c) 2012 Frozen Fire Studios. All rights reserved.
//

#import "RPSpinner.h"

@implementation RPSpinner

@synthesize delegate;
@synthesize datasource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        radius = (self.frame.size.width/2.0);
        
        dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:dragGesture];
        
        cells = [NSMutableArray array];
        
        RPSpinnerCell *cellA = [[RPSpinnerCell alloc] initWithFrame:CGRectMake((self.frame.size.width/2.0)-10, 0, 20, 20)];
        [cellA setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:cellA];
        [cells addObject:cellA];
        
//        RPSpinnerCell *cellB = [[RPSpinnerCell alloc] initWithFrame:CGRectMake(self.frame.size.width-20, (self.frame.size.height/2.0)-10, 20, 20)];
//        [cellB setBackgroundColor:[UIColor blueColor]];
//        [self addSubview:cellB];
//        [cells addObject:cellB];
//        
//        RPSpinnerCell *cellC = [[RPSpinnerCell alloc] initWithFrame:CGRectMake((self.frame.size.width/2.0)-10, self.frame.size.height-20, 20, 20)];
//        [cellC setBackgroundColor:[UIColor orangeColor]];
//        [self addSubview:cellC];
//        [cells addObject:cellC];
//        
//        RPSpinnerCell *cellD = [[RPSpinnerCell alloc] initWithFrame:CGRectMake(0, (self.frame.size.height/2.0)-10, 20, 20)];
//        [cellD setBackgroundColor:[UIColor greenColor]];
//        [self addSubview:cellD];
//        [cells addObject:cellD];
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

- (CGPoint)convertPointToQuadrant:(CGPoint)point
{
    // center 150,150 = 0,0
    
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    x -= radius;
    y = y * -1;
    y += radius;
    
    return CGPointMake(x, y);
}

- (CGPoint)convertPointToCoodinate:(CGPoint)point
{
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    x += radius;
    y -= radius;
    y = y * -1;
    
    return CGPointMake(x, y);
}

- (CGFloat)checkQuadrantofPoint:(CGPoint)point
{
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    if (x > 0) { // If X is positive its either Quadrant I or IV
        if (y > 0) { // If X is positive and Y is Positive its Quadrant I
            NSLog(@"Quadrant I");
            return 1.0;
        } else { // If X is positive and Y is negative its Quadrant IV
            NSLog(@"Quadrant IV");
            return 4.0;
        }
    } else { // Else X is negative its either Quadrant II or III
        if (y > 0) { // If X is negative and Y is Positive its Quadrant II
            NSLog(@"Quadrant II");
            return 2.0;
        } else { // If X is negative and Y is negative its Quadrant III
            NSLog(@"Quadrant III");
            return 3.0;
        }
    }
}

- (void)rotateCellsByDegrees:(CGFloat)angle
{
    [self rotateCellsByRadians:angle*(M_PI/180)];
}

- (void)rotateCellsByRadians:(CGFloat)angle
{
    // For each cell we need to calculate its new position based on the rotation.
    
//    NSLog(@"\n\n\n");
    
    for (RPSpinnerCell *cell in cells) {
        // Save the cell's original center
        CGPoint originalCenter = cell.center;
        CGPoint quadrantCenter = [self convertPointToQuadrant:originalCenter];

//        NSLog(@"Original Center: %@",NSStringFromCGPoint(originalCenter));
//        NSLog(@"Quadrant Center: %@",NSStringFromCGPoint(quadrantCenter));
        
//        [self checkQuadrantofPoint:quadrantCenter];
        
//        NSLog(@"Radius: %f",sqrt(powf(quadrantCenter.x, 2.0) + powf(quadrantCenter.y, 2.0)));
        
        float originalAngle = atan(quadrantCenter.y/quadrantCenter.x);
        
        NSLog(@"Original Angle: %f (%f)",originalAngle,originalAngle*(180/M_PI));
        NSLog(@"Angle to Add: %f (%f)",angle,angle*(180/M_PI));
                
        angle += originalAngle;

        NSLog(@"New Angle: %f (%f)",angle,angle*(180/M_PI));
        
        CGFloat deltaX = cosf(angle) * radius;
        CGFloat deltaY = sinf(angle) * radius;
        
        // Create the new center
        CGPoint newCenter = CGPointMake(deltaX, deltaY);
        
//        NSLog(@"New Quadrant Center: %@",NSStringFromCGPoint(newCenter));
//        NSLog(@"New Coordinate Center: %@",NSStringFromCGPoint([self convertPointToCoodinate:newCenter]));
        
        // Set the cell's new center
//        [UIView animateWithDuration:1.0 animations:^(){
            cell.center = [self convertPointToCoodinate:newCenter];
//        }];
        
//        NSLog(@"\n\n\n");

    }
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
//            NSLog(@"Gesture Began");
            
            originalTouch = [gesture translationInView:self];
            
            [self.delegate viewWillSpin];
        } break;
            
        case UIGestureRecognizerStateChanged: {
//            NSLog(@"Gesture Moved");
        
            CGPoint newTouch = [gesture translationInView:self];
            
            float diff = originalTouch.x - newTouch.x;
//            NSLog(@"Translation X: %f",diff);
            [self rotateCellsByDegrees:diff];

            
            originalTouch = [gesture translationInView:self];
                        
        } break;
            
        case UIGestureRecognizerStateEnded: {
            CGFloat magnitude = sqrtf(([gesture velocityInView:self].x * [gesture velocityInView:self].x) + ([gesture velocityInView:self].y * [gesture velocityInView:self].y));
            
//            [self rotateCellsByDegrees:magnitude];
//            
//            NSLog(@"Gesture Ended With Velocity Magnitude: %f",magnitude);
            [self.delegate viewDidSpin];
        } break;
        
        case UIGestureRecognizerStateCancelled: {
            NSLog(@"Gesture Cancelled");
        } break;
            
        case UIGestureRecognizerStateFailed: {
            NSLog(@"Gesture Failed");
        } break;
            
        default:
            break;
    }
}

@end
