//
//  TMYViewController.m
//  Timely
//
//  Created by Casey Cady on 7/15/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimerViewController.h"

@interface TMYTimerViewController ()

@end

@implementation TMYTimerViewController
@synthesize OneMinuteLabel;
@synthesize TenMinuteLabel;
@synthesize TenSecondLabel;
@synthesize OneSecondLabel;
@synthesize startTime;
@synthesize timer;

#define UPDATE_INTERVAL 1.0/10 // 10ms

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self startTimer];
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

-(void)updateTimer
{
    NSDate *currentTime = [NSDate date];
    
    NSTimeInterval interval = [currentTime timeIntervalSinceDate:startTime];
    
    int minutes = interval/60;
    int seconds = interval-minutes;
    
    self.TenMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes/10];
    self.OneMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes%10];
    self.TenSecondLabel.text = [NSString stringWithFormat:@"%d",seconds/10];
    self.OneSecondLabel.text = [NSString stringWithFormat:@"%d",seconds%10];
}

-(void)startTimer
{
    startTime = [NSDate date];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
    
}

@end
