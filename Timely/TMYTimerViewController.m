//
//  TMYViewController.m
//  Timely
//
//  Created by Casey Cady on 7/15/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimerViewController.h"
#import "TMYTimers.h"
#import "TMYAppDelegate.h"

@interface TMYTimerViewController ()

@property (nonatomic,retain) NSTimer *uiUpdateTimer;

@end

@implementation TMYTimerViewController
@synthesize OneMinuteLabel;
@synthesize TenMinuteLabel;
@synthesize TenSecondLabel;
@synthesize OneSecondLabel;
@synthesize StartStopButton;
@synthesize NameTextField;
@synthesize timer;
@synthesize uiUpdateTimer;

@synthesize testLabel;
@synthesize colon;

#define UPDATE_INTERVAL 1.0/10 // 10ms

NSString *test;
NSString *test2;

- (void)viewDidLoad
{
    [super viewDidLoad];
 
   //This would change the font to apple gothic with size 17
   //self.OneMinuteLabel.font = [UIFont fontWithName:@"AppleGothic" size:17.0];
                                
                                
    //This would set the view (not the timerview) background
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgtest2.png"]];
    
    //self.view.backgroundColor=[UIColor blueColor];
      
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TMYAppDelegate *appDelegate = (TMYAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    test = [NSString stringWithFormat:@"%@",appDelegate.data];
    
    testLabel.text=test;
    
    
    if ([testLabel.text isEqualToString:@"Black"]){
        self.OneMinuteLabel.textColor=[UIColor blackColor];
        self.OneSecondLabel.textColor=[UIColor blackColor];
        self.TenMinuteLabel.textColor=[UIColor blackColor];
        self.TenSecondLabel.textColor=[UIColor blackColor];
        self.colon.textColor = [UIColor blackColor];
        
    }
    
    if ([testLabel.text isEqualToString:@"Red"]){
        self.OneMinuteLabel.textColor=[UIColor redColor];
        self.OneSecondLabel.textColor=[UIColor redColor];
        self.TenMinuteLabel.textColor=[UIColor redColor];
        self.TenSecondLabel.textColor=[UIColor redColor];
        self.colon.textColor = [UIColor redColor];
        
    }
    
    if ([testLabel.text isEqualToString:@"Purple"]){
        self.OneMinuteLabel.textColor=[UIColor purpleColor];
        self.OneSecondLabel.textColor=[UIColor purpleColor];
        self.TenMinuteLabel.textColor=[UIColor purpleColor];
        self.TenSecondLabel.textColor=[UIColor purpleColor];
        self.colon.textColor = [UIColor purpleColor];
        
    }
    
    if ([testLabel.text isEqualToString:@"Green"]){
        self.OneMinuteLabel.textColor=[UIColor greenColor];
        self.OneSecondLabel.textColor=[UIColor greenColor];
        self.TenMinuteLabel.textColor=[UIColor greenColor];
        self.TenSecondLabel.textColor=[UIColor greenColor];
        self.colon.textColor = [UIColor greenColor];
        
    }

    

  TMYAppDelegate *appDelegateTres = (TMYAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    test2 = [NSString stringWithFormat: @"%@", appDelegateTres.data2];
    
    
    
    if ([test2 isEqualToString:@"Black"])
    {
        self.view.backgroundColor=[UIColor blackColor];
    }
    if ([test2 isEqualToString:@"Blue"])
    {
        self.view.backgroundColor=[UIColor blueColor];
    }
    if ([test2 isEqualToString:@"Orange"])
    {
        self.view.backgroundColor=[UIColor orangeColor];
    }
    if ([test2 isEqualToString:@"Purple"])
    {
        self.view.backgroundColor=[UIColor purpleColor];
    }
    
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
    
    if (timer.name) {
        NameTextField.text = timer.name;
    }
    
    
    if (![timer.name length])
    {
        [NameTextField becomeFirstResponder]; // Puts the cursor in the name field and shows the keyboard if there is no name set.
        
    }
    
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [NameTextField resignFirstResponder];
}


- (void)viewDidUnload
{
    [self setOneMinuteLabel:nil];
    [self setTenMinuteLabel:nil];
    [self setTenSecondLabel:nil];
    [self setOneSecondLabel:nil];
    [self setStartStopButton:nil];
    [self setNameTextField:nil];
    [self setColon:nil];
    [self setTestLabel:nil];
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
    int seconds = (int)timer.interval%60;

    
    self.TenMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes/10];
    self.OneMinuteLabel.text = [NSString stringWithFormat:@"%d",minutes%10];
    self.TenSecondLabel.text = [NSString stringWithFormat:@"%d",seconds/10];
    self.OneSecondLabel.text = [NSString stringWithFormat:@"%d",seconds%10];
}

-(void)startTimer
{
    [self.StartStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    
    [timer startTimer];
    
    self.uiUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
}

-(void)stopTimer
{
    [self.StartStopButton setTitle:@"Start" forState:UIControlStateNormal];

    [self.uiUpdateTimer invalidate];
    self.uiUpdateTimer = nil;
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


- (void)textFieldDidEndEditing:(UITextField *)textField {
    timer.name = textField.text;
    
    [TMYTimers saveTimers];
    
}

@end
