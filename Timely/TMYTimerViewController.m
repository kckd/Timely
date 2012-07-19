//
//  TMYViewController.m
//  Timely
//
//  Created by Casey Cady on 7/15/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimerViewController.h"
#import "TMYTimers.h"

@interface TMYTimerViewController ()

@end

@implementation TMYTimerViewController
@synthesize OneMinuteLabel;
@synthesize TenMinuteLabel;
@synthesize TenSecondLabel;
@synthesize OneSecondLabel;
@synthesize StartStopButton;
@synthesize NameTextField;
@synthesize timer;

#define UPDATE_INTERVAL 1.0/10 // 10ms

NSTimer *uiUpdateTimer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!timer)
    {
        if ([[TMYTimers timers] count] > 0)
        {
            timer = [[TMYTimers timers] objectAtIndex:0];
        } else
        {
            timer = [[TMYTimer alloc] init];
            [[TMYTimers timers] addObject:timer];
        }
    }
    
    if (timer.running)
    {
        [self startTimer];
    } else
    {
        [self updateTimer];
    }

    NameTextField.text = timer.name;
    
    if (![timer.name length])
    {
        [NameTextField becomeFirstResponder]; // Puts the cursor in the name field and shows the keyboard if there is no name set.

    }
}

- (void)viewDidUnload
{
    [self setOneMinuteLabel:nil];
    [self setTenMinuteLabel:nil];
    [self setTenSecondLabel:nil];
    [self setOneSecondLabel:nil];
    [self setStartStopButton:nil];
    [self setNameTextField:nil];
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
    int minutes = timer.interval/60;
    int seconds = timer.interval-minutes;
    
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
    if (!timer.running) {
        [self startTimer];
    } else {
        [self stopTimer];
    }
    [TMYTimers saveTimers];
    
    
}

- (IBAction)onResetButtonTouched:(id)sender {
    [self stopTimer];
    [timer resetTimer];
    [TMYTimers saveTimers];
    self.TenMinuteLabel.text = 
    self.OneMinuteLabel.text = 
    self.TenSecondLabel.text = 
    self.OneSecondLabel.text = @"0";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length) {
        [textField resignFirstResponder]; //to hide keyboard
        return YES;
    }
    
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.text.length) {
        return YES;
    }
    
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    timer.name = textField.text;
    
}

@end
