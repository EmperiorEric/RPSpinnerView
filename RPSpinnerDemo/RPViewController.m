//
//  RPViewController.m
//  RPSpinnerDemo
//
//  Created by Ryan Poolos on 5/19/12.
//  Copyright (c) 2012 Frozen Fire Studios. All rights reserved.
//

#import "RPViewController.h"

@interface RPViewController ()

@end

@implementation RPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    RPSpinner *spinner = [[RPSpinner alloc] initWithFrame:CGRectMake(10.0, 80.0, 300.0, 300.0)];
    
    [self.view addSubview:spinner];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
