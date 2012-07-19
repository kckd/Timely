//
//  TMYViewController.h
//  Timely
//
//  Created by Casey Cady on 7/15/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMYTimer.h"

@interface TMYTimerViewController : UIViewController <UITextFieldDelegate>
// Because our font isn't monospaced, we want to control each digit seperately to retain that
// old-school LED feel.
@property (weak, nonatomic) IBOutlet UILabel *OneMinuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *TenMinuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *TenSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *OneSecondLabel;
@property (weak, nonatomic) IBOutlet UIButton *StartStopButton;
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;

@property (nonatomic, retain) TMYTimer *timer;


- (IBAction)onStartStopButtonTouched:(id)sender;
- (IBAction)onResetButtonTouched:(id)sender;

@end
