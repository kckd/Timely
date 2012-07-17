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
@synthesize StartStopButton;
@synthesize startTime;
@synthesize timer;

#define UPDATE_INTERVAL 1.0/10 // 10ms

BOOL timerRunning = NO;
NSTimeInterval interval = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setOneMinuteLabel:nil];
    [self setTenMinuteLabel:nil];
    [self setTenSecondLabel:nil];
    [self setOneSecondLabel:nil];
    [self setStartStopButton:nil];
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
    
    NSTimeInterval currentInterval = [currentTime timeIntervalSinceDate:startTime];
    
    currentInterval += interval;
    
    int minutes = currentInterval/60;
    int seconds = currentInterval-minutes;
    
    self.TenMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes/10];
    self.OneMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes%10];
    self.TenSecondLabel.text = [NSString stringWithFormat:@"%d",seconds/10];
    self.OneSecondLabel.text = [NSString stringWithFormat:@"%d",seconds%10];
}

-(void)startTimer
{
    self.StartStopButton.titleLabel.text = @"Stop";
    
    startTime = [NSDate date];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
    timerRunning = YES;
}

-(void)stopTimer
{
    self.StartStopButton.titleLabel.text = @"Start";
    [timer invalidate];
    timer = nil;
    interval += [[NSDate date] timeIntervalSinceDate:startTime];
    startTime = nil; // Mostly defensive
    timerRunning = NO;
}

- (IBAction)onStartStopButtonTouched:(id)sender
{
    if (!timerRunning) {
        [self startTimer];
    } else {
        [self stopTimer];
    }
}
@end
