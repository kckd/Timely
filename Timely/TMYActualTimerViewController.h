//
//  TMYActualTimerViewController.h
//  Timely
//
//  Created by Matthew Phillips on 9/29/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMYActualTimer.h"
#import "TMYAppDelegate.h"

@interface TMYActualTimerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *HoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *MinutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *SecondsLabel;

@property (weak, nonatomic) IBOutlet UIButton *StartStopButton;
@property (weak, nonatomic) IBOutlet UIButton *ResetButton;

@property (weak, nonatomic) IBOutlet UITextField *NameTextField;

@property (nonatomic, retain) TMYActualTimer *actualTimer;

@property (weak, nonatomic) IBOutlet UIStepper *HoursStepper;
@property (weak, nonatomic) IBOutlet UIPickerView *secondsPicker;

@property (weak, nonatomic) IBOutlet UIStepper *MinutesStepper;

@property (weak, nonatomic) IBOutlet UIStepper *SecondsStepper;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@property (weak, nonatomic) IBOutlet UILabel *hoursTitle;
@property (weak, nonatomic) IBOutlet UILabel *minutesTitle;

@property (weak, nonatomic) IBOutlet UILabel *secondsTitle;
@property (weak, nonatomic) IBOutlet UILabel *colonOne;
@property (weak, nonatomic) IBOutlet UILabel *colonTwo;



-(IBAction)onSecondsStepperTouched:(id)sender;
-(IBAction)onMinutesStepperTouched:(id)sender;
-(IBAction)onHoursStepperTouched:(id)sender;
-(IBAction)onStartStopButtonTouched:(id)sender;
-(IBAction)onResetButtonTouched:(id)sender;

@end


