//
//  RPSpinner.h
//  RPSpinnerDemo
//
//  Created by Ryan Poolos on 5/19/12.
//  Copyright (c) 2012 Frozen Fire Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RPSpinnerCell.h"

@protocol RPSpinnerDatasource <NSObject>

@end

@protocol RPSpinnerDelegate <NSObject>

@optional

- (void)viewWillSpin;
- (void)viewDidSpin;

@end

@interface RPSpinner : UIView
{
    @private
    
    UIPanGestureRecognizer *dragGesture;
    NSMutableArray *cells;
    
    CGFloat radius;
}

@property (weak, nonatomic) id <RPSpinnerDelegate> delegate;
@property (weak, nonatomic) id <RPSpinnerDatasource> datasource;

@end
