//
//  TMYActualTimerViewController.m
//  Timely
//
//  Created by Matthew Phillips on 9/29/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYActualTimerViewController.h"
#import "TMYActualTimers.h"
#import "TMYAppDelegate.h"


@interface TMYActualTimerViewController ()

@property (nonatomic,retain) NSTimer *auiUpdateTimer;


@end

@implementation TMYActualTimerViewController

@synthesize HoursLabel;
@synthesize MinutesLabel;
@synthesize SecondsLabel;
@synthesize hoursTitle;
@synthesize minutesTitle;
@synthesize secondsTitle;
@synthesize colonOne;
@synthesize colonTwo;


@synthesize StartStopButton;
@synthesize ResetButton;

@synthesize NameTextField;

@synthesize actualTimer;
@synthesize auiUpdateTimer;

@synthesize HoursStepper;
@synthesize MinutesStepper;
@synthesize SecondsStepper;

int valueHours;
int valueMinutes;
int valueSeconds;

int hours;
int minutes;
int seconds;

@synthesize testLabel;

NSString *test;
NSString *test2;


#define UPDATE_INTERVAL 1.0/10 //10ms


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgtest2.png"]];
    //we are doing these steps in viewWillAppear so that ANY settings changes take effect
    
    if (!actualTimer)
    {
        if ([[TMYActualTimers actualTimers] count] > 0)
        {
            actualTimer = [[TMYActualTimers actualTimers] objectAtIndex:0];
        } else
        {
            actualTimer = [[TMYActualTimer alloc] init];
            [[TMYActualTimers actualTimers] addObject:actualTimer];
        }
    }
    
    if (actualTimer.running)
    {
        [self startActualTimer];
    } else
    {
        [self updateActualTimer];
    }
    
    NameTextField.text =  actualTimer.name;
    
    if (![actualTimer.name length])
    {
        [NameTextField becomeFirstResponder]; // Puts the cursor in the name field and shows the keyboard if there is no name set.
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidUnload
{
    [self setHoursLabel:nil];
    [self setMinutesLabel:nil];
    [self setSecondsLabel:nil];
    [self setStartStopButton:nil];
    [self setNameTextField:nil];
    [self setHoursStepper:nil];
    [self setMinutesStepper:nil];
    [self setSecondsStepper:nil];
    [self setSecondsPicker:nil];
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


-(void)updateActualTimer
{
    self.MinutesLabel.text = [NSString stringWithFormat:@"%3d",minutes];
    self.SecondsLabel.text = [NSString stringWithFormat:@"%3d",seconds];
    self.HoursLabel.text = [NSString stringWithFormat:@"%3d",hours];
    
    if (actualTimer.running)
    {
        NSTimeInterval interval = [actualTimer.endDate timeIntervalSinceDate:[NSDate date]];
        if (interval <= 0) {
            SecondsStepper.value=0;
            MinutesStepper.value=0;
            HoursStepper.value=0;
            hours=minutes=seconds=0;
            [self stopActualTimer];
            [self alertMessage];
            return;
        }
        
        if (interval > 60) {
            minutes = (int)interval/60;
            if (minutes > 60) {
                hours = minutes/60;
                minutes = minutes%60;
            }
        }
        seconds = (int)interval%60;
    }
    
}


-(void)alertMessage
{
    NSString *message = @"Notice:";
    message = [message stringByAppendingString:@" Timer Completed"];

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:actualTimer.name message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
}

-(void)startActualTimer
{
    
    
    if (hours>0 || minutes>0 || seconds>0)
    {
    [self.StartStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        
        [actualTimer startActualTimer];
    
    self.auiUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL
                                                          target:self
                                                        selector:@selector(updateActualTimer)
                                                        userInfo:nil
                                                repeats:YES];
    }
    else {
        [self alertMessageAddTime];
        [self stopActualTimer];
        [actualTimer resetActualTimer];
        [TMYActualTimers saveActualTimers];
        SecondsStepper.value=0;
        MinutesStepper.value=0;
        HoursStepper.value=0;
        seconds=0;
        minutes=0;
        hours=0;
        self.MinutesLabel.text =[NSString stringWithFormat:@"%3d",minutes];
        self.HoursLabel.text =[NSString stringWithFormat:@"%3d", hours];
        self.SecondsLabel.text =[NSString stringWithFormat:@"%3d", seconds];

    
    }

}



-(void)alertMessageAddTime
{
    NSString *message = @"Please Add More Time to the Timer before starting.";
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Notice" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
}

-(void)stopActualTimer
{
    [self.StartStopButton setTitle:@"Start" forState:UIControlStateNormal];
    
    [self.auiUpdateTimer invalidate];
    self.auiUpdateTimer = nil;
    [actualTimer stopActualTimer];
}


-(IBAction)onHoursStepperTouched:(UIStepper *)sender
{
    valueHours = sender.value;
    self.HoursLabel.text = [NSString stringWithFormat:@"%3d", valueHours];
    hours=valueHours;
    actualTimer.endInterval = (hours*60*60)+(minutes*60)+seconds;
  }

-(IBAction)onMinutesStepperTouched:(UIStepper *)sender
{
    valueMinutes = sender.value;
    self.MinutesLabel.text = [NSString stringWithFormat:@"%3d", valueMinutes];
    minutes=valueMinutes;
    actualTimer.endInterval = (hours*60*60)+(minutes*60)+seconds;
}

-(IBAction)onSecondsStepperTouched:(UIStepper *)sender
{
    valueSeconds = sender.value;
    self.SecondsLabel.text = [NSString stringWithFormat:@"%3d", valueSeconds];
    seconds=valueSeconds;
    actualTimer.endInterval = (hours*60*60)+(minutes*60)+seconds;
}
- (IBAction)onStartStopButtonTouched:(id)sender
{
    if (!actualTimer.running) {
        [self startActualTimer];
    } else {
        [self stopActualTimer];
    }
    [TMYActualTimers saveActualTimers];
}

- (IBAction)onResetButtonTouched:(id)sender {
    [self stopActualTimer];
    [actualTimer resetActualTimer];
    [TMYActualTimers saveActualTimers];
    SecondsStepper.value=0;
    MinutesStepper.value=0;
    HoursStepper.value=0;
    seconds=0;
    minutes=0;
    hours=0;
    self.MinutesLabel.text =[NSString stringWithFormat:@"%3d",minutes];
    self.HoursLabel.text =[NSString stringWithFormat:@"%3d", hours];
    self.SecondsLabel.text =[NSString stringWithFormat:@"%3d", seconds];   
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
    actualTimer.name = textField.text;
    
    [TMYActualTimers saveActualTimers];
    
}


#pragma mark -
#pragma mark Picker View Data Source & Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
