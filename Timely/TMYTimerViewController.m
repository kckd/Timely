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
@synthesize timer;

#define UPDATE_INTERVAL 1.0/10 // 10ms

NSTimer *uiUpdateTimer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    timer = [[TMYTimer alloc] init];
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
    int minutes = timer.Interval/60;
    int seconds = timer.Interval-minutes;
    
    self.TenMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes/10];
    self.OneMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes%10];
    self.TenSecondLabel.text = [NSString stringWithFormat:@"%d",seconds/10];
    self.OneSecondLabel.text = [NSString stringWithFormat:@"%d",seconds%10];
}

-(void)startTimer
{
    [self.StartStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    [timer startTimer];
    
    uiUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
}

-(void)stopTimer
{
    [self.StartStopButton setTitle:@"Start" forState:UIControlStateNormal];

    [uiUpdateTimer invalidate];
    uiUpdateTimer = nil;
    [timer stopTimer];
}

- (IBAction)onStartStopButtonTouched:(id)sender
{
    if (!timer.Running) {
        [self startTimer];
    } else {
        [self stopTimer];
    }
}

- (IBAction)onResetButtonTouched:(id)sender {
    [self stopTimer];
    [timer resetTimer];
    self.TenMinuteLabel.text = 
    self.OneMinuteLabel.text = 
    self.TenSecondLabel.text = 
    self.OneSecondLabel.text = @"0";
}
@end
