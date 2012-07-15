//
//  TMYViewController.m
//  Timely
//
//  Created by Casey Cady on 7/15/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYViewController.h"

@interface TMYViewController ()

@end

@implementation TMYViewController
@synthesize OneMinuteLabel;
@synthesize TenMinuteLabel;
@synthesize TenSecondLabel;
@synthesize OneSecondLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setOneMinuteLabel:nil];
    [self setTenMinuteLabel:nil];
    [self setTenSecondLabel:nil];
    [self setOneSecondLabel:nil];
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
